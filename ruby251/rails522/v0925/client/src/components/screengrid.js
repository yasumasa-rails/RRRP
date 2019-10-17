  
import React from 'react';
import { connect } from 'react-redux'
import ReactTable from 'react-table'
import {ScreenRequest,FetchRequest, YupErrSet,} from '../actions'
import "react-table/react-table.css"
import ButtonList from './buttonlist'
import DropDown from './dropdown'
import   '../index.css' 
import {yupschema} from '../yupschema'
import Tooltip from 'react-tooltip-lite'
import {contentEditablefunc} from './functions'
import {yupErrCheck} from './yuperrcheck'


class ScreenGrid extends React.Component {
  render() {
const renderEditable = (cellInfo)=> {
 
  let contentEditablechk = contentEditablefunc(cellInfo)

    return (
    <Tooltip  content={data[cellInfo.index][cellInfo.column.id+"_gridmessage"]}
                      border={true} 
       tagName="span" arrowSize={2}>
    <div 
      className={cellInfo.column.className}  //
      contentEditable={contentEditablechk.type}  //
      suppressContentEditableWarning      
      dangerouslySetInnerHTML={ contentEditablechk.val }  //
    />
    </Tooltip>
  );
}

const renderNonEditable = (cellInfo)=> {
  return (
    <div
      contentEditable={false}
      dangerouslySetInnerHTML={{ __html: cellInfo.value  }}
    />
  );
}

const renderCheckbox = (cellInfo)=> {
  return (    
    <Tooltip content={data[cellInfo.index][`${cellInfo.column.id}_gridmessage`]?data[cellInfo.index][`${cellInfo.column.id}_gridmessage`]:""}
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
     // val["style"] = JSON.parse(val["style"])  
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

const {screenCode, pageSize,filterable,loading,handleScreenParamsSet,
// sorted,handleErrorMsg,handleErrorset,handleScreenLineEditRequest,
            columns,data,pages,params,  //params railsに渡すパラメータを兼ねている。
            handleScreenRequest,handleValite, handleFetchRequest,handleConfirmRequest,
            buttonflg,dropDownList,uid,
            page, sizePerPageList,screenwidth,yup,originalreq, pageText,
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
     let onLineValite = (field,params,data) =>
        {
          let linedata = {}
          let tmp = data[params.index]["confirm_gridmessage"] 
          if(tmp==="*"||tmp===""||tmp===undefined){
            let screenSchema = Yup.object().shape(yupschema[screenCode])
            const tdata = yupErrCheck(screenSchema,field,params,data)
            if(tdata[params.index]["confirm_gridmessage"]==="*"){
              params["screenCode"] = screenCode
              Object.keys(data[params.index]).map((field)=>{
                if(field.match(/^[a-z]/)){linedata[field] = data[params.index][field]}
                return linedata
              })
              params["linedata"] =  JSON.stringify(linedata)
              params["yupfetchcode"] = yup.yupfetchcode
              params["yupcheckcode"] = yup.yupcheckcode
              handleConfirmRequest(params)
             }
            else{handleValite(tdata)}
          }
          else{handleValite(data)}
    }
     
     let onFieldValite = (field,params,data) =>
          { let schema =  fieldSchema(field)
            data[params.index][`${field}_gridmessage`] = ""
            const tdata =  yupErrCheck (schema,field,params,data)
            if(tdata[params.index][`${field}_gridmessage`]!==""){
              handleValite(tdata)
            }
          }
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
      pageText={pageText}
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
                  e.currentTarget.style.backgroundColor ='#85f0a9'
                  params["onClickSelect"]["screenCode"]=screenCode
                  params["onClickSelect"]["index"]=rowInfo.index}
              else{if(params["onClickSelect"]["index"]===rowInfo.index&&params["onClickSelect"]["screenCode"]===screenCode)
                    {
                      params["onClickSelect"]["index"]=null
                      e.currentTarget.style.backgroundColor=rowInfo.index % 2 === 0 ? '#f4faf2' :  '#e0ebf8'}
                  else{if(params["onClickSelect"]["screenCode"]===screenCode)
                          {alert(' allready row '+params["onClickSelect"]["index"]+' selected  ')}
                      else{
                        e.currentTarget.style.backgroundColor ='#85f0a9'
                        params["onClickSelect"]["screenCode"]=screenCode
                        params["onClickSelect"]["index"]=rowInfo.index}
                      }
                  }
              }  
            },
          style: {
            background:rowInfo&&rowInfo.index % 2 === 0 ? '#f4faf2' :  '#dcdcd0'  //filerを利用した時　rowInfoにセットされない？
          },
          }
        }
      }
       getTdProps={(state, rowInfo, column, instance) => {
        return { 
          onFocus:(e) =>
            {  
              e.target.className = "renderEditableInput"  // カーソルの動きが遅くなる。 let inputval 
                                           ///screenCode,Name null    
              /* //規定値をセットしようとしたが画面がプロテクトされた
            */
          } ,
          onClick:(e) =>
             { 
             if(e.target.checked&&column.id==="confirm")
                  { params["uid"] = uid
                    params["index"] = rowInfo.index
                  /*  Object.keys(rowInfo.row).map((field)=>{
                      data[rowInfo.index][field] = rowInfo.row[field]
                      return data[rowInfo.index]
                    })*/
                    onLineValite("confirm",params,data) //
                  }
          },
          onBlur:(e) =>   
             { let inputval 
              let linedata = {}
             if(e.target.tagName==="SELECT"){inputval= e.target.value}else{if(e.target.tagName==="DIV"){inputval= e.target.textContent}} 
              if(data[rowInfo.index][column.id]!==inputval&&yup.yupfetchcode[column.id]){// 
                                        //rowInfo.row[column.id]=inputval
                                        data[rowInfo.index][column.id]=inputval
                                        // let params = {}
                                         params["fetchcode"] = {[column.id]:inputval}
                                         params["screenCode"] = screenCode
                                         Object.keys(data[rowInfo.index]).map((field)=>{
                                           if(field.match(/^[a-z]/)){linedata[field] = data[rowInfo.index][field]}
                                           return linedata
                                         })
                                         params["linedata"] =  JSON.stringify(linedata)
                                         params["index"] = rowInfo.index 
                                         params["fetchview"] = yup.yupfetchcode[column.id]
                                         params["uid"] =uid
                                         params["req"] = "fetch_request"                                      
                                         handleFetchRequest(params)
                                         }
              if(data[rowInfo.index][column.id]!==inputval&&yup.yupcheckcode[column.id]){// 
                                        // rowInfo.row[column.id]=inputval
                                         data[rowInfo.index][column.id]=inputval
                                         params["checkcode"] =  JSON.stringify({[column.id]:yup.yupcheckcode[column.id]})
                                         params["screenCode"] = screenCode
                                         params["linedata"] =  JSON.stringify(data[rowInfo.index])
                                         params["index"] = rowInfo.index 
                                         params["uid"] =uid
                                         params["req"] = "check_request"                                      
                                         handleFetchRequest(params)
                                          }
              if(data[rowInfo.index][`${column.id}_gridmessage`]!=="ok"||data[rowInfo.index][column.id]!==inputval||inputval===""){
                    if(column.id!=="confirm"){
                　                            //rowInfo.row[column.id] = inputval
                                              data[rowInfo.index][column.id]=inputval
                                              //params["linedata"] =  JSON.stringify(data[rowInfo.index])
                                              params["index"] = rowInfo.index
                                              onFieldValite (column.id,params,data)}
                                            } ///screenCode,Name null                          
                                          } ,
          }
        }
      }
      
      getTheadProps={()=>{ return {
        style: {           
                width:`${screenwidth}px`
        },}}}
        
      getTbodyProps={()=>{ return {
          style: {           
                  width:`${screenwidth+25}px`
          },}}}

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
            params.req = originalreq 
        handleScreenRequest(params,pageIndex,pageSize)
           } }
      onPageSizeChange={(pageSize, pageIndex) => {
             params.req =  originalreq
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
        :<h2>please select</h2>
      }
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
            screenwidth:state.screen.screenwidth,
            sorted:state.screen.sorted,
            sizePerPageList:state.screen.sizePerPageList?state.screen.sizePerPageList:[25],
            yup:state.screen.yup,
            loading:state.screen.loading,
            filterable:state.screen.filterable,
            dropDownList:state.screen.dropDownList,
            dropDownValues:state.screen.dropDownValues?state.screen.dropDownValues:{},
            originalreq:state.screen.originalreq,
            pageText:state.screen.pageText,
            message: state.screen.message,
            }
}
   
const mapDispatchToProps = (dispatch,ownProps ) => ({
    handleScreenParamsSet:  (id,value,params) =>{
                            if(params["dropdownselect"]===undefined){params["dropdownselect"]={}}
                               params["dropdownselect"][id] = value
                         //   dispatch(ScreenParamsSet(params))
                          },                    
                      
    handleScreenRequest:  (params,page,pageSize) =>{
                            params["filtered"]=[] 
                            Object.keys(params["dropdownselect"]).map((sel)=>{
                                  params["filtered"].push({id:sel,value:params["dropdownselect"][sel]})
                                  return params["filtered"] }
                                 ) 
                            params = {...params,page:page,pageSize:pageSize}
                            dispatch(ScreenRequest(params))},
    handleConfirmRequest:  (params) =>{ params["req"] = "confirm"
                                      dispatch(ScreenRequest(params))
                                    },
    handleFetchRequest:  (params) =>{dispatch(FetchRequest(params))},
    handleValite:  (data) =>{ 
                           dispatch(YupErrSet(data))},
                      })   
export default connect(mapStateToProps,mapDispatchToProps)(ScreenGrid)
