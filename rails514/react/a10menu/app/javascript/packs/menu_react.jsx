import React from 'react';
import ReactDOM from 'react-dom';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import RaisedButtonMenu from './components/RaisedButtonMenu';
 
const Menu = () => (
    <MuiThemeProvider>
      <RaisedButtonMenu/>
    </MuiThemeProvider>
);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Menu  />,
    document.getElementById('menu')
  )
});
