import './scss/Bootstrap' // application.scss の読み込み
import React from 'react';
import ReactDOM from 'react-dom';
import BootstrapTable from 'react-bootstrap-table-next';
import 'react-bootstrap-table2-filter/dist/react-bootstrap-table2-filter.min.css';
import filterFactory, { textFilter, Comparator ,selectFilter } from 'react-bootstrap-table2-filter';
import paginationFactory from 'react-bootstrap-table2-paginator';


//import { TableHeaderColumn } from 'react-bootstrap-table';
//import { Button } from 'react-bootstrap';
class BootstrapTableclass extends React.Component {
  render() {
    return (
  <BootstrapTable keyField='id' data={ showrecords() } columns={ showfields() } filter={ filterFactory()} 
    remote={ {  filter: true,    pagination: true,    filter: true,    sort: true,    cellEdit: true  } }
    pagination={ paginationFactory({
      page:1, // Specify the current page. It's necessary when remote is enabled
      sizePerPage:5, // Specify the size per page. It's necessary when remote is enabled
      totalSize:10, // Total data size. It's necessary when remote is enabled
      pageStartIndex: 1, // first page will be 0, default is 1
      paginationSize: 5,  // the pagination bar size, default is 5
      sizePerPageList: [5,50 , {    text: 'all', value: 1000  }], 
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
      onPageChange: (page, sizePerPage) => {}, // callback function when page was changing
      onSizePerPageChange: (sizePerPage, page) => {}, // callback function when page size was changing
    }) } 
//  tableStyle={ { border: 'black 2px solid' } } containerStyle={ { border: 'black 2px solid' } } headerStyle={ { border: 'black 2px solid' } }
    />)
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <BootstrapTableclass  />,
    document.getElementById('screen_id')
  )
});
