import React from 'react';
import { connect } from 'react-redux'
import ReactTable from 'react-table'
import "react-table/react-table.css"
import {ScreenParamsSet,ScreenRequest,FetchRequest,InputFieldProtect} from '../actions'
import ButtonList from './buttonlist'
import   '../index.css' 
import * as Yup from 'yup'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.

const renderEditable = (cellInfo )=> {
  return (
    <div
      contentEditable
      suppressContentEditableWarning      
      dangerouslySetInnerHTML={{ __html: cellInfo.value }}
    />
  );
}

const renderNonEditable = (cellInfo)=> {
  return (
    <div
      dangerouslySetInnerHTML={{ __html: cellInfo.value  }}
    />
  );
}

function editableColumns(columns){
  let temp =[]
  /* columns.map((val,index) =>{ 
      if(val["Cell"] === 'renderEditable'){val["Cell"] = eval("renderEditable")}
      else{val["Cell"] = eval("renderNonEditable")}
       return   temp.push(val)
  }) */
  columns.map((val,index) =>{ 
      if(val["classname"] === 'renderEditable'){val["Cell"] = renderEditable }
      else{val["calssname"] = renderNonEditable}
       return   temp.push(val)
  })
  return temp}   
function noneditableColumns(columns){
  let temp =[]
  columns.map((val,index) =>{ 
    val["Cell"] = renderNonEditable
     return   temp.push(val)
    }) 
  return temp}   



class ScreenGrid extends React.Component {

  render() {
    const {screenCode, pageSize,
            page, filtered,  sorted,
            handleScreenParamsSet,columns,data,pages,params,
            handleScreenRequest,handleScreenLineEditRequest,
            token,client,uid, screenName,handleFetchRequest,handleInputFieldProtect,
            editableflg,
            } = this.props
    
    let lineIndex = 99999999
    let rowIndexCheck = true
  
      let schema = Yup.object().shape({
        itm_expiredate:Yup.date().default(function() { return new Date(2099,12,31)}),
        itm_code:Yup.string().required(), 
        unit_code:Yup.string().required()
       })
       
 
      let onValite = (state) =>schema.validate({
          itm_expiredate:state.data[lineIndex].itm_expiredate,
          itm_code:state.data[lineIndex].itm_code,
          unit_code:state.data[lineIndex].unit_code,
          }).then(function(value){if(!state.data[lineIndex].itm_expiredate){ state.data[lineIndex].itm_expiredate = value.itm_expiredate}
            handleScreenLineEditRequest(screenCode, pageSize,lineIndex,token,client,uid,screenName,state.data[lineIndex],pages)})
           .catch(function(err){alert(err.name&&err.errors)})
      let tcolumns=screenCode&&editableflg?editableColumns(columns):noneditableColumns(columns)           

   //   let fetchSchema  = (params) =>handleFetchRequest(params)

    return(
    <div>
    {screenCode?
      <ReactTable
      page={page}
      pages={pages}  //
      pageSize={pageSize}  //
      data={data?data:[]} // should default to [] / 
      columns={tcolumns}
      //filtered={filtered}
      //sorted={sorted}
      manual // informs React Table that you'll be handling sorting and pagination server-side

      onFetchData={( state,instance) => {                 
                    handleScreenParamsSet(state)  
      }}  
       
      filterable={true}
      
      className="-striped -highlight" //-striped  奇数行、偶数行色分け　 -highlight：マウスがヒットした時の色の強調
       style={{
       height: "800px" // This will force the table body to overflow and scroll, since there is not enough room
       }}

      getTrProps={(state, rowInfo, column, instance)  => {
        return {
          onClick: (e, handleOriginal) => {
            params["req"]==="viewtablereq"&&(e.currentTarget.style.backgroundColor = 'green')
                
        }}
      }}

      getTdProps={(state, rowInfo, column, instance) => {
        return {
          onKeyPress:(e) =>
             {e.currentTarget.style.backgroundColor = "#5F81f5" }  ,
          onBlur:(e) =>
             {if(state.resolvedData[rowInfo.index][column.id]===e.target.textContent)
                {e.currentTarget.style.backgroundColor = "#7F81a5"} 
              data[rowInfo.index][column.id] = e.target.textContent
              lineIndex = rowInfo.index   
              rowIndexCheck = false
              if(state.resolvedData[rowInfo.index][column.id]!==e.target.textContent&&column.id==="unit_code"){// editableflg = false
                                        handleInputFieldProtect(columns) 
                                        let params = {}
                                         params["fetchcode"] = {[column.id]:e.target.textContent}
                                         params["screenCode"] = screenCode
                                         params["rowInfo"] = rowInfo
                                         handleFetchRequest(params,token,client,uid)}} ,
          onFocus:(e) =>
              {e.currentTarget.style.backgroundColor = "#aF81f5"
                if( rowInfo.index!==lineIndex&&lineIndex!== 99999999&&
                    state.resolvedData[lineIndex]!==data[lineIndex])
                    { 
                      onValite(state)      
                    }
                rowIndexCheck = true
              } ,
          }
        }
      }
      
      getProps={(state) => {      //  fillterの時もイベントが発生する。
          return {
             onFocus:(e) =>
                  {if( rowIndexCheck===false&&lineIndex!== 99999999&&state.resolvedData[lineIndex]!==data[lineIndex])
                    { 
                      onValite(state) 
                      rowIndexCheck = true}} , 
          //  onBlur:(e) =>
           //       {handleScreenParamsSet(state) } ,
             onKeyPress:(e) =>{
                            if(e.key==="Enter"&& params["req"]==="viewtablereq"){
                              handleScreenRequest(screenCode,page,pageSize,lineIndex,token,client,uid,screenName,filtered,)
                            }}
                            }
                   }      
        }
      
      onPageChange={(pageIndex) => {     
        handleScreenRequest(screenCode,pageIndex,pageSize,lineIndex,token,client,uid,screenName,filtered,)
         } 
        } 
        
      onPageSizeChange={(pageSize, pageIndex) => {      
        handleScreenRequest(screenCode,pageIndex,pageSize,lineIndex,token,client,uid,screenName,filtered,)
         } 
        } 
    
     >                       

      {(state, makeTable, instance) => {
        return (
                <div
                  style={{
                  borderRadius: "5px",  overflow: "hidden", padding: "5px"
                  }}
                >     
        {makeTable()}
        <ButtonList/>
        </div>
        );
      }}
      </ReactTable>
        :"please select"}
        </div>
       )
    }
  }
const  mapStateToProps = (state) => {
  return {  uid:state.login.auth?state.login.auth.uid:"",
            token:state.login.auth?state.login.auth["access-token"]:"",
            client:state.login.auth?state.login.auth.client:"",
            buttonflg:state.button?state.button.buttonflg:"",  
            screenCode:state.screen.screenCode,
            screenName:state.screen.screenName,
            columns:state.screen.columns?state.screen.columns:[],
            params:state.screen.params?state.screen.params:{},
            data:state.screen.data,
            pages:state.screen.pages,
            page:state.screen.page,
            pageSize:state.screen.pageSize,
            sorted:state.screen.sorted,
            filtered:state.screen.filtered,
            editableflg:state.screen.editableflg,
            }
}
   

const mapDispatchToProps = (dispatch,ownProps ) => ({
    handleScreenParamsSet:  (state) =>{
                            dispatch(ScreenParamsSet(state))},                    
    handleScreenLineEditRequest:  (screenCode, pageSize,lineIndex,token,client,uid,screenName,linedata,pages) =>{
                            let  params= {screenCode:screenCode,lineIndex:lineIndex,uid:uid,linedata:linedata,
                                          pageSize:pageSize,req:"updateGridLineData",pages:pages,}
                           dispatch(ScreenRequest(params, token, client, uid,screenName))},
    handleScreenRequest:  (screenCode,page, pageSize,lineIndex,token,client,uid,screenName,filtered) =>{
                            let  params= {screenCode:screenCode,lineIndex:lineIndex,uid:uid,
                                 page:page,pageSize:pageSize,req:"viewtablereq",filtered:filtered}
                            dispatch(ScreenRequest(params, token, client, uid,screenName))},
    handleFetchRequest:  (params,token,client,uid) =>{ params["req"] = "fetch_request"
                                      dispatch(FetchRequest(params,token,client,uid))},
    handleInputFieldProtect:  (columns) =>{
                              const temp =[]
                              columns.map((val,index) =>{ 
                                     if(val["classneme"] === "renderEditable"){val["Cell"] = renderNonEditable}                                                   
                                        return   temp.push(val)}) 
                              dispatch(InputFieldProtect())},
                      })   
export default connect(mapStateToProps,mapDispatchToProps)(ScreenGrid)
