import React from 'react';
import RaisedButton from 'material-ui/RaisedButton';
import ReactTooltip from 'react-tooltip'

//Override the inline-styles of the root element.
const style = {margin: 2,height:20,minWidth: 125,maxWidth: 125,marginbefore:0};
const buttonstyle = {margin:0};
const overlaystyle = {height:20,backgroundColor: '#A1887F'} ; //http://www.material-ui.com/#/customization/colors
const labelstyle = {textoverflow:'clip'}
class Catemenus extends React.Component {
  render() { 
   /*   let catemenus = showMenuNames().map((cate,idx) =>   //showMenuNames screens/index
        <MenuLists key={idx} cates={cate[1]} />
      ); */
      return(<div >
        {showMenuNames().map((cate,idx) =>   //showMenuNames screens/index
         <MenuLists key={idx} linex={idx.toString()} cates={cate[1]} />
          )}
        </div>
      );
    }   
  }     

function openScreen(screen_id){window.open("../screens?sid="+screen_id,'',"dependent=yes");}  
class MenuLists extends React.Component {
  constructor(props) {
    super(props); 
  } 
    render() {    
      const cate = this.props.cates;
      const line = this.props.linex;
      return(<div class='buttonlineheight'>
       {cate.map((val,index) =>
      // Correct! Key should be specified inside the array.
      <span  key={index}>
      <a data-tip data-for={line + index.toString()} >
        <RaisedButton label={val[0]}
         onClick={ () => openScreen(val[1])} 
          style={style} buttonStyle={buttonstyle} overlayStyle={overlaystyle}  labelStyle={labelstyle}/> 
        <ReactTooltip id={line+index.toString()} place='bottom' type='dark' effect='float' >
        <span>## {val[2]} ##</span>
        </ReactTooltip >
        </a>
       </span>
       )}
      </div>
      )
    }
}
class RaisedButtonMenu extends React.Component {
  render() { 
    return (<div><Catemenus /></div>
      ); 
  }
}
export default RaisedButtonMenu;