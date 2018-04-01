import React from 'react';
import ReactDOM from 'react-dom';
import BootstrapTable from 'react-bootstrap-table-next';
import 'react-bootstrap-table-next/dist/react-bootstrap-table2.min.css';
// import paginationFactory from 'react-bootstrap-table2-paginator';
//import filterFactory, { textFilter, Comparator } from 'react-bootstrap-table2-filter';

class BootstrapTable2class extends React.Component {
  render() {
    // pagination.page specify the current page when table render.
    // pagination.sizePerPage specify the current size per page when table render.
    // pagination.totalSize
    // pagination.sizePerPageList is Default size per page have 10, 25, 30, 50.
    const showdata =  showdata();
    const showfields = showfields();
    const RemoteAll = ({ data, page, sizePerPage, onTableChange, totalSize }) => (
      <div>
        <BootstrapTable
          remote={ { pagination: true , filter: true, sort: true,cellEdit: true  } }
          keyField="id"
          data={ showdata.data }
          columns={ showfields.columns }
          filter={ filterFactory() }
          pagination={ paginationFactory({ page, sizePerPage, totalSize ,sizePerPageList}) }
          cellEdit={ cellEditFactory({
            mode: 'click',
            blurToSave: true
          }) }
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
    class Container extends React.Component {
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
    
      handleTableChange = (type, { page, sizePerPage, filters ,data, cellEdit: { rowId, dataField, newValue }}) => {
        const currentIndex = (page - 1) * sizePerPage;
        setTimeout(() => {
          const result = data.filter((row) => {
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
          this.setState(() => ({
            page,
            data: result,
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
    
  }
}
  
export default BootstrapTable2class;