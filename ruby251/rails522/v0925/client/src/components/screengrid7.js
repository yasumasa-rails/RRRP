import React, { useState, useMemo, useEffect, useRef,useCallback,} from 'react';
import { connect } from 'react-redux'
import { ScreenRequest, FetchRequest, } from '../actions'
import ButtonList from './buttonlist'
//import DropDown from './dropdown'
import { yupschema } from '../yupschema'
import Tooltip from 'react-tooltip-lite'
import { onBlurFunc7 } from './onblurfunc'
import { dataCheck7 } from './yuperrcheck'
import {
  useTable, useRowSelect, useFilters, useSortBy, useResizeColumns, useBlockLayout,
  //usePagination,
  useExpanded,
  //useTokenPagination,
} from 'react-table'
//  useTokenPagination   ---> undefined pluginが発生
// Some server-side pagination implementations do not use page index
// and instead use token based pagination! If that's the case,
// please use the useTokenPagination plugin instead
import { TableGridStyles } from '../styles/tablegridstyles'
import "../index.css"
//import styled from 'styled-components'

const headerProps = (props, { column }) => getStyles(props, column.align)

const cellProps = (props, { cell }) => getStyles(props, cell.column.align)

const getStyles = (props, align = 'left', width) => [
  props,
  {
    style: {
      justifyContent: align === 'right' ? 'flex-end' : 'flex-start',
      alignItems: 'flex-start',
      display: 'flex',
    },
  },
]

// Create an editable cell renderer
//  let contentEditablechk = contentEditablefunc(cellInfo)
// const renderNonEditable 
//const renderCheckbox

const AutoCell = ({
  value: initialValue,
  row: { index },
  column: { id, className },
  updateMyData, data, // This is a custom function that we supplied to our table instance
  state,  params, updateParams,
}) => {
  // We need to keep and update the state of the cell normally
  const [fieldValue, setFieldValue] = useState(() => initialValue)
  // We'll only update the external data when the input is blurred
  const setFieldsByonBlur = (e) => {
    setFieldValue(() => e.target.value)
    let updateRow = { [e.column]: fieldValue }
    onFieldValite(updateRow, e.column, state.screenCode)  //clientだけのチェック
    let msg_id = `${e.column}_gridmessage`
    updateMyData(index, msg_id, updateRow[msg_id])
    if (msg_id === "ok") {
      updateMyData(index, e.column, fieldValue)
      fetch_check(e.column, state, data, updateParams, params, fieldValue)
    }
  }
  switch (true) {
    case /^Editable/.test(className):
      return (
        <Tooltip content={data[index][id] + '_gridmessage'}
          border={true} tagName="span" arrowSize={2}>
          <input value={fieldValue} onBlur={(e) => setFieldsByonBlur(e, fieldValue)} />
        </Tooltip>)
    case /SelectEditable/.test(className):
      return (
        <select
          value={fieldValue}
          onChange={e => {
            setFieldValue(e.target.value || undefined)
          }}
        >
          {state.dropDownList[id].map((option, i) => (
            <option key={i} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      )
    case /CheckEditable/.test(className):
      return <input value={fieldValue} type="checkbox" />
    case /NonEditable/.test(className):
      return <span> {fieldValue || ""} </span>
    case /SelectNonEditable/.test(className):
      return (
        <select value={fieldValue || ""}  >
        </select>
      )
    case /CheckNonEditable/.test(className):
      return <input value={fieldValue || ""} type="checkbox" readOnly />
    default:
      return <input value={fieldValue || ""} readOnly />
  }

}


    // Define a text UI for filtering 
const DefaultColumnFilter = ({
      column: { filterValue, setFilter, id },
    }) => {
      return (
        <input
          value={filterValue || ''}
          onChange={e => {  // onBlur can not use
            setFilter(e.target.value || undefined)
            // Set undefined to remove the filter entirely
          //  updateParams([{ filtered: { ...params.filtered, [id]: filterValue } }])
          }
          }
        />
      )
}


 
const SelectFilter = ({
      column: { filterValue, setFilter, id }, state,updateParams,params,
    }) => {
      // Render a multi-select box
      return (
        <select
          value={filterValue}
          onBlur={e => {
            setFilter(e.target.value || undefined)
            updateParams([{ filtered: { ...params.filtered, [id]: filterValue } }])
          }}
        >
          <option value="">All</option>
          {state.dropDownList[id].map((option, i) => (
            <option key={i} value={option.value}>
              {option.label}
            </option>
          ))}
        </select>
      )
}


const fetch_check = (id, index, state, data, updateParams, params,handleFetchRequest) => {
    switch (true) {
      case /confirm$/.test(id):
        break;
      default:
        if (state.yup.yupcheckcode[id] && data[index][`${id}_gridmessage`] === "ok") {
          let chkcondtion = state.yup.yupcheckcode[id].split(",")[1]
          if (chkcondtion === undefined || (chkcondtion === "add" & data[index][id] === "") ||
            (chkcondtion === "update" & data[index][id] !== "")) {
            updateParams({
              ...params, "checkcode": JSON.stringify({ [id]: state.yup.yupcheckcode[id] }),
              "linedata": JSON.stringify(data[index]),
              "index": index,
              "req": "check_request",
            })
            handleFetchRequest(params)
          }
        }
        //チェック項目と検索項目は兼用できない。
        if (state.yup.yupfetchcode[id] && (data[index][`${id}_gridmessage`] === "ok")) {
          updateParams([
            {"fetchcode": JSON.stringify({ [id]: data[index][id] })},
            {"linedata": JSON.stringify(data[index])},
            {"index": index},
            {"fetchview": state.yup.yupfetchcode[id]},
            {"req": "fetch_request"},
          ])
          handleFetchRequest(params)
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
  pageSizeList, sorted, filtered,
  dropDownList, buttonflg, yup,
  paramsOrg,  //buttonflg 下段のボタン：request params[:req] MenusControllerでの実行ケース
  loadingOrg, hostError, columns, dataOrg,
  //callTime,
  handleScreenRequest, handleFetchRequest,
}) => {

  const fetchIdRef = useRef(0)

  let sortBy = []
  Object.keys(sorted).map((field) => {
    switch (sorted[field]) {
      case true:
        sortBy.push({ id: field, desc: true })
        break
      case false:
        sortBy.push({ id: field, desc: false })
        break
      default:
        break
    }
    return sortBy
  })

  let filters = []
  Object.keys(filtered).map((field) => {
    filters.push({ id: field, value: filtered.field })
    return filters
  })

  const initial = { hiddenColumns, filters,
                    }

  let onLineValite = (row, data) => {
                      let screenSchema = Yup.object().shape(yupschema[screenCode])
                      let updateRow = {}
                      Object.keys(screenSchema.fields).map((field) => {
                        if (field !== "classlist_code") { updateRow[field] = data[row.index][field] }
                        return updateRow
                      })  // yupでは2019/12/32等がエラーにならない
                      dataCheck7(screenSchema, updateRow)
                      Object.keys(updateRow).map((field) => {
                        updateMyData(row.index, field, updateRow[field])
                        return updateRow
                      })
                      if (updateRow["confirm_gridmessage"] === "done") {
                        updateParams([{ linedata: JSON.stringify(updateRow) }, { index: row.index },
                        { req: "confirm" }])
                        handleScreenRequest(params, data)
                      }
  }

  const updateParams = (changeParams) => {
    for (let i in changeParams) {
      let key = Object.keys(changeParams[i])[0]
      params[key] = changeParams[i][key]
    }
  }

  
  const skipResetRef = useRef(false)
  const updateMyData = (rowIndex, columnId, value) => {
    // We also turn on the flag to not reset the page
    skipResetRef.current = true
    data.map((row, index) => {
      if (index === rowIndex) {
        return {
          ...row,
          [columnId]: value,
        }
      }
      return row
    })
  }

  
  const [loading, setLoading] = useState([])
  useEffect(()=>setLoading(loadingOrg),[loadingOrg])
  const [params, setParams] = useState([])
  useEffect(()=>setParams(paramsOrg),[paramsOrg])
  const [controlledPageIndex, setControlledPageIndex] = useState(0)  //独自のものを用意  
  useEffect(()=>{setControlledPageIndex(()=>Number(params["pageIndex"]))},[(params["pageIndex"])])
  const [controlledPageSize, setControlledPageSize] = useState(0)  //独自のものを用意  
  useEffect(()=>{setControlledPageSize(()=>Number(params["pageSize"]))},[(params["pageSize"])])

  const [data, setData] = useState([])
  const onFetchData = useCallback(() => {
    // This will get called when the table needs new data
    // You could fetch your data from literally anywhere,
    // even a server. But for this example, we'll just fake it.

    // Give this fetch an ID
    const fetchId = ++fetchIdRef.current

    // Set the loading state
    setLoading(true)

    // We'll even set a delay to simulate a server here
      if (fetchId === fetchIdRef.current) {
        setData(dataOrg)
        setLoading(false)
      }
    },[dataOrg])

    useEffect(() => {
      onFetchData()
    }, [onFetchData])
  
    useEffect(() => {
      skipResetRef.current = false
    }, [dataOrg])
  
    
  return (
    <div>
      {screenCode && isAuthenticated &&loading===false?
        <TableGridStyles height={buttonflg ? "840px" : buttonflg === "export" ? "500px" : buttonflg === "import" ? "300px" : "840px"}
          screenwidth={screenwidth} >
          <GridTable columns={columns} screenCode={screenCode}
            data={data} updateMyData={updateMyData} onFetchData={onFetchData} loading={loading} setLoading={setLoading}
            controlledPageIndex={controlledPageIndex}  controlledPageSize={controlledPageSize}
            pageSizeList={pageSizeList}  
            params={params} updateParams={updateParams} 
            skipReset={skipResetRef.current}
            disableFilters={params["req"] === "inlineaddreq7" ? true : false}
            initial={initial} handleScreenRequest={handleScreenRequest} 
            handleFetchRequest={handleFetchRequest}
            getHeaderProps={params => ({
              onKeyUp: (e) => {  // filterv sortでの検索しなおし
                if (e.key === "Enter" && (buttonflg === "viewtablereq7" || buttonflg === "editabletablereq7")) { handleScreenRequest(params, data) }
              },
            })
            }
            getColumnProps={params => ({
              onKeyUp: (e) => {  // filterv sortでの検索しなおし
                if (e.key === "Enter" && (buttonflg === "viewtablereq7" || buttonflg === "editabletablereq7")) { handleScreenRequest(params, data) }
              },
            })
            }
            getRowProps={(row, column) => ({
              style: {
                background: row.index % 2 === 0 ? 'rgba(0,0,0,.1)' : 'DarkGray',
              },
              onKeyUp: ((e) => { //データの登録更新
                if (e.key === "Enter" && (buttonflg === "inlineaddreq7" || buttonflg === "editabletablereq7")) { onLineValite(row, data) }
              }),
              onClick: ((e) => {  //データの登録更新
                if (e.target.checked && column.id === "confirm" && (buttonflg === "inlineaddreq7" || buttonflg === "editabletablereq7")) { onLineValite(row, data) }
              })
            })
            }
          />
        </TableGridStyles>
        : <h2>{hostError ? hostError : "please select or logout &login"}</h2>
      }
      <div>
        {screenCode && isAuthenticated && <ButtonList></ButtonList>}
      </div>
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
  data, updateMyData,onFetchData,
  loading,setLoading,
  initial, disableFilters,
  getHeaderProps = defaultPropGetter,
  getColumnProps = defaultPropGetter,
  getRowProps = defaultPropGetter,
  params,  updateParams,pageSizeList,
  handleScreenRequest,
  controlledPageIndex, controlledPageSize,
  skipReset,
}) => {


  //  useTable({
  //    useControlledState: state => {
  //      return React.useMemo(
  //        () => ({
  //          ...state,
  //          pageIndex: controlledPageIndex,
  //        }),
  //        [state, controlledPageIndex]
  //      )
  //    },
  //  })

  const { sorted, sortBy  //sorted-->rails sortop  sortBy-->react-table sort defailt  
  } = { ...params }

   useEffect(() => setHiddenColumns(initial.hiddenColumns), [screenCode]) //setHiddenColumns:react-tableで用意されている。

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


  const defaultColumn = useMemo(
    () => ({
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
    toggleAllRowsSelected,
    //setHiddenColumns,// to set the `hiddenColumns` state for the entire table.
    setHiddenColumns,   //pageCount,
    state  //:{controlledPageIndex,controlledPageSize},  //hiddenColumns,}
  } = useTable(
    {
      columns,
      data,onFetchData,
      defaultColumn,
      manualPagination: false,
      manualFilter: true,
      manualSortBy: true,
      disableMultiSort: false,
      autoResetSortBy: false,
      filterTypes,
      disableFilters,
      updateMyData,   //pageCount: controlledPageCount,
      autoResetPage: !skipReset,
      autoResetSelectedRows: !skipReset,
      initialState: { controlledPageIndex: 0, controlledPageSize: 0, },
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
  //  useEffect(()=> setAllFilters(filters))   

  const sortParamsSet = (column, params,updateParams) => {
    updateParams([{sort: { ...params.sort, [column.id]: column.isSortedDesc } }])
  }

  // Since we're using pagination tokens intead of index, we need
  // to be a bit clever with page-like navigation here.
  const nextPage = () => {
        setLoading(true)
        params["pageIndex"] =  Number(params["pageIndex"]) + 1
        handleScreenRequest(params, data) 
  }

  const previousPage = () => {
        setLoading(true)
        params["pageIndex"] =  Number(params["pageIndex"]) - 1
        handleScreenRequest(params, data) 
  }

  const gotoPage = ((page) => {
      if(Number(page)>=0&&Number(page)<(Number(params["pageCount"]) + 1))
        {
          setLoading(true)
          params["pageIndex"] = (Number(page) - 1)
          handleScreenRequest(params, data) 
          }
      else{
          }}    
  )
  

  const canPreviousPage = (() => { return controlledPageIndex < 1 ? 0 : 1 })
  const canNextPage = (() => { return (controlledPageIndex + 1) < (Number(params["pageCount"])) ? 1 : 0 })
    return (
    <div>
      <table {...getTableProps()} className="table">
        <thead className="thead">
          {headerGroups.map(headerGroup => (
            <tr {...headerGroup.getHeaderGroupProps({
              style: {
                backgroundColor: 'gray'
              }
            })
            } className="tr">
              {headerGroup.headers.map(column => (
                <th {...column.getHeaderProps([getColumnProps(column), headerProps,
                column.getSortByToggleProps(),])
                  // column.getSortByToggleProps(sortParamsSet( column,setParams)),])
                } className="th">
                  {column.render('Header')}
                  <span {...column.getResizerProps()}
                    className={`resizer ${column.isResizing ? 'isResizing' : ''}`}
                  />
                  {/* Use column.getResizerProps to hook up the events correctly */}
                  <span>
                    {column.isSorted ? column.isSortedDesc ? '↓' : '↑' : ''}
                  </span>
                  <span>
                   {column.canFilter ? column.render('Filter') : null}
                  </span>
                </th>
              ))}
            </tr>
          ))}
        </thead>
        {loading?(
          <div colSpan="10000">
            Loading...
          </div>
        )
        :
        (<tbody {...getTableBodyProps()} className="tbody"  >
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
              },
              )} className="tr">
                {row.cells.map(cell => {  //cell.column.className  壱階層目の見出しを想定
                  return <td {...cell.getCellProps([{ className: cell.column.className }, cellProps])} className="td">
                    {cell.render('Cell')}
                  </td>
                })}
              </tr>
            )
          })}
        </tbody>)
        }   
      </table>
      <div>
        {loading ? (
          <div colSpan="10000">
            Loading...
          </div>
        ) : (
            <div colSpan="10000" className="td" >
              Showing {controlledPageIndex * controlledPageSize + 1} of ~
                 {Number(params["totalCount"]) < ((controlledPageIndex + 1) * controlledPageSize) ?
                   Number(params["totalCount"]) : ((controlledPageIndex + 1) * controlledPageSize)} 
                   results of  total {Number(params["totalCount"])}{''}  records
            </div>
          )}
      </div>
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
        </button>{''}
        <span>
          Page{''}
          <strong>
            {controlledPageIndex + 1} of {(Number(params["pageCount"]))}
          </strong>{''}
        </span>
        <span>
          | Go to page:{''}
          <input
            type="number"
            value={controlledPageIndex + 1}
            onChange={e => {
              const page = e.target.value ? Number(e.target.value) : 1
              gotoPage(page)
            }}
            style={{ width: '80px'} }
          />
        </span>{' '}
        <select
          value={controlledPageSize}
          onChange={e => {
            params["pageSize"]= (Number(e.target.value))
            //params["pageIndex"]= 1
            params["pageIndex"]= (Math.ceil(Number(params["totalCount"])/params["pageSize"]) -1)
            handleScreenRequest(params, data) 
          }}
        >
          {pageSizeList.map(pageSize => (
            <option key={pageSize} value={pageSize}>
              Show {pageSize}
            </option>
          ))  /*menuから呼ばれたときはparams["pageSizeList"]==null　*/}
        </select>
      </div>
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
    sorted: state.screen.params.sort,
    filtered: state.screen.params.filtered,
    pageSizeList: state.screen.grid_columns_info.pageSizeList,
    columns: state.screen.grid_columns_info.columns_info,
    screenwidth: state.screen.grid_columns_info.screenwidth,
    yup: state.screen.grid_columns_info.yup,
    dropDownList: state.screen.grid_columns_info.dropdownlist,
    hiddenColumns: state.screen.grid_columns_info.hiddenColumns,
    hostError: state.screen.hostError,
  }
}

const mapDispatchToProps = (dispatch, ownProps) => ({
  handleScreenRequest: (params, data) => {
    dispatch(ScreenRequest(params, data))
  },
  handleFetchRequest: (params) => {
    dispatch(FetchRequest(params))
  },
  //handleScreenOnKeyUp: (data) =>{dispatch(ScreenOnKeyUp(data))},
})
export default connect(mapStateToProps, mapDispatchToProps)(ScreenGrid7)
