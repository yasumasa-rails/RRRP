import React from 'react';
import ReactDOM from 'react-dom';
import BootstrapTable from 'react-bootstrap-table-next';
//import { TableHeaderColumn } from 'react-bootstrap-table';
//import { Button , ButtonToolbar,Tooltip,OverlayTrigger} from 'react-bootstrap';    
import './scss/Bootstrap' // application.scss の読み込み  

class BootstrapTabletest extends React.Component {
  render() {
    return ( 
        <BootstrapTable keyField='id' data={ showrecords() } columns={ showfields() } bordered={ true }/>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <BootstrapTabletest  />,
    document.getElementById('screen_id')
  )
});
