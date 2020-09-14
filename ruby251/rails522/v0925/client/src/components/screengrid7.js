import React, { useState, useMemo, useEffect, } from 'react';
import { connect } from 'react-redux'
import { ScreenRequest, FetchRequest, } from '../actions'
//import DropDown from './dropdown'
import { yupschema } from '../yupschema'
import Tooltip from 'react-tooltip-lite'
import { onBlurFunc7 } from './onblurfunc'
import { dataCheck7 } from './yuperrcheck'
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

const cellFontSize = (column,para) =>{
  let length
  let width
  let fontSize
  switch(para){
    case 'Header':
      width = column.width
      length = column.Header.length
      if(typeof(column.Header)==="string"){
                length = column.Header.match(/^[0-9a-zA-Z\-_:\s.]*$/)?length*1:length*2}
      else{length = 1}
      break
    default:
      width = column.column.width
      if(typeof(column.value)==="string"){
              length = column.value.length
              length = column.value.match(/^[0-9a-zA-Z\-_:\s.@#;()%]*$/)?length*1:length*2}
      else{length = 1}
  }
  let checkFontSize = Math.ceil( width / length ) 
  if(checkFontSize>10){fontSize = 15}
      else{fontSize = Math.ceil( width / length * 1.5) }
      if(column.column){if(column.column.Header==="itm_material")
          {console.log('aa')}}
  return `${fontSize}px`
}

// Create an editable cell renderer
//  let contentEditablechk = contentEditablefunc(cellInfo)
// const renderNonEditable 
//const renderCheckbox

const AutoCell = ({
  value: initialValue,
  row: { index },
  column: { id, className },  //id field_code
  updateMyData, data, // This is a custom function that we supplied to our table instance
  params, updateParams,dropDownList,yup,handleScreenRequest,handleFetchRequest
}) => {
  // We need to keep and update the state of the cell normally
  const [fieldValue, setFieldValue] = useState( initialValue)
  // We'll only update the external data when the input is blurred
  const setFieldsByonChange = (e) => {
    if(e.target){
        setFieldValue(() => e.target.value)
        updateMyData(index, id, e.target.value)
      }    
  }
  const setFieldsByonBlur = (e) => {
    if(e.target){
        setFieldValue(() => e.target.value)
        let updateRow = { [id]: fieldValue }
        onFieldValite(updateRow, id, params.screenCode)  //clientだけのチェック
        let msg_id = `${id}_gridmessage`
        updateMyData(index, msg_id, updateRow[msg_id])
        if ( updateRow[msg_id] === "ok") {
            updateMyData(index, id, fieldValue)
            fetch_check(id,index, yup, data, updateParams, params, handleFetchRequest)
        }
      }    
  }
  let onLineValite = (row,index,data,params) => {
    let screenSchema = Yup.object().shape(yupschema[params.screenCode])
    let updateRow = {}
    Object.keys(screenSchema.fields).map((field) => {
       updateRow[field] = row[field] 
      return updateRow  //更新可能項目のみをセレクト
    })  // yupでは2019/12/32等がエラーにならない
    dataCheck7(screenSchema, updateRow)
    if (updateRow["confirm_gridmessage"] === "done") {
      updateParams([{ linedata: JSON.stringify(row) }, { index: index },
      { req: "confirm7" }])
      handleScreenRequest(params,data)
    }
}

  switch (true) {   
    case /^Editable/.test(className):
      return (
        <Tooltip content={data[index][id + '_gridmessage']||""}
          border={true} tagName="span" arrowSize={2}>
           
          <input defaultValue={params.req==="inlineedit7"?initialValue:null}
                    onChange={(e) => setFieldsByonChange(e)}
                    onBlur={(e) => setFieldsByonBlur(e)}
                    onKeyUp={(e) => {  
                        if (e.key === "Enter" && (params["req"] === "inlineedit7"||params["req"] === "inlineadd7")) 
                              {
                                onLineValite(data[index],index,data,params)
                                }
                      }}
          />
        </Tooltip>)
    case /SelectEditable/.test(className):
      return (
        <select
          defaultValue={fieldValue||""}
          onChange={e => {
            setFieldValue(e.target.value || undefined)
          }}
        >
          {dropDownList[id].map((option, i) => (
            <option key={i} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      )
    case /CheckEditable/.test(className):
      return <input  type="checkbox" />
    case /NonEditable/.test(className):
        return <span> {initialValue||""} </span>
    case /SelectNonEditable/.test(className):
      return (
        <select value={initialValue|| ""}  >
        </select>
      )
    case /CheckNonEditable/.test(className):
      return <input value={initialValue || ""} type="checkbox" readOnly />
    
    case /checkbox/.test(className):
        return (
          <Tooltip content={data[index]['confirm_gridmessage']||""}
          border={true} tagName="span" arrowSize={2}>
              <input  type="checkbox" checked={initialValue===true?"checked":""} readOnly />
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
            setFilter(e.target.value )
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


const fetch_check = (id, index, yup, data, updateParams, params,handleFetchRequest) => {
    switch (true) {
      case /confirm$/.test(id):
        break;
      default:
        if (yup.yupcheckcode[id]) {
          let chkcondtion = yup.yupcheckcode[id].split(",")[1]
          if (chkcondtion === undefined || (chkcondtion === "add" & data[index][id] === "") ||
            (chkcondtion === "update" & data[index][id] !== "")) {
            updateParams({
              ...params, "checkcode": JSON.stringify({ [id]: yup.yupcheckcode[id] }),
              "linedata": JSON.stringify(data[index]),
              "index": index,
              "req": "check_request",
            })
            handleFetchRequest(params,data)
          }
        }
        //チェック項目と検索項目は兼用できない。
        if (yup.yupfetchcode[id]) {
          updateParams([
            {"fetchcode": JSON.stringify({ [id]: data[index][id] })},
            {"linedata": JSON.stringify(data[index])},
            {"index": index},
            {"fetchview": yup.yupfetchcode[id]},
            {"req": "fetch_request"},
          ])
          handleFetchRequest(params,data)
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


let onFieldValite = (updateRow, field, screenCode) =>  // yupでは　2019/12/32等がエラーにならない
{
  let schema = fieldSchema(field, screenCode)
  updateRow = dataCheck7(schema, updateRow)
  updateRow = onBlurFunc7(screenCode, updateRow, field)
  return updateRow
}
///
///ScreenGrid7 
///
const ScreenGrid7 = ({ isAuthenticated,
  screenCode, screenwidth, hiddenColumns,
  pageSizeList, 
  dropDownListOrg, buttonflg, yup,
  paramsOrg,  //buttonflg 下段のボタン：request params[:req] MenusControllerでの実行ケース
  loadingOrg, hostError, columns, dataOrg,
  //callTime,
  handleScreenRequest, handleFetchRequest,
}) => {


  // Define a text UI for filtering 

  const initial = { hiddenColumns, //dropDownList  
                    }

  const updateParams = (changeParams) => {
        changeParams.map((ary,index)=>{
          let key = Object.keys(ary)[0]
          params[key] = ary[key]
          return key
        }
        )
      }

  
  //const skipResetRef = useRef(false)

  const [loading, setLoading] = useState(loadingOrg)
  useEffect(()=>{setLoading(loadingOrg)},[loadingOrg])
  const [params, setParams] = useState({})
  useEffect(()=>{setParams(paramsOrg)},[paramsOrg])
  const [controlledPageIndex, setControlledPageIndex] = useState(0)  //独自のものを用意  
  useEffect(()=>{setControlledPageIndex(()=>Number(params["pageIndex"]))},[(params["pageIndex"])])
  //useEffect(()=>{setControlledPageIndex(()=>Number(params["pageIndex"]))},[(paramsOrg["pageIndex"])])  //Ng
  //useEffect(()=>{setControlledPageIndex(()=>Number(params["pageIndex"]))},[controlledPageIndex])  //Ng
  //const [controlledPageIndex, setControlledPageIndex] = useState(Number(params["pageIndex"]),[(params["pageIndex"])])  //Ng
  const [controlledPageSize, setControlledPageSize] = useState(0)  //独自のものを用意  
  useEffect(()=>{setControlledPageSize(()=>Number(params["pageSize"]))},[(params["pageSize"])])
  //useEffect(() => { skipResetRef.current = false}, [dataOrg])

  const [data, setData] = useState([])
  useEffect(()=>{setData(dataOrg)},[dataOrg])
  
    // Since we're using pagination tokens intead of index, we need
  // to be a bit clever with page-like navigation here.
  const nextPage = () => {
    setLoading(true)
    updateParams([{pageIndex:(controlledPageIndex + 1)}])
    handleScreenRequest(params,data) 
}

const previousPage = () => {
    setLoading(true)
    updateParams([{pageIndex:(controlledPageIndex - 1)}])
    handleScreenRequest(params,data) 
}

const gotoPage = ((page) => {
  if(Number(page)>=0&&Number(page)<(Number(params["pageCount"]) + 1))
    {
      setLoading(true)
      updateParams([{pageIndex:((Number(page) - 1))}])
      handleScreenRequest(params,data) 
      }
  else{
      }}    
)

// const allFilters = (() =>{if(params){switch (params["filtered"]) {
//                            case(undefined):
//                                   return []
//                            case(Array.isArray((params["filtered"])===false)):
//                                   return []
//                            case([]):
//                                   return []
//                            default:
//                                   params["filtered"].map((column,index)=>{
//                                   let  jColumn = JSON.parse(column)
//                                   return {id:jColumn.id,value:jColumn.value}}) }}
//                            else{return []}       
//                                  })   

// useEffect(()=>{setAllFilters(allFilters)},[(params["filtered"])])
const canPreviousPage = (() => { return controlledPageIndex < 1 ? 0 : 1 })
const canNextPage = (() => { return (controlledPageIndex + 1) < (Number(params["pageCount"])) ? 1 : 0 })

  return (
    <div>
        <TableGridStyles height={buttonflg ? "840px" : buttonflg === "export" ? "500px" : buttonflg === "import" ? "300px" : "840px"}
          screenwidth={screenwidth} reqHeight={params.req==="viewtablereq7"?65:40}>
          <GridTable columns={columns} screenCode={screenCode}
            data={data} setData={setData} dropDownListOrg={dropDownListOrg}
            loading={loading} setLoading={setLoading}
            controlledPageIndex={controlledPageIndex}  controlledPageSize={controlledPageSize}
            pageSizeList={pageSizeList}  yup={yup}
            params={params} updateParams={updateParams} 
            //skipReset={skipResetRef.current}
            disableFilters={params["req"] === "viewtablereq7" ? false : true}
            initial={initial} handleScreenRequest={handleScreenRequest} 
            handleFetchRequest={handleFetchRequest}
            getHeaderProps={column => ({  //セルのサイズ合わせとclick　keyが重複するのを避けるため
              onClick: (e) =>{if(e.shiftKey){  //sort時はshift　keyが必須
                                switch(column.isSorted){
                                case true:
                                  switch(column.isSortedDesc){
                                    case true:
                                        column.toggleSortBy(false,true)
                                        return
                                    default:
                                        column.clearSortBy()
                                        return
                                      }
                                default: 
                                        column.toggleSortBy(true,true)
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
        ) : (params["req"]!=="viewtablereq7"?<div colSpan="10000" className="td" ></div>:
            <div colSpan="10000" className="td" >
              Showing {controlledPageIndex * controlledPageSize + 1} of ~
                 {Number(params["totalCount"]) < ((controlledPageIndex + 1) * controlledPageSize) ?
                   Number(params["totalCount"]) : ((controlledPageIndex + 1) * controlledPageSize)} 
                   results of  total {Number(params["totalCount"])}{''}  records
            </div>
          )}
      </div>
      {params["req"]==="viewtablereq7"&&  /*更新ではsetFieldValueで画面上の更新データを固定しているためnextPageで前のデータが残る。*/
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
            defaultValue={controlledPageIndex||0}
            onBlur={e => {
              const page = e.target.value ? Number(e.target.value) : 1
              gotoPage(page)
            }}
            style={{ width: '80px'} }
          />
        </span>{' '}
        <select
          defaultValue={Number(controlledPageSize||0)}
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
        data, setData, dropDownListOrg,
        loading,setLoading,
        //controlledPageIndex, controlledPageSize,
        pageSizeList,yup,
        params,  updateParams,
        disableFilters,
        initial,handleScreenRequest,
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
    useEffect(() => { //fetchData()
                       setHiddenColumns(initial.hiddenColumns)},[data])   
  
  const updateMyData = (rowIndex, columnId, value) => {
    // We also turn on the flag to not reset the page
    //skipResetRef.current = true
    setData(old=>
            old.map((row, index) => {
              if (index === rowIndex) {
                  return {
                  ...row,
                  [columnId]: value,
                  }
              }
            return row
            })
    )
  }
  const [dropDownList, setDropDownList] = useState()
  useEffect(() => {setHiddenColumns(initial.hiddenColumns)
   //                clearSortBy
                  setDropDownList(dropDownListOrg)
                   updateParams([{sortBy:[]}])},
                   [screenCode]) //setHiddenColumns:react-tableで用意されている。
  // useEffect(() => {setHiddenColumns(initial.hiddenColumns)
  //                   }, [(params["req"]),screenCode,controlledPageIndex, controlledPageSize,]) 
  //                   //setHiddenColumns:react-tableで用意されている。

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
    column:{filterValue,setFilter,} ,
  }) => {
    return (
      <input
        defaultValue={filterValue||''}
        onChange={e => {  // onBlur can not use
          setFilter(e.target.value || undefined)
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
    //setAllFilters,
    //setHiddenColumns,// to set the `hiddenColumns` state for the entire table.
    setHiddenColumns,   //pageCount,
    state:{filters,sortBy}  //:{controlledPageIndex,controlledPageSize},  //hiddenColumns,}
  } = useTable(
    {
      columns,
      data,
      params,updateParams,dropDownList,yup,
      defaultColumn,
      manualPagination: false,
      manualFilters: true,
      manualSortBy: true,
      disableMultiSort: false,
      autoResetSortBy: true,
      filterTypes,
      disableFilters,
      updateMyData,   //pageCount: controlledPageCount,
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
              onKeyUp: (e) =>
                     {  // filterv sortでの検索しなおし
                      if (e.key === "Enter" && params["req"] === "viewtablereq7" )
                          { 
                            // Apply the header cell props
                            updateParams([{filtered:filters},{sortBy:sortBy}])
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
                      row.index % 2 === 0 ? '' : 'lightgray',
                      },
                  onClick: e => {
                      toggleAllRowsSelected(false)
                      row.toggleRowSelected()
                      },
                  })
                  }
                    className="tr">
                {row.cells.map(cell => {  //cell.column.className  壱階層目の見出しを想定
                  return <td {...cell.getCellProps([{ className: cell.column.className + " td " },getCellProps(cell) ])} >
                    {cell.render('Cell')}
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
    loadingOrg: state.screen.loading,
    filterable: state.screen.filterable,
    isAuthenticated: state.auth.isAuthenticated,
    buttonflg: state.button.buttonflg,
    dataOrg: state.screen.data,
    paramsOrg: state.screen.params,
    //  callTime:state.screen.params.callTime, 
    screenCode: state.screen.params.screenCode,
    sortBy: state.screen.params.sortBy,
    filtered: state.screen.params.filtered,
    pageSizeList: state.screen.grid_columns_info.pageSizeList,
    columns: state.screen.grid_columns_info.columns_info,
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
  //handleScreenOnKeyUp: (data) =>{dispatch(ScreenOnKeyUp(data))},
})
export default connect(mapStateToProps, mapDispatchToProps)(ScreenGrid7)
