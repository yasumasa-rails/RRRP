//https://material-ui.com/api/button/
//https://codesandbox.io/s/5mwn3wk0yx
import React  from 'react';
import Button from '@material-ui/core/Button';
import PropTypes from 'prop-types';
import ReactTooltip from 'react-tooltip';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider'

class ScreenContents extends React.Component {
  constructor(props) {
    super(props); 
    this.state = {style : {margin: 2,height:20,minWidth: 125,maxWidth: 125,marginbefore:0},
                  buttonstyle : {margin:0,height:20,backgroundColor: '#A1887F'},
                  overlaystyle : {height:20,backgroundColor: '#C1C1C1'} ,
                  labelstyle : {textoverflow:"…"},
                  modal: true, 
    }   
  } 
             
  render() {     
      const contents = this.props.contents; 
  
      return(
          <span data-tip data-for={contents.linex.toString()} > 
          <MuiThemeProvider  >
          <Button label={contents.name} 
           primary="true"   children={contents.name}  color="primary"   variant="outlined"
           href={`/screens/show?sid=${contents.screen_id}` }
          style={this.state.style} /> 
          </MuiThemeProvider>
          <ReactTooltip id={contents.linex.toString()} place='bottom' type='dark' effect='solid' >
          <span>## {contents.remark} ##</span>
          </ReactTooltip >
          </span>
      )
    }
}
    

export default ScreenContents;
