import React from 'react';
import ReactDOM from 'react-dom';
//import { TableHeaderColumn } from 'react-bootstrap-table';
import { Button , ButtonToolbar,Tooltip,OverlayTrigger} from 'react-bootstrap';  
import axios from 'axios';
//import MapsFormFields from './container/CreateFormFields';
//import '../packs/scss/Bootstrap.scss' ;// application.scss の読み込み
import BootstrapTable from 'react-bootstrap-table-next'; 
import filterFactory, { textFilter, Comparator ,selectFilter } from 'react-bootstrap-table2-filter';
import paginationFactory from 'react-bootstrap-table2-paginator'; 
import { onErrorResumeNext } from 'rxjs/observable/onErrorResumeNext';
class BootstrapTableinit extends React.Component {
    constructor(props) {
        super(props);
        this.state = {sid:this.props.sid,page: this.props.page,sizePerPage: this.props.sizePerPage,
                        sizePerPageList: this.props.sizePerPageList, totalCnt:  this.props.total_cnt,
                        screenName:  this.props.screenName,
                        datashowfields:this.props.datashowfields,
                        from:"",to:"",
                        datashowrecords: []}
        this.showPagination = this.showPagination.bind(this);
        this.showForm = this.showForm.bind(this);
        this.onTableChange = this.onTableChange.bind(this);
        this.customTotal = this.customTotal.bind(this);
    }
    showPagination(page,sizePerPage){
        axios.get("../screens/pagination", { params:{sid:this.state.sid, 
                                                    keynewState:{page:page,sizePerPage:sizePerPage}}})
        .then(res => {this.setState(() =>{return{datashowrecords:res.data.datashowrecords,totalCnt:res.data.total_cnt
                                                    ,from:res.data.from,to:res.data.to}}
                                        );
         });
    }


    showForm(){document.addEventListener('DOMContentLoaded', () => {
        ReactDOM.render(
          <MapsFormFields  datashowrecords={this.state.datashowrecords} datashowfields={this.state.datashowfields} />,
          document.getElementById('form_id')
        )
      });}

    onTableChange = (type, {page,sizePerPage}) => {
        switch(type){
        case "filter":
        case "pagination":
                this.showPagination(page,sizePerPage);    
        case "sort":
                this.setState(() => ({page:page,sizePerPage:sizePerPage}));
            break;
        case "cellEdit":
          break;
        default:
        }  
                            
    }
        
       customTotal = (from, to, size)=>function(){return(
        <span className="react-bootstrap-table-pagination-total">
        Total: { size } 
        </span>
        );}
    render() {
        const   CPagination = ({data,page,sizePerPage,sizePerPageList,totalCnt,fieldList,onTableChange,from,to}) =>(
            <BootstrapTable keyField='id' data={  data } columns={ fieldList } filter={ filterFactory()} 
                remote={ {  pagination: true,    filter: true,    sort: true,    cellEdit: true  } }
                 onTableChange={ onTableChange } 
                pagination={ paginationFactory({
                page:page, // Specify the current page. It's necessary when remote is enabled
                currSizePerPage:sizePerPage, 
                // Specify the size per page. It's necessary when remote is enabled
                sizePerPage:sizePerPage, // Specify the size per page. It's necessary when remote is enabled
                totalSize:totalCnt, // Total data size. It's necessary when remote is enabled
                pageStartIndex: 0, // first page will be 0, default is 1
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
                showTotal:true,
                })
                } 
                >
                </BootstrapTable> 
             );
        const wellStyles = {maxWidth: 400, margin: '0 auto 0px'};
        const tooltip = (
            <Tooltip id="tooltip">
            <strong>Holy guacamole!</strong> 
            </Tooltip>
        );

        let fieldList = this.state.datashowfields.map((datashowfield,id) =>{if(datashowfield["hidden"]==false){
                                                                            datashowfield["filter"] =  textFilter()};
                                                                            return datashowfield});
                                                                   
    return ( 
        <ButtonToolbar>
        <Button bsStyle="primary" type="submit" onClick={()=>this.showPagination(1,this.state.sizePerPage)} >search   </Button> 
        <Button bsStyle="primary" type="submit" onClick={this.showForm} > Form </Button> 
        <Button bsStyle="primary">add</Button>
            <p style={wellStyles} id="#screen_top">
            <OverlayTrigger placement="top" overlay={tooltip}>
                <Button bsStyle="link"  bsSize="lg" type="button">
                    {this.state.screenName}
                </Button>
            </OverlayTrigger>
            </p>
            <CPagination
                data={ this.state.datashowrecords }
                page={ this.state.page }
                sizePerPage={ this.state.sizePerPage }
                sizePerPageList={ this.state.sizePerPageList }
                totalCnt={ this.state.totalCnt }
                fieldList={fieldList}
                onTableChange={ this.onTableChange} 
            />
        </ButtonToolbar>
    )
  }
}

export default BootstrapTableinit;
