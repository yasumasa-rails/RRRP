import React , { Component } from 'react';
import {RaisedButton} from 'material-ui';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import ScreenContents from '../../components/ScreenContents';

class ScreenGroup extends React.Component {
  constructor(props)
    {
    super(props); 
    }                      
    render() {    
      const cates = this.props.cates;
      return(
        <MuiThemeProvider >
          {cates.map((cate,idx) =>   //showMenuNames screens/index
            <ScreenContents key={idx} linex={idx.toString()} cates={cate[1]} />
                )     
                }  
          </MuiThemeProvider>
          )
    }    
}
export default ScreenGroup;