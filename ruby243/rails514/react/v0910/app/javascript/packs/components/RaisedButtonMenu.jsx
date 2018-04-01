import React from 'react';
import RaisedButton from 'material-ui/RaisedButton';
import ReactTooltip from 'react-tooltip'

//Override the inline-styles of the root element.
const style = {margin: 2,height:20,minWidth: 125,maxWidth: 125,marginbefore:0};
const buttonstyle = {margin:0};
const overlaystyle = {height:20,backgroundColor: '#A1887F'} ; //http://www.material-ui.com/#/customization/colors
const labelstyle = {textoverflow:'clip'}
class RaisedButtonExampleSimple extends React.Component {
  render() {
    function Catemenus() {
      let catemenus = showMenuNames().map((cate,idx) =>
        <span key={idx} >
        <MenuLists key={idx} value={cate[1]} />
        </span>
      );
      return(<span >
        {catemenus}
        </span>
      );
    }       
    function MenuLists(props) {   
      let menuLists = props.value.map((val,index) =>
      // Correct! Key should be specified inside the array.
      <span key={index}>
        <a data-tip data-for={props.idx+index.toString()}>
        <RaisedButton label={val[0]}  style={style} buttonStyle={buttonstyle} overlayStyle= {overlaystyle}  labelStyle={labelstyle}/>
        <ReactTooltip id={props.idx+index.toString()} place='bottom' type='dark' effect='float' >
        <span>##{val[2]}##</span>
        </ReactTooltip >
        </a>
       </span>
      );
      return(<p class='buttonlineheight'>
        {menuLists}
        </p>
      );
    }
      return (<div><Catemenus /></div>
      );
  }
}
export default RaisedButtonExampleSimple;