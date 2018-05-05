// with es6
const data = [ ... ];
//...
remote(remoteObj) {
    // Only cell editing, insert and delete row will be handled by remote store
    remoteObj.cellEdit = true;
    remoteObj.insertRow = true;
    remoteObj.dropRow = true;
    return remoteObj;
  }
  
  trClassFormat(row, rowIndex) {
    // row is the current row data
    return rowIndex % 2 === 0 ? "tr-odd" : "tr-even";  // return class name.
  }
// 
isExpandableRow(row) {
    if (row.id < 2) return true;
      else return false;
  }
  
expandComponent(row) {
    return (
    );
  }

  expandColumnComponent({ isExpandableRow, isExpanded }) {
    let content = '';

    if (isExpandableRow) {
      content = (isExpanded ? '(-)' : '(+)' );
    } else {
      content = ' ';
    }
    return (
      <div> { content } </div>
    );
  }

  /*row is the row data which you wanted to select or unselect.    
   isSelectedis a boolean value which means "whether or not that row will be selected?".  
   eventis the event target object.*/
  handleRowSelect(row, isSelected, e) { "" //
  }
  
  // read only
render() {
    const fetchInfo = { dataTotalSize: 100 //
                       };
    const selectRow = {
                        clickToExpand: true ,  // Trigger expand and selection together
                        bgColor: function(row, isSelect) {
                          if (isSelect) {
                            const { id } = row;
                            if (id < 2) return 'blue';
                            else if (id < 4) return 'red';
                            else return 'yellow';
                          }
                          return null;
                        },
                        onSelect: this.handleRowSelect
                      };
    return (
            <BootstrapTable data={ data }　columnFilter keyField='account'　
                expandableRow={ this.isExpandableRow }   expandComponent={ this.expandComponent }  expandColumnOptions={ { xpandColumnVisible: true,expandColumnComponent: this.expandColumnComponent, columnWidth: 50}}
                trClassName={ this.trClassFormat } tableHeaderClass='my-custom-class' scrollTop={ 'Bottom' }
                remote={ true } pagination={ true }   fetchInfo={ fetchInfo }   multiColumnSort={ 2 } height='120px'　 maxHeight='120px'>
                <TableHeaderColumn dataField='account'>Account</TableHeaderColumn>
                <TableHeaderColumn dataField='name'>Name</TableHeaderColumn>
            </BootstrapTable>
    );
}


//create edit delete
handleTableComplete() {
  ""// ...
}
handleDeletedRow(rowKeys) {
  ""// ...
}
handleInsertedRow(row) {
  ""// ...
}
render() {
    const selectRow = {     mode: 'checkbox',  // multi select    --> mode: 'radio'  // single select
                            clickToExpand: true ,  // Trigger expand and selection together
                            bgColor: function(row, isSelect) {
                              if (isSelect) {
                                const { id } = row;
                                if (id < 2) return 'blue';
                                else if (id < 4) return 'red';
                                else return 'yellow';
                              }
                              return null;
                            },
                            selected: [ 'row1', 'row3' ],
                            onSelect: this.handleRowSelect
                       };
    const fetchInfo = { dataTotalSize: 100 //
                       };
    const options = {
                        afterTableComplete: this.handleTableComplete,rail
                        afterInsertRow: this.handleInsertedRow,
                        afterDeleteRow: this.handleDeletedRow
                      };
    return (
            <BootstrapTable data={ data }　insertRow deleteRow　 selectRow={ selectRow } options={ options }
                columnFilter keyField='account'　
                expandableRow={ this.isExpandableRow }   expandComponent={ this.expandComponent }  expandColumnOptions={ { xpandColumnVisible: true,expandColumnComponent: this.expandColumnComponent, columnWidth: 50}}
                trClassName={ this.trClassFormat } tableHeaderClass='my-custom-class' scrollTop={ 'Bottom' }
                remote={ true } pagination={ true }   fetchInfo={ fetchInfo }   multiColumnSort={ 2 } height='120px'　 maxHeight='120px'>
                <TableHeaderColumn dataField='account'>Account</TableHeaderColumn>
                <TableHeaderColumn dataField='name'>Name</TableHeaderColumn>
            </BootstrapTable>
    );
}
