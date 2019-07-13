import React from 'react';
import { connect } from 'react-redux'
import ReactTable from 'react-table'
import "react-table/react-table.css"
import {ScreenParamsSet,ScreenRequest,FetchRequest,
  //InputFieldProtect, ScreenErrSet,
  ScreenErrCheck,} from '../actions'
import ButtonList from './buttonlist'
import   '../index.css' 
import {yupschema} from '../yupschema'
import Tooltip from 'react-tooltip-lite';
//import * as Yup from 'yup'
// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.

const renderEditable = (cellInfo )=> {
  return (
   // <Tooltip content={cellInfo.row.gridmessage[cellInfo.column.id]?cellInfo.row.gridmessage[cellInfo.column.id]:""}
    <Tooltip content={cellInfo.row.gridmessage===""?"":cellInfo.row.gridmessage?
                      cellInfo.row.gridmessage[cellInfo.column.id]?cellInfo.row.gridmessage[cellInfo.column.id]:"":""}
                      type={cellInfo.row.gridmessage===""?"":cellInfo.row.gridmessage?
                      cellInfo.row.gridmessage[cellInfo.column.id]?"error":"":""}
                      border={true} 
       tagName="span" arrowSize={5}>
    <div
      className={cellInfo.column.className}
      contentEditable
      suppressContentEditableWarning      
      dangerouslySetInnerHTML={{ __html: cellInfo.value }}
    />
    </Tooltip>
  );
}


const renderNonEditable = (cellInfo)=> {
  return (
    <div
      className={cellInfo.column.className}
      dangerouslySetInnerHTML={{ __html: cellInfo.value  }}   
      style={{
        //width: `${cellInfo.value?cellInfo.value.length*0.5:5}px`,
        width: 'auto',
      }}   
    />
  );
}

const renderCheckbox = (cellInfo)=> {
  return (    
    <Tooltip content={cellInfo.row.gridmessage===""?"":cellInfo.row.gridmessage?
                      cellInfo.row.gridmessage[cellInfo.column.id]?cellInfo.row.gridmessage[cellInfo.column.id]:"":""}
       tagName="span" arrowSize={2}>
          <input
            type="checkbox"  className="checkbox"
          />
    </Tooltip>
  );
}



function editableColumns(columns){
  let temp =[]
  
  columns.map((val,index) =>{ 
      if(val["className"])
        {switch(true){
                case /renderEditable/.test(val["className"]):
                  val["Cell"] = renderEditable
                  break
                case /checkbox/.test(val["className"]):
                    val["Cell"] = renderCheckbox
                    break
                default:    
                    val["Cell"] = renderNonEditable
                 }
        }   
      return   temp.push(val)
  })    

  return   temp   
}   
/*
function noneditableColumns(columns){
  let temp =[]
  columns.map((val,index) =>{ 
    if(val["className"].match(/renderEditable/)){val["Cell"] = renderNonEditable}
     return   temp.push(val)
    }) 
  return temp}  
 */
  
//  let errmsgs ={}

class ScreenGrid extends React.Component {

  render() {
    const {screenCode, pageSize,filterable,
            page, loading,handleScreenParamsSet,
// sorted,handleErrorMsg,handleErrorset,handleScreenLineEditRequest,
            columns,data,pages,params,  //params railsに渡すパラメータを兼ねている。
            handleScreenRequest,handleValite,
            uid, handleFetchRequest,
            sizePerPageList,yup,buttonflg,
            } = this.props
    
    //let rowIndexCheck = true
    let Yup = require('yup')

    let fieldSchema = field =>{
      let tmp ={}
      tmp[field] = yupschema[screenCode][field]
      return(
       Yup.object(
         tmp
      ))}

  /*
     */
     let onLineValite = (data,index,field,params) =>
     {
      let screenSchema = Yup.object().shape(yupschema[screenCode])
      handleValite(screenSchema,data,index,field,params)
    }
     
     let onFieldValite = (data,index,field) =>
          {let schema =  fieldSchema(field)
           handleValite(schema,data,index,field,params)}
     /*
*/
    //let tcolumns=params.req!=="viewtablereq"?editableColumns(columns):columns   
    let tcolumns=editableColumns(columns)   
    //let filtered =[]
    return(
    <div>
    {screenCode?
      <ReactTable
      page={page}
      pages={pages}  //
      defaultPageSize={sizePerPageList[0]}
      pageSize={pageSize}  //
      data={data}
      loading={loading}
      columns={tcolumns}
      pageSizeOptions={sizePerPageList}
      //filtered={filtered}
      //sorted={sorted}
      manual // informs React Table that you'll be handling sorting and pagination server-side

      defaultFiltered={params?params["filtered"]?params["filtered"]:[]:[]}
      filterable={filterable}
      
      className="-striped -highlight" //-striped  奇数行、偶数行色分け　 -highlight：マウスがヒットした時の色の強調
      
      style={buttonflg!=="export"?{ height: "800px" ,width:"2380px" }:{height:"200px"}}
       // This will force the table body to overflow and scroll, since there is not enough room
      
      getTrProps={(state, rowInfo, column, instance)  => {
        return {}
      }}

      getTdProps={(state, rowInfo, column, instance) => {
        return { 
          onFocus:(e) =>
            {  
            e.target.className = "renderEditableInput"
            if( data[rowInfo.index].confirm&&column.id==="confirm")
                { params["uid"] = uid
                  onLineValite(data,rowInfo.index,"confirm",params)  } 
          } ,
          onClick:(e) =>
             { 
             if(e.target.checked&&column.id==="confirm")
                  { params["uid"] = uid
                    onLineValite(data,rowInfo.index,"confirm",params) //
                  }
          }  ,
          onBlur:(e) =>            
             {if(state.data[rowInfo.index][column.id]===e.target.textContent && e.target.className !== "checkbox")
                {e.target.className = "renderEditableNotChange"} 
               else{if(e.target.className !== "renderEditableError" && e.target.className !== "checkbox"){e.target.className = "renderEditable"} }
              
              if(state.resolvedData[rowInfo.index][column.id]!==e.target.textContent&&yup.yupfetchcode[column.id]){// 
                                        data[rowInfo.index][column.id]=e.target.textContent
                                        let params = {}
                                         params["fetchcode"] = {[column.id]:e.target.textContent}
                                         params["screenCode"] = screenCode
                                         params["resolvedData"] =  JSON.stringify(data[rowInfo.index])
                                         params["index"] = rowInfo.index 
                                         params["fetchview"] = yup.yupfetchcode[column.id]
                                         params["uid"] =uid 
                                         handleFetchRequest(params)
                                         }
              else{if(column.id!=="confirm"){　data[rowInfo.index][column.id] = e.target.textContent
                                              onFieldValite(data,rowInfo.index,column.id,params)}}  ///screenCode,Name null                          
             } ,
          }
        }
      }
      
      getProps={(reacttablestate) => {      //  fillterの時もイベントが発生する。
          return {
             onKeyPress:(e) =>{
                            if(e.key==="Enter"&& params["req"]==="viewtablereq"){
                              params["filtered"] = reacttablestate.filtered
                              handleScreenRequest(params,page,pageSize)
                            }}

                            
                            }
                   }      
        }
      onPageChange={(pageIndex) => {      
        handleScreenRequest(params,pageIndex,pageSize,params["filtered"])
           } }
      onPageSizeChange={(pageSize, pageIndex) => {      
        handleScreenRequest(params,pageIndex,pageSize,params["filtered"])
         } 
        } 
      onFilteredChange={(filtered, column) => {
        params["filtered"] = filtered
        handleScreenParamsSet(params)}} 
    >                       

      {(state, makeTable, instance) => {
        return (
          <div>     
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
            buttonflg:state.button?state.button.buttonflg:"",  
            screenCode:state.screen.params?state.screen.params.screenCode:"",
            screenName:state.screen.params?state.screen.params.screenName:"",
            columns:state.screen.columns?state.screen.columns:[],
            params:state.screen.params?state.screen.params:{},
            data:state.screen.data?state.screen.data:[],
            pages:state.screen.pages,
            page:state.screen.page,
            pageSize:state.screen.pageSize,
            sorted:state.screen.sorted,
            sizePerPageList:state.screen.sizePerPageList?state.screen.sizePerPageList:[25],
            yup:state.screen.yup,
            loading:state.screen.loading,
            filterable:state.screen.filterable
            }
}
   
const mapDispatchToProps = (dispatch,ownProps ) => ({
    handleScreenParamsSet:  (params) =>{
                            dispatch(ScreenParamsSet(params))},                    
    handleScreenLineEditRequest:  (screenCode, pageSize,index,uid,screenName,linedata,pages,sizePerPageList) =>{
                            let  params= {screenCode:screenCode,screenName:screenName,
                                          index:index,uid:uid,linedata:linedata,
                                          pageSize:pageSize,req:"updateGridLineData",pages:pages,sizePerPageList:sizePerPageList}
                           dispatch(ScreenRequest(params))},
    handleScreenRequest:  (params,page,pageSize) =>{
                            params = {...params,page:page,pageSize:pageSize}
                            dispatch(ScreenRequest(params))},
    handleFetchRequest:  (params) =>{ params["req"] = "fetch_request"
                                      dispatch(FetchRequest(params))},
    handleValite:  (schema,data,index,field,params) =>{ 
                           dispatch(ScreenErrCheck(schema,data,index,field,params))},


                      })   
export default connect(mapStateToProps,mapDispatchToProps)(ScreenGrid)
