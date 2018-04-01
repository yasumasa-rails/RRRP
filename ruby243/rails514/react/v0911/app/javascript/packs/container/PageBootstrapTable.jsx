import React from 'react';
import ReactDOM from 'react-dom';
import BootstrapTable from 'react-bootstrap-table-next';
import 'react-bootstrap-table-next/dist/react-bootstrap-table2.min.css';
// import paginationFactory from 'react-bootstrap-table2-paginator';    //not find 'react-bootstrap-table2-paginator' by yarn add
import filterFactory, { textFilter, Comparator } from 'react-bootstrap-table2-filter';

    // pagination.page specify the current page when table render.
    // pagination.sizePerPage specify the current size per page when table render.
    // pagination.totalSize
    // pagination.sizePerPageList is Default size per page have 10, 25, 30, 50.
    const showdata =  showdata();
    const showfields = showfields();
    const RemoteAll = ({ data, page, sizePerPage, onTableChange, totalSize }) => (
      <div>
        <BootstrapTable
          remote={ { pagination: true , filter: true, sort: true } }
          keyField="id"
          data={ showdata.data }
          columns={ showfields.columns }
          filter={ filterFactory() }
          pagination={ paginationFactory({ page, sizePerPage, totalSize ,sizePerPageList}) }
          onTableChange={ onTableChange }
        />
      //  <Code>{ sourceCode }</Code>
      </div>
    );
    RemoteAll.propTypes = {
      data: PropTypes.array.isRequired,
      page: PropTypes.number.isRequired,
      totalSize: PropTypes.number.isRequired,
      sizePerPage: PropTypes.number.isRequired,
      onTableChange: PropTypes.func.isRequired
    };
class PageBootstrapTable2 extends React.Component {
      constructor(props) {
        super(props);
        this.state = {
          page: showfields.page,
          data: showdata.data,
          totalSize: showdata.data.length,
          sizePerPage: showfields.sizePerPage
        };
        this.handleTableChange = this.handleTableChange.bind(this);
      }
    
      handleTableChange = (type, { page, sizePerPage, filters ,data}) => {
        const currentIndex = (page - 1) * sizePerPage;
        setTimeout(() => {
          const resultFilter = data.filter((row) => {
            let valid = true;
            for (const dataField in filters) {
              const { filterVal, filterType, comparator } = filters[dataField];
    
              if (filterType === 'TEXT') {
                if (comparator === Comparator.LIKE) {
                  valid = row[dataField].toString().indexOf(filterVal) > -1;
                } else {
                  valid = row[dataField] === filterVal;
                }
              }
              if (!valid) break;
            }
            return valid;
          }); 
          let resultSort;
          if (sortOrder === 'asc') {
            result = data.sort((a, b) => {
              if (a[sortField] > b[sortField]) {
                return 1;
              } else if (b[sortField] > a[sortField]) {
                return -1;
              }
              return 0;
            });
          } else {
            result = data.sort((a, b) => {
              if (a[sortField] > b[sortField]) {
                return -1;
              } else if (b[sortField] > a[sortField]) {
                return 1;
              }
              return 0;
            });
          }
          this.setState(() => ({
            page,
            data: {filer: resultFilter,sort: resultSort},
            sizePerPage
          }));
        }, 2000);
      }
    
  render() {  
        const { data, sizePerPage, page } = this.state;
        return (
          <RemoteAll
            data={ data }
            page={ page }
            sizePerPage={ sizePerPage }
            totalSize={ this.state.totalSize }
            onTableChange={ this.handleTableChange }
          />
        );
      }        
}
export default PageBootstrapTable;