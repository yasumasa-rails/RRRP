import React from 'react';
import ReactDOM from 'react-dom';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import RaisedButtonMenu from './components/RaisedButtonMenu';
//import getMuiTheme from 'material-ui/styles/getMuiTheme';
 
//const muiTheme = getMuiTheme({
//  button: {
//    lineheight: 10,   //
//    height: 20,   //buton.height
//    padding: 3,
//  },
//});

const Menu = () => (
//    <MuiThemeProvider muiTheme={muiTheme}>
    <MuiThemeProvider >
      <RaisedButtonMenu />
    </MuiThemeProvider>
);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Menu  />,
    document.getElementById('menu')
  )
});
