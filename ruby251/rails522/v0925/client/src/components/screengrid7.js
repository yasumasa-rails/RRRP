import React, { useState, useMemo, useEffect,useRef, } from 'react';
import { connect } from 'react-redux'
import { ScreenRequest, FetchRequest, } from '../actions'
//import DropDown from './dropdown'
import { yupschema } from '../yupschema'
import Tooltip from 'react-tooltip-lite'
import { onBlurFunc7 } from './onblurfunc'
import { yupErrCheck } from './yuperrcheck'
import {useTable, useRowSelect, useFilters, useSortBy, useResizeColumns, useBlockLayout,
        useExpanded,
        //useTokenPagination,  //usePagination,
        } from 'react-table'
//  useTokenPagination   ---> undefined pluginが発生
// Some server-side pagination implementations do not use page index
// and instead use token based pagination! If that's the case,
// please use the useTokenPagination plugin instead
import { TableGridStyles } from '../styles/tablegridstyles'
import "../index.css"
//import styled from 'styled-components'
import {setClassFunc,setProtectFunc,setInitailValueForAddFunc} from './functions7'

const cellFontSize = (column,para) =>{
  let length
  let width
  let fontSize
  switch(para){
    case 'Header':
      width = column.width
      length = column.Header.length
      if(typeof(column.Header)==="string"){
                length = column.Header.match(/^[0-9a-zA-Z\-_:\s.]*$/)?length*1:length*1.8}
      else{length = 1}
      break
    default:
      width = column.column.width
      if(typeof(column.value)==="string"){
              length = column.value.length
              length = column.value.match(/^[0-9a-zA-Z\-_:\s.@#;()%]*$/)?length*1:length*1.5}
      else{length = 1}
  }
  let checkFontSize = Math.ceil( width / length ) 
  if(checkFontSize>10){fontSize = 15}
      else{fontSize = Math.ceil( width / length * 1.5) }
 return `${fontSize}px`
 //return '100%'
}

// Create an editable cell renderer
//  let contentEditablechk = contentEditablefunc(cellInfo)
// const renderNonEditable 
//const renderCheckbox


const AutoCell = ({
  value: initialValue,
  row: { index,values },
  column: { id, className },  //id field_code
  setData, data, // This is a custom function that we supplied to our table instance
  row,params, updateParams,dropDownList,yup,handleScreenRequest,handleFetchRequest,
  params:{req},buttonflg,loading,  //useTableへの登録が必要
  }) => {
  // We need to keep and update the state of the cell normally
  //const [fieldValue, setFieldValue] = useState( initialValue)
  const [value, setValue] = useState(initialValue)
  const [newClassName, setNewClassName] = useState(className)
  const [newReadOnly, setNewReadOnly] = useState(false)
  const inputRef = useRef()
  //useEffect(()=>setFieldValue(initialValue),[initialValue])
  // We'll only update the external data when the input is blurred
  const setFieldsByonChange = (e) => {
    if(e.target){
      //initialValue = (e.target.value||"")  他の項目に移動すると、入力内容が消える。
        setValue(e.target.value)
        updateMyData(index, id, e.target.value ) //dataの内容が更新されない。但しとると、画面に入力内容が表示されない。
        inputRef.current = true
      }   
  }
  const setFieldsByonFocus = (e) => {//未使用
      inputRef.current = false
      if(e.target){
         if(e.target.value===null||e.target.value===""||e.target.value===undefined){
           //initialValue = setInitailValueForAddFunc(id,row,・・・　画面表示されない。
           values[id] = setInitailValueForAddFunc(id,row,className,params.screenCode)
          }
          if(values[id]){
              setValue(values[id])
              updateMyData(index, id, values[id])
              fetch_check(id,index, yup, data, updateParams, params, handleFetchRequest,loading,inputRef)
          }
         // e.target.value||undefinedにすると日付チェックの時splitでエラーが発生
       }  
  }
  
  const setFieldsByonBlur = (e) => {
    // if(e.target){
    //     if(e.target.value===null||e.target.value===""||e.target.value===undefined){
    //       values[id] = setInitailValueForAddFunc(id,row,className,params.screenCode)
    //       //initialValue = setInitailValueForAddFunc(id,row,・・・　画面表示されない。
    //       setValue(values[id])
    //     }
        // e.target.value||undefinedにすると日付チェックの時splitでエラーが発生
      if(inputRef.current === false){
          let updateRow = { [id]: e.target.value}
          onFieldValite(updateRow, id, params.screenCode)  //clientでのチェック
          let msg_id = `${id}_gridmessage`
          updateMyData(index, msg_id, updateRow[msg_id])}
      else{
            let updateRow = { [id]: e.target.value}
            onFieldValite(updateRow, id, params.screenCode)  //clientでのチェック
            let msg_id = `${id}_gridmessage`
            updateMyData(index, msg_id, updateRow[msg_id])
            if ( updateRow[msg_id] === "ok") {
                fetch_check(id,index, yup, data, updateParams, params, handleFetchRequest,loading)
           // updateMyData(index, id,  value)
            }else{}
      }    
  }
  
  useEffect(() => {
    setValue(initialValue)
  }, [initialValue])

  let onFieldValite = (updateRow, field, screenCode) =>{  // yupでは　2019/12/32等がエラーにならない
        let schema = fieldSchema(field, screenCode)
        yupErrCheck(schema,field,updateRow)
        if(updateRow[field+"_gridmessage"]==="ok"){
            onBlurFunc7(screenCode, updateRow, field)
          }
        return updateRow
  }

  const onLineValite = (row,index,data,params) => {
    let screenSchema = Yup.object().shape(yupschema[params.screenCode])
    let updateRow = {}
    Object.keys(screenSchema.fields).map((field) => {
       updateRow[field] = row[field] 
      return updateRow  //更新可能項目のみをセレクト
    })  
    yupErrCheck(screenSchema,"confirm",updateRow)
    // Object.keys(data[0]).map((field) => {
    //   if(/_id/.test(field)||field==="id")
    //     {updateRow[field] = row[field]} 
    //   return updateRow  //idを追加
    // })  
    // Object.keys(updateRow).map((key,idx)=>{ 
    //           updateMyData(index, key,  updateRow[key])
    //           return key})
    if (updateRow["confirm_gridmessage"] === "doing") {
      let row = {}
      Object.keys(data[index]).map((key,idx)=>{  //複数key対応
       if(/_gridmessage/.test(key)){}
         else{row[key]=data[index][key]}
         return null
       }
      )
      updateParams([{ linedata: JSON.stringify(row)}, { index: index },
                        { req: "confirm7" }])
      handleScreenRequest(params,data)
    }
  }
  //id,row,className,req  autocellで指定が必要
   useEffect(()=>setNewClassName(()=>row.values&&setClassFunc(id,row,className,req)),
                                    [row.values[id+"_gridmessage"]])
   useEffect(()=>setNewReadOnly(()=>loading===false?setProtectFunc(id,row):true),[loading])

    const updateMyData = (rowIndex, columnId, value) => {
     // We also turn on the flag to not reset the page
     //skipResetRef.current = true
     setData(old=>
              old.map((row, index) => {
                if (index === rowIndex) {
                    row =  {
                      ...old[rowIndex],
                    [columnId]: value,
                    }
                }
              return row
              })
     )
   }



  switch (true){   
    case /^Editable/.test(className):
      return (
        <Tooltip content={data[index][id + '_gridmessage']||""}
          border={true} tagName="span" arrowSize={2}>
          {buttonflg === "inlineadd7"&&(  //params["req"] === "inlineadd7"?a:b  だとa,b両方処理した。
            <input value={value||""}
                   //placeholder(入力されたことにならない。) defaultvale（照会内容の残像が残る。)
                    onFocus={(e) => { setFieldsByonFocus(e)
                                    setProtectFunc(id,row)}}
                    onChange={(e) => setFieldsByonChange(e)}
                    onBlur={(e) => setFieldsByonBlur(e)}
                    className={newClassName}
                    readOnly={newReadOnly}
                    onKeyUp={(e) => {  
                        if (e.key === "Enter" ) 
                              {
                                onLineValite(data[index],index,data,params)
                              }
                      }}        
                    />)}
           {buttonflg === "inlineedit7"&&(
            <input  value={value||""} 
                  //  onFocus={(e) =>  setProtectFunc(id,row)} //numeric-->varchar等うまくいかない
                    onChange={(e) => setFieldsByonChange(e)}
                    onBlur={(e) => setFieldsByonBlur(e)}
                    className={newClassName}
                    readOnly={newReadOnly}
                    onKeyUp={(e) => {  
                        if (e.key === "Enter" ) 
                            {
                              onLineValite(data[index],index,data,params)
                      }
            }}
            />)}
        </Tooltip>)
    case /SelectEditable/.test(className):
      return (
        <select
          value={value||""}
          onChange={e => {
            setFieldsByonChange(e)
          }}
        >
          {JSON.parse(dropDownList[id]).map((option, i) => (
            <option key={i} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      )
    case /CheckEditable/.test(className):
      return <input  type="checkbox" 
      onChange={e => {
        setFieldsByonChange(e)
      }}/>
    case /^NonEditable/.test(className):
        return <span> {initialValue||""} </span>

    case /SelectNonEditable/.test(className):
      return (
        <select value={initialValue||""} disabled >
        {JSON.parse(dropDownList[id]).map((option, i) => (
          <option key={i} value={option.value} >
            {option.label} 
          </option>
        ))}</select>
      )

    case /CheckNonEditable/.test(className):
      return <input value={initialValue || ""} type="checkbox" readOnly />
    
    case /checkbox/.test(className):
        return (
          <Tooltip content={data[index]['confirm_gridmessage']||""}
          border={true} tagName="span" arrowSize={2}>
              <input  type="checkbox" checked={initialValue===true?"checked":""} className={newClassName} readOnly />
              {/*     style={{bakground:"red"}}が有効にならない。*/}
              </Tooltip>)
    default:
      return <input value={initialValue || ""} readOnly />
  }
}
 
const SelectFilter = ({
      column: { filterValue, setFilter, id,  dropDownList,}, // dropDownList, 修正要　仮     
    }) => {
      // Render a multi-select box
      return (
        <select
          value={filterValue}
          onChange={e => {
            setFilter(id,e.target.value )
          }}
        >
          <option value="">All</option>
          {dropDownList[id].map((option, i) => (
            <option key={i} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      )
}

//serverデータとのチェック又はserverデータの検索
const fetch_check = (id, index, yup, data, updateParams, params,handleFetchRequest,loading) => {
    switch (true) {
      case /confirm$/.test(id):
        break;
      default:
        if(yup.yupcheckcode[id]){
          let chkcondtion = yup.yupcheckcode[id].split(",")[1]
          if (chkcondtion === undefined || (chkcondtion === "add" & data[index][id] === "") ||
            (chkcondtion === "update" & data[index][id] !== "")) {
            updateParams([{
              ...params, "checkcode": JSON.stringify({ [id]: yup.yupcheckcode[id] }),
              "linedata": JSON.stringify(data[index]),
              "index": index,
              "req": "check_request",
            }])
            handleFetchRequest(params,data)
          }
        }
        //チェック項目と検索項目は兼用できない。
        if(yup.yupfetchcode[id]){
            let idKeys=[]
            let flg = true
            Object.keys(yup.yupfetchcode).map((key,idx)=>{  //複数key対応
              if(yup.yupfetchcode[id]===yup.yupfetchcode[key]){
                if(data[index][key]===""||data[index][key]===undefined){
                  flg = false
                  return  idKeys
                }
                else(idKeys.push({ [key]: data[index][key] }))
              }
            return idKeys
            })
          if(flg){
            let row = {}
             Object.keys(data[index]).map((key,idx)=>{  //複数key対応
              if(/_gridmessage/.test(key)){}
                else{row[key]=data[index][key]}
                return null
              }
             )
            updateParams([
              {"fetchcode": JSON.stringify(idKeys)},
              {"linedata": JSON.stringify(row)},
              {"index": index},
              {"fetchview": yup.yupfetchcode[id]},
              {"req": "fetch_request"},
            ])
            handleFetchRequest(params,data,loading)
          }else{}//未入力keyがある。  
        }
        break;
    }
}

let Yup = require('yup')

let fieldSchema = (field, screenCode) => {
  let tmp = {}
  tmp[field] = yupschema[screenCode][field]
  return (
    Yup.object(
      tmp
    ))
}



///
///ScreenGrid7 
///
const ScreenGrid7 = ({ isAuthenticated,
  screenCode, screenwidth, hiddenColumns,
  pageSizeList, 
  dropDownListOrg, buttonflgOrg, yup,
  paramsOrg,  //buttonflg 下段のボタン：request params[:req] MenusControllerでの実行ケース
  loading, hostError, columnsOrg, dataOrg,
  //callTime,
  handleScreenRequest, handleFetchRequest,
  }) => {

  // Define a text UI for filtering 
 
  // const initial = { hiddenColumns, //dropDownList  
  //                   }
  
  //const skipResetRef = useRef(false)

  const columns = React.useMemo(
    () => (columnsOrg))
  const [params, setParams] = useState({})
  const updateParams = (changeParams) => {
         changeParams.map((ary,index)=>{
           let key = Object.keys(ary)[0]
           params[key] = ary[key]
           return null
         })}

  const [controlledPageIndex, setControlledPageIndex] = useState(0)  //独自のものを用意  
  useEffect(()=>{setControlledPageIndex(()=>Number(params["pageIndex"]))},[(params["pageIndex"])])
  //useEffect(()=>{setControlledPageIndex(()=>Number(params["pageIndex"]))},[(paramsOrg["pageIndex"])])  //Ng
  //useEffect(()=>{setControlledPageIndex(()=>Number(params["pageIndex"]))},[controlledPageIndex])  //Ng
  //const [controlledPageIndex, setControlledPageIndex] = useState(Number(params["pageIndex"]),[(params["pageIndex"])])  //Ng
  const [controlledPageSize, setControlledPageSize] = useState(0)  //独自のものを用意  
  useEffect(()=>{setControlledPageSize(()=>Number(params["pageSize"]))},[(params["pageSize"])])
  //useEffect(() => { skipResetRef.current = false}, [dataOrg])

  const [data, setData] = useState([]) 
   
  // useEffect(()=>{paramsOrg.fetch_data&&Object.keys(paramsOrg.fetch_data).map((idx)=>{
  //                              updateMyData(paramsOrg.index,idx,paramsOrg.fetch_data[idx])
  //                              let msg
  //                              if(paramsOrg.err===""){
  //                                  if(paramsOrg.fetch_data[idx]==="")
  //                                        {msg = "on the way"}
  //                                  else{ msg = "detected"}
  //                              }else{msg = paramsOrg.err
  //                                    updateMyData(paramsOrg.index,"confirm_gridmessage",msg)}
  //                              updateMyData(paramsOrg.index,idx+"_gridmessage",msg)
  //                              console.log(idx)
  //                              console.log(data[paramsOrg.index])
  //                              console.log(paramsOrg.fetch_data)
  //                              return null})}
  //       ,[paramsOrg.fetch_data,paramsOrg.err])

  //       const updateMyData = (rowIndex, columnId, value) => {
  //         // We also turn on the flag to not reset the page
  //         //skipResetRef.current = true
  //         setData(old=>
  //                 old.map((row, index) => {
  //                   if (index === rowIndex) {
  //                       return {
  //                         ...old[rowIndex],
  //                       [columnId]: value,
  //                       }
  //                   }
  //                 return row
  //                 })
  //         )
  //       } 

  const [buttonflg, setButtonflg] = useState()
  useEffect(()=>{setButtonflg(buttonflgOrg)},[buttonflgOrg])
 
  // Since we're using pagination tokens intead of index, we need
  // to be a bit clever with page-like navigation here.
  const nextPage = () => {
    updateParams([{pageIndex:(controlledPageIndex + 1)}])
    handleScreenRequest(params,data) 
  } 

  const previousPage = () => {
    updateParams([{pageIndex:(controlledPageIndex - 1)}])
    handleScreenRequest(params,data) 
  }

  const gotoPage = ((page) => {
    if(Number(page)>=0&&Number(page)<(Number(params["pageCount"]) + 1))
      {
        updateParams([{pageIndex:((Number(page) - 1))}])
        //setControlledPageIndex(page)
        handleScreenRequest(params,data) 
      }
    else{
      }}    
  )

  const canPreviousPage = (() => { return controlledPageIndex < 1 ? 0 : 1 })
  const canNextPage = (() => { return (controlledPageIndex + 1) < (Number(params["pageCount"])) ? 1 : 0 })

  return (
    <div>
        <TableGridStyles height={buttonflg ? "840px" : buttonflg === "export" ? "500px" : buttonflg === "import" ? "300px" : "840px"}
          screenwidth={screenwidth} >
          <GridTable  columns={columns}  screenCode={screenCode}
            dataOrg={dataOrg} data={data} setData={setData} dropDownListOrg={dropDownListOrg}
            loading={loading} 
            controlledPageIndex={controlledPageIndex}  controlledPageSize={controlledPageSize} buttonflg={buttonflg}
            pageSizeList={pageSizeList}  yup={yup}
            paramsOrg={paramsOrg} params={params} setParams={setParams}  updateParams={updateParams} 
            //skipReset={skipResetRef.current}
            disableFilters={/viewtablereq7|export|inlineedit7|search/.test(buttonflg) ? false : true}
            hiddenColumns={hiddenColumns} handleScreenRequest={handleScreenRequest} 
            handleFetchRequest={handleFetchRequest}
            getHeaderProps={column => ({  //セルのサイズ合わせとclick　keyが重複するのを避けるため
              onClick: (e) =>{if(e.shiftKey){  //sort時はshift　keyが必須
                                switch(column.isSorted){
                                case true:
                                  switch(column.isSortedDesc){
                                    case false:
                                        column.toggleSortBy(true,true)
                                        return
                                    default:
                                        column.clearSortBy()
                                        return
                                      }
                                default: 
                                        column.toggleSortBy(false,true)
                                        return
                                        }}
                              },
             style:{fontSize:cellFontSize(column,'Header')}, 
            })}
            getCellProps={cell=>({
              style:{fontSize:cellFontSize(cell,'Cell')}, 
            })}
          />
        </TableGridStyles>
      <div>
        {loading ? (
          <div colSpan="10000">
            Loading...
          </div>
        ) : ((params["req"]!=="viewtablereq7"||params["req"]==="inlineedit7")?<div colSpan="10000" className="td" ></div>:
            <div colSpan="10000" className="td" >
               {Number(params["totalCount"])===0?"No Record":
                `Showing ${controlledPageIndex * controlledPageSize + 1} of ~
                 ${Number(params["totalCount"]) < ((controlledPageIndex + 1) * controlledPageSize)? 
                  Number(params["totalCount"]) : ((controlledPageIndex + 1) * controlledPageSize)} 
                  results of  total ${Number(params["totalCount"])} records`}
            </div>
          )}
      </div>
      {(params["req"]==="viewtablereq7"||params["req"]==="inlineedit7")&& 
      <div className="pagination">
        <button onClick={() => {
          gotoPage(1)
        }} disabled={canPreviousPage() === 0 ? true : false}>
          {'<<'}
        </button>{''}
        <button onClick={() => {
          previousPage()
        }} disabled={canPreviousPage() === 0 ? true : false}>
          {'<'}
        </button>{''}
        <button onClick={() => { nextPage() }} disabled={canNextPage() === 0 ? true : false}>
          {'>'}
        </button>{''}
        <button onClick={() => { gotoPage(Number(params["pageCount"])) }} disabled={canNextPage() === 0 ? true : false}>
          {'>>'}
        </button>{' '}
        <span>
          Page{' '}
          <strong>
            {controlledPageIndex + 1} of {(Number(params["pageCount"]))}
          </strong>{''}
        </span>
        <span>
          | Go to page:{''}
          <input
            type="number"
            value={controlledPageIndex?controlledPageIndex + 1:1}
            onChange={e => {
              setControlledPageIndex((Number(e.target.value) - 1))
            }}
            onBlur={e => {
              gotoPage(e.target.value)
            }}
            onKeyUp={(e) => {  
                if (e.key === "Enter" )
                 { 
                  gotoPage(e.target.value)
                 }
            }}
            style={{width: '80px',
                    height:'23px',
                    textAlign: 'right'}}
          />
        </span>{' '}
        <select
          value={Number(controlledPageSize||0)}
          onChange={e => {
            //params["pageIndex"]= 1
             let pageIndex=Math.floor(controlledPageSize*controlledPageIndex/
                                                             Number(e.target.value))
            //setControlledPageSize(Number(e.target.value))
            // setControlledPageIndex(Math.floor(Number(params["pageSize"])*Number(params["pageIndex"])/
            //                                       controlledPageSize) )
            //controlledPageSizeとcontrolledPageIndexはeffectでセットされる。
            updateParams([{pageIndex:pageIndex},{pageSize:Number(e.target.value)}])
            handleScreenRequest(params,data) 
          }}
        >
          {pageSizeList.map(pageSize => (
            <option key={pageSize} value={pageSize}>
              Show {pageSize}
            </option>
          ))  /*menuから呼ばれたときはparams["pageSizeList"]==null　*/}
        </select>
      </div>  /*nextPage等終わり*/}  
      <p>{hostError}</p>
    </div>
  )
}

// Create a default prop getter
const defaultPropGetter = () => ({})

///
///gridtable
///
const GridTable = ({
        columns,screenCode,
        dataOrg, data,setData, dropDownListOrg,
        loading,
        controlledPageIndex, controlledPageSize,
        pageSizeList,yup,
        paramsOrg,params, setParams, updateParams,buttonflg,
        disableFilters,
        hiddenColumns,handleScreenRequest,
        handleFetchRequest,
        getHeaderProps = defaultPropGetter,
        getColumnProps = defaultPropGetter,
        getCellProps = defaultPropGetter,
        //skipReset,       
      }) => {
        
 
  // const fetchIdRef = useRef(0)
  //    const fetchData = useCallback(() => {
  //  //  // This will get called when the table needs new data
  //  //  // You could fetch your data from literally anywhere,
  //  //  // even a server. But for this example, we'll just fake it.
  //  //  // Give this fetch an ID
  //     const fetchId = ++fetchIdRef.current

  //  //  // Set the loading state
  //     setLoading(true)

  //  //  // We'll even set a delay to simulate a server here
  //       if (fetchId === fetchIdRef.current) {
  //         setData(dataOrg)
  //         setLoading(false)
  //       }
  //     })


  const [dropDownList, setDropDownList] = useState()
  
  useEffect(() => {
                   updateParams([{sortBy:"[]"},{filtered:"[]"}])},
                    [screenCode]) 

  useEffect(()=>{   setData(dataOrg)},
                          [dataOrg])
  useEffect(()=>{   setDropDownList(dropDownListOrg)},
                          [dropDownListOrg])

  useEffect(() => {
          setAllFilters(params.filtered===undefined?[]:JSON.parse(params.filtered).map((filter)=>{
                  return filter}))},[params.filtered])  
                  
  useEffect(() => {
              setSortBy(params.sortBy===undefined?
                       []:JSON.parse(params.sortBy).map((sort)=>{
                  return sort}))},[params.sortBy])  
             
  useEffect(()=>{setParams(paramsOrg)},[paramsOrg])  

  //setHiddenColumns:react-tableで用意されている。
  // useEffect(() => {setHiddenColumns(initial.hiddenColumns)
  //                   }, [(params["req"]),screenCode,controlledPageIndex, controlledPageSize,]) 
  // //                   //setHiddenColumns:react-tableで用意されている。
  // useEffect(() => { //fetchData()
  //     setHiddenColumns(initial.hiddenColumns)},[data])   
  //                  setData(dataOrg)
  //                   //                clearSortBy
  //                                   },
  // //                 [paramsOrg.req,buttonflg]) 
  // useEffect(()=>{   
  //                   setDropDownList(dropDownListOrg)
  //                   setData(dataOrg)},
  //                   [loading])


  const filterTypes = useMemo(
    () => ({
      includes: SelectFilter,  //screenfield_type　に従う
      // override 
      text: (rows, id, filterValue) => {
        return rows.filter(row => {
          const rowValue = row.values[id]
          return rowValue !== undefined
            ? String(rowValue)
                .toLowerCase()
                .startsWith(String(filterValue).toLowerCase())
            : true
        })
      },
    }),
    []
  )

  const ColumnHeader = ({
    column ,
  }) => {
    return (
      <span></span>
    )
  }
  
  const DefaultColumnFilter = ({
    column:{filterValue,setFilter,} ,column,
  }) => {
     
    return (
      <input
        value={filterValue||""}
        onChange={e => {  // onBlur can not use
          setFilter(e.target.value || "")
        }
        }
      />
    )
  }
  const defaultColumn = useMemo(
    () => ({
      Header: ColumnHeader,
      //minWidth: 30,
      //width: 150, // width is used for both the flex-basis and flex-grow
      //maxWidth: 1500,
      Filter: DefaultColumnFilter,
      Cell: AutoCell,
    }),
    []
  )
 
  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
     prepareRow, //page,
    //canPreviousPage, canNextPage,
    //setPageIndex,
    //previousPage,nextPage,
    //setPageSize, //Instance Properties This function sets state.pageSize to the new value. already prepare
    //gotoPage,
    toggleAllRowsSelected,   //toggleSortBy,
    //clearSortBy,
    setAllFilters,setSortBy,
    //setHiddenColumns,// to set the `hiddenColumns` state for the entire table.
    //setHiddenColumns,   //pageCount,
    state:{filters,sortBy}  //:{controlledPageIndex,controlledPageSize},  //hiddenColumns,}
  } = useTable(
    {
      columns,
      data,
      params,updateParams,dropDownList,yup,buttonflg,loading,setData,
      defaultColumn,
      manualPagination: false,
      manualFilters: true,
      manualSortBy: true,
      disableMultiSort: false,
      autoResetSortBy: true,
      filterTypes,
      disableFilters,
      //updateMyData,   //pageCount: controlledPageCount,
      initialState: {hiddenColumns:hiddenColumns,
                      sortBy:params.sortBy===undefined?[]:JSON.parse(params.sortBy).map((sort)=>{return sort})
                    },
    //  autoResetPage: !skipReset,
    //  autoResetSelectedRows: !skipReset,
    handleFetchRequest,handleScreenRequest,
     // initialState: { controlledPageIndex: 0, controlledPageSize: 0, },
    },
    useFilters, // useFilters!
    useSortBy,  //The useSortBy plugin hook must be placed after the useFilters plugin hook!
    useBlockLayout,
    useResizeColumns,
    useExpanded,
    //usePagination,
    //useTokenPagination, //The usePagination plugin hook must be placed after the useSortBy plugin hook!
    useRowSelect,
  )
  //

  return (
    <div>
      <table {...getTableProps({
              onClick: (e) =>{}
                     })} className="table">
        <thead className="thead">
          {headerGroups.map(headerGroup => (
            <tr {...headerGroup.getHeaderGroupProps({
              style: {
                      backgroundColor: 'gray'
                     },
              onKeyUp: (e) =>  //filter
                     {  // filterv sortでの検索しなおし
                      if (e.key === "Enter" &&(params["req"] === "viewtablereq7"||params["req"]==="inlineedit7") )
                          { 
                            updateParams([{filtered:JSON.stringify(filters)},{sortBy:JSON.stringify(sortBy)}])
                            // Apply the header cell props
                            handleScreenRequest(params,data)
                          }
                      },
              onClick: (e) =>{
                              }
            })
            } className="tr">
              {headerGroup.headers.map(column => (
                <th {...column.getHeaderProps([getHeaderProps(column),
                                                ])} className="th">
                  {/* Use column.getResizerProps to hook up the events correctly */}
                  {column.render('Header')}
                  <span>
                    {column.isSorted ? column.isSortedDesc ? '↓' : '↑' : ''}
                  </span>
                  <span>
                   {column.canFilter ? column.render('Filter') : null}
                  </span>
                  <span {...column.getResizerProps()}   className={`resizer ${column.isResizing ? 'isResizing' : ''}`}> 
                  </span>
                </th>
              ))}
            </tr> 
          ))}
        </thead>
          <tbody {...getTableBodyProps()} className="tbody"  >
            {rows.map((row, i) => {
              prepareRow(row)
              return (
              <tr {...row.getRowProps({
                  style: {
                      backgroundColor: row.isSelected ? 'lime' :
                      row.index % 2 === 0 ? 'ivory' : 'lightgray',
                      },
                  onClick: e => {
                      toggleAllRowsSelected(false)
                      row.toggleRowSelected()
                      updateParams([{clickIndex:row.index}])
                      },
                  })
                  }
                    className="tr">
                {row.cells.map(cell => {  //cell.column.className  壱階層目の見出しを想定
                  return <td {...cell.getCellProps([{className:cell.column.className+" td "},
                                      getCellProps(cell) //font-sizeの調整
                  ])} >
                    {cell.render('Cell') }
                    </td>
                })}
              </tr>
            )
          })}
        </tbody>
      </table>
      </div>
  )
}

const mapStateToProps = (state) => {
  return {
    loading: state.screen.loading,
    filterable: state.screen.filterable,
    isAuthenticated: state.auth.isAuthenticated,
    buttonflgOrg: state.button.buttonflg,
    dataOrg: state.screen.data,
    paramsOrg: state.screen.params,
    screenCode: state.screen.params.screenCode,
    pageSizeList: state.screen.grid_columns_info.pageSizeList,
    columnsOrg: state.screen.grid_columns_info.columns_info,
    screenwidth: state.screen.grid_columns_info.screenwidth,
    yup: state.screen.grid_columns_info.yup,
    dropDownListOrg: state.screen.grid_columns_info.dropdownlist,
    hiddenColumns: state.screen.grid_columns_info.hiddenColumns,
    hostError: state.screen.hostError,
  }
}

const mapDispatchToProps = (dispatch, ownProps) => ({
    handleScreenRequest: (params,data) => {
    dispatch(ScreenRequest(params,data))
  },
  handleFetchRequest: (params,data) => {
    dispatch(FetchRequest(params,data))
  },
})
export default connect(mapStateToProps, mapDispatchToProps)(ScreenGrid7)
