import React from 'react';
import { connect } from 'react-redux'
import ReactTable from 'react-table'
import "react-table/react-table.css"
import {ScreenParamsSet,ScreenRequest,FetchRequest,
  //InputFieldProtect, ScreenErrSet,
  ScreenErrCheck,} from '../actions'
import ButtonList from './buttonlist'
import DropDown from './dropdown'
import   '../index.css' 
import {yupschema} from '../yupschema'
import Tooltip from 'react-tooltip-lite'
//import Select from 'react-select'
//import * as Yup from 'yup'
// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.


class ScreenGrid extends React.Component {
  render() {
const renderEditable = (cellInfo )=> {
  return (
   // <Tooltip content={cellInfo.row.gridmessage[cellInfo.column.id]?cellInfo.row.gridmessage[cellInfo.column.id]:""}
    <Tooltip  content={cellInfo.row.gridmessage?cellInfo.row.gridmessage[cellInfo.column.id]?
                        cellInfo.row.gridmessage[cellInfo.column.id]:"":""}
              type={cellInfo.row.gridmessage?cellInfo.row.gridmessage[cellInfo.column.id]?"error":"":""}
                      border={true} 
       tagName="span" arrowSize={2}>
    <div
      className={cellInfo.column.className}  //
      contentEditable={true}  //
      suppressContentEditableWarning      
      dangerouslySetInnerHTML={{ __html: cellInfo.value }}  //
    />
    </Tooltip>
  );
}

const renderNonEditable = (cellInfo)=> {
  return (
    <div
      /*className={cellInfo.column.className}*/
      contentEditable={false}
      dangerouslySetInnerHTML={{ __html: cellInfo.value  }}   
    />
  );
}

const renderCheckbox = (cellInfo)=> {
  return (    
    <Tooltip content={cellInfo.row.gridmessage?
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
                case /renderSelect/.test(val["className"]):
                    //val["filterMethod"] = renderSelect
                    val["Cell"] = renderSelectCell
                    val["Filter"] = renderFilter
                    break
                default:    
                    val["Cell"] = renderNonEditable
                 }
        }   
      return   temp.push(val)
  })  
  //temp.push({"headerStyle":{ overflow:"hidden","max-width":"2000px"}})
  return   temp   
}   

const renderSelectCell = (cellInfo)=> {
  return (  
    <DropDown dropDownValue={{val:cellInfo.value,index:cellInfo.index,field:cellInfo.column.id,classes:cellInfo.classes}} />
  );
}
const  renderFilter = ({column,onChange,filter})=> {
  try{
    let val
    return (  
      <select name={column.id}
      onChange={event =>{handleScreenParamsSet(column.id,event.target.value,params)
                         val = event.target.value
                          }}
                         defaultValue={val?val:filter?filter.value:''}>
        <option value="" ></option>
       {       
          JSON.parse(dropDownList[column.id]).map((key,index) => 
            <option value={key.value} key={index}  >{key.label}</option>
         )
       }     
      </select>
    );
   }
  catch(error){
    console.log(dropDownList)
  }　
}

    const {screenCode, pageSize,filterable,
            page, loading,handleScreenParamsSet,
// sorted,handleErrorMsg,handleErrorset,handleScreenLineEditRequest,
            columns,data,pages,params,  //params railsに渡すパラメータを兼ねている。
            handleScreenRequest,handleValite,
            uid, handleFetchRequest,
            sizePerPageList,yup,buttonflg,dropDownList,
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
        Object.keys(data[index]).map((fl)=>{
          if(yup.yupfetchcode[fl]){
            let params = {}
            params["fetchcode"] = {[fl]:data[index][fl]}
            params["screenCode"] = screenCode
            params["data"] =  JSON.stringify(data[index])
            params["index"] = index 
            params["fetchview"] = yup.yupfetchcode[fl]
            params["uid"] =uid 
            handleFetchRequest(params)}
            return params
          })
        if(data[index].gridmessage){
            let state="ok"
            Object.keys(data[index].gridmessage).map((fl)=>{
               if((data[index].gridmessage[fl]===""||data[index].gridmessage[fl]==={})&&state==="ok")
                    {state="ok"}
                else{state="NG"}
                return state
            })
            if(state==="ok"){
                let screenSchema = Yup.object().shape(yupschema[screenCode])
                handleValite(screenSchema,data,index,field,params)
            }
          }    
        else{
          let screenSchema = Yup.object().shape(yupschema[screenCode])
          handleValite(screenSchema,data,index,field,params)
        }      
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

      defaultFiltered={params?params["filtered"]?params["filtered"]:[]:[]}//別の画面で抽出した項目を引き継ぐ
      filterable={filterable}
      
      //className="-striped -highlight" //-striped  奇数行、偶数行色分け　 -highlight：マウスがヒットした時の色の強調
      
      style={buttonflg!=="export"?{ height: "800px" }:{height:"200px"}}
     //style={buttonflg!=="export"?{ height: "800px" ,width:"2380px" }:{height:"200px",width:"2380px"}}
       // This will force the table body to overflow and scroll, since there is not enough room
      
      getTrProps={(state, rowInfo, column, instance)  => {
        if(!params["onClickSelect"]){params["onClickSelect"]={}}
        return {
          onClick: (e, handleOriginal) => {
            if( params["req"]==="viewtablereq"){
              if(params["onClickSelect"]["index"]===null||params["onClickSelect"]["index"]===undefined)
                {
                  e.currentTarget.style.backgroundColor ='green'
                  params["onClickSelect"]["screenCode"]=screenCode
                  params["onClickSelect"]["index"]=rowInfo.index}
              else{if(params["onClickSelect"]["index"]===rowInfo.index&&params["onClickSelect"]["screenCode"]===screenCode)
                    {
                      params["onClickSelect"]["index"]=null
                      e.currentTarget.style.backgroundColor=rowInfo.index % 2 === 0 ? '#f4faf2' :  '#e0ebf8'}
                  else{if(params["onClickSelect"]["screenCode"]===screenCode)
                          {alert(" all ready select  ")}
                      else{
                        e.currentTarget.style.backgroundColor ='green'
                        params["onClickSelect"]["screenCode"]=screenCode
                        params["onClickSelect"]["index"]=rowInfo.index}
                      }
                  }
            }  
          },
          style: {
            background:rowInfo&&rowInfo.index % 2 === 0 ? '#f4faf2' :  '#e0ebf8'  //filerを利用した時　rowInfoにセットされない？
          },
          }
        }
      }
       getTdProps={(state, rowInfo, column, instance) => {
        return { 
          onFocus:(e) =>
            {  
      //      e.target.className = "renderEditableInput"  // カーソルの動きが遅くなる。
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
         /* onChange:(e) =>
             { 
              if(e.target.tagName==="SELECT"){
                 if(yup.yupfetchcode[column.id]){// 
                    data[rowInfo.index][column.id]=e.target.value
                    let params = {}
                    params["fetchcode"] = {[column.id]:e.target.value}
                    params["screenCode"] = screenCode
                    params["data"] =  JSON.stringify(data[rowInfo.index])
                    params["index"] = rowInfo.index 
                    params["fetchview"] = yup.yupfetchcode[column.id]
                    params["uid"] =uid 
                    handleFetchRequest(params)}
                 }      
          }  , */
          onBlur:(e) =>   
             {let inputval 
             if(e.target.tagName==="SELECT"){inputval= e.target.value}else{if(e.target.tagName==="DIV"){inputval= e.target.textContent}}       
            // if(state.data[rowInfo.index][column.id]===inputval && e.target.className !== "checkbox")
            //    {e.target.className = "renderEditableNotChange"} 
            //   else{if(e.target.className !== "renderEditableError" && e.target.className !== "checkbox"){e.target.className = "renderEditable"} }
              
              if(state.data[rowInfo.index][column.id]!==inputval&&yup.yupfetchcode[column.id]){// 
                                        data[rowInfo.index][column.id]=inputval
                                        let params = {}
                                         params["fetchcode"] = {[column.id]:inputval}
                                         params["screenCode"] = screenCode
                                         params["data"] =  JSON.stringify(data[rowInfo.index])
                                         params["index"] = rowInfo.index 
                                         params["fetchview"] = yup.yupfetchcode[column.id]
                                         params["uid"] =uid 
                                         handleFetchRequest(params)
                                         }
              else{if(column.id!=="confirm"&&(data[rowInfo.index][column.id]!==inputval||inputval==="")){
                                            　data[rowInfo.index][column.id] = inputval
                                              onFieldValite(data,rowInfo.index,column.id,params)
                                            }}  ///screenCode,Name null                          
             } ,
          }
        }
      }
      
      getTheadFilterProps={(reacttablestate) => {      //  fillterの時もイベントが発生する。
          return {
            onKeyPress:(e) =>{
                            if(e.key==="Enter"&& params["req"]==="viewtablereq"){
                              handleScreenRequest(params,page,pageSize)
                            }},
          }
        }      
      }
      onPageChange={(pageIndex) => {      
        handleScreenRequest(params,pageIndex,pageSize)
           } }
      onPageSizeChange={(pageSize, pageIndex) => {      
        handleScreenRequest(params,pageIndex,pageSize)
         } 
        } 
      onFilteredChange={(filtered, column) => { //selectのfilteterが、取れない
        let value
        filtered.map((fil,inde)=>{
          if(fil.id === column.id){value=fil.value}
          return value
        })
        handleScreenParamsSet( column.id,value,params)}} 
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
            filterable:state.screen.filterable,
            dropDownList:state.screen.dropDownList,
            dropDownValues:state.screen.dropDownValues?state.screen.dropDownValues:{},
            }
}
   
const mapDispatchToProps = (dispatch,ownProps ) => ({
    handleScreenParamsSet:  (id,value,params) =>{
                            if(params["dropdownselect"]===undefined){params["dropdownselect"]={}}
                               params["dropdownselect"][id] = value
                         //   dispatch(ScreenParamsSet(params))
                          },                    
    /*
    handleScreenLineEditRequest:  (screenCode, pageSize,index,uid,screenName,linedata,pages,sizePerPageList) =>{
                            let  params= {screenCode:screenCode,screenName:screenName,
                                          index:index,uid:uid,linedata:linedata,
                                          pageSize:pageSize,req:"updateGridLineData",pages:pages,sizePerPageList:sizePerPageList}
                           dispatch(ScreenRequest(params))},
    */                       
    handleScreenRequest:  (params,page,pageSize) =>{
                            params["filtered"]=[] 
                            Object.keys(params["dropdownselect"]).map((sel)=>{
                                  params["filtered"].push({id:sel,value:params["dropdownselect"][sel]})
                                  return params["filtered"] }
                                 ) 
                            params = {...params,page:page,pageSize:pageSize}
                            dispatch(ScreenRequest(params))},
    handleFetchRequest:  (params) =>{ params["req"] = "fetch_request"
                                      dispatch(FetchRequest(params))},
    handleValite:  (schema,data,index,field,params) =>{ 
                           dispatch(ScreenErrCheck(schema,data,index,field,params))},
                      })   
export default connect(mapStateToProps,mapDispatchToProps)(ScreenGrid)
