import React from 'react';
import ReactDOM from 'react-dom';
import BootstrapTable from 'react-bootstrap-table-next';
//import { TableHeaderColumn } from 'react-bootstrap-table';
import { Button , ButtonToolbar,Tooltip,OverlayTrigger} from 'react-bootstrap';      
import filterFactory, { textFilter, Comparator ,selectFilter } from 'react-bootstrap-table2-filter';
import paginationFactory from 'react-bootstrap-table2-paginator'; 
import axios from 'axios';
class PageBootstrapTable extends React.Component {
    constructor(props) {
        super(props);
        this.state = {datashowfields:showfields(),
                      datashowscreenprop : showscreenprop(),
                      datashowrecords: []}
        this.showPagination = this.showPagination.bind(this);
    }
    showPagination(){
        axios.get("../screens/pagination", { params: {sid:this.state.datashowscreenprop.sid, keynewState:onTableChange}})
        .then(res => {this.setState((prevState, props) =>{datashowrecords:res.data.datashowrecords}) ;
                      //this.setState((prevState, props) =>{datashowfields:res.data.datashowfields});
                      this.setState((prevState, props) =>{datashowscreenprop:res.data.datashowscreenprop});
         });
    }
    render() {
        const wellStyles = { maxWidth: 400, margin: '0 auto 0px' };
        const tooltip = (
            <Tooltip id="tooltip">
            <strong>Holy guacamole!</strong> Check this info.
            </Tooltip>
        ); 
        const onTableChange = (type, newState) => {
            switch(type){
            case "filter":
            case "pagination":
            case "sort":
                return {page:newState.page,sizePerPage:newState.sizePerPage,
                                  filters:newState.filters,
                                  sortField:newState.sortField,sortOrder:newState.sortOrder};
                break;
            case "cellEdit":
              break;
            }                                   
        }
        //let datashowrecords = showrecords();
        let sizePerPage = () => {if(onTableChange.sizePerPage){return onTableChange.sizePerPage;}else{return  this.state.datashowscreenprop.sizePerPage;}}
        //let sizePerPage = this.state.datashowscreenprop.sizePerPage;
        let screenCode  = this.state.datashowscreenprop.sid;
        let sizePerPageList = this.state.datashowscreenprop.sizePerPageList;
        sizePerPageList.push({text:'all',value:this.state.datashowscreenprop.total_cnt});
        let fieldList = this.state.datashowfields.map((datashowfield,id) =>{if(datashowfield["hidden"]==false){
                                                                            datashowfield["filter"] =  textFilter()};
                                                                            return datashowfield});
    return (
    <ButtonToolbar>
        <Button bsStyle="primary" type="submit" onClick={this.showPagination} >search</Button>
        <Button bsStyle="primary">add</Button>
        <div style={wellStyles}>
            <OverlayTrigger placement="top" overlay={tooltip}>
                <Button bsStyle="link"  bsSize="lg" type="button">
                    {this.state.datashowscreenprop.screen_name}
                </Button>
            </OverlayTrigger>
        < span>        Total Count :{this.state.datashowscreenprop.total_cnt}</span>
        </div>
    <BootstrapTable keyField='id' data={  this.state.datashowrecords } columns={ fieldList } filter={ filterFactory()} 
    remote={ {  filter: true,    pagination: true,    filter: true,    sort: true,    cellEdit: true  } }
    onTableChange={ onTableChange } noDataIndication = {console.log("input")}
    pagination={ paginationFactory({
      page:this.state.datashowscreenprop.page, // Specify the current page. It's necessary when remote is enabled
      currSizePerPage:sizePerPage.value, 
      // Specify the size per page. It's necessary when remote is enabled
      sizePerPage:sizePerPage.value, // Specify the size per page. It's necessary when remote is enabled
      totalSize:this.state.datashowscreenprop.total_cnt, // Total data size. It's necessary when remote is enabled
      pageStartIndex: 1, // first page will be 0, default is 1
      paginationSize: 5,  // the pagination bar size, default is 5
      sizePerPageList: sizePerPageList, 
      //sizePerPageList: [5,10,{text:'all',value:100}], 
      withFirstAndLast: false, // hide the going to first and last page button
      alwaysShowAllBtns: true, // always show the next and previous page button
      //firstPageText: 'First', // the text of first page button
      prePageText: 'Prev', // the text of previous page button
      nextPageText: 'Next', // the text of next page button
      //lastPageText: 'Last', // the text of last page button
      nextPageTitle: 'Go to next', // the title of next page button
      prePageTitle: 'Go to previous', // the title of previous page button
      //firstPageTitle: 'Go to first', // the title of first page button
      //lastPageTitle: 'Go to last', // the title of last page button
      hideSizePerPage: false, // hide the size per page dropdown
      hidePageListOnlyOnePage: true, // hide pagination bar when only ones page, default is false
    }) } 
    />
    </ButtonToolbar>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <BootstrapTableinit  />,
    document.getElementById('screen_id')
  )
});
