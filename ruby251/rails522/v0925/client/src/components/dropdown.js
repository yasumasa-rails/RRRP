import React from 'react';
import { connect } from 'react-redux'
import {DropDownValueSet} from '../actions'

class DropDown extends React.Component {

  render() {
    const { dropDownValue,dropDownList,handlechange, } = this.props
    try{
        let tmp = JSON.parse(dropDownList[dropDownValue.field])  
        if(dropDownValue.classes.indexOf("renderSelectNonEditable")>-1){
          return(
            <select   name={dropDownValue.field} onChange={(event)=>handlechange(event)} value={dropDownValue.val} disabled >
            <option value="" ></option>
            {tmp?          
               tmp.map((key,index) => 
                  <option value={key.value}  key={index} >{key.label}</option>
               )
             :""} 
            </select>
          ) 

        }
        else{
        return(
          <select   name={dropDownValue.field} onChange={(event)=>handlechange(event)} value={dropDownValue.val}  >
          <option value="" ></option>
            {tmp?          
               tmp.map((key,index) => 
                  <option value={key.value} key={index} >{key.label}</option>
               )
             :""}     
          </select>
        )  
       } 
      }
     catch(error){
      console.log(dropDownValue.field)
      console.log(dropDownList[dropDownValue.field])
      return(
        <select   name={dropDownValue.field}  >
        <option value="" ></option>
        </select>
      )
     } 
    }    
}

const  mapStateToProps = (state) => {
  return {  
    dropDownList:state.screen.dropDownList?state.screen.dropDownList:{}
            }
}
   
const mapDispatchToProps = (dispatch,ownProps ) => ({
  handlechange : (event)=>{
    ownProps.dropDownValue.val = event.target.value
    dispatch(DropDownValueSet(ownProps.dropDownValue))
  }  
                    })   
        
export default connect(mapStateToProps,mapDispatchToProps)(DropDown)
