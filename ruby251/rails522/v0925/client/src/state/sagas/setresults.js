import { call, put, select } from 'redux-saga/effects'
import { SETRESULTS_SUCCESS, MENU_FAILURE, } from 'actions';
import {getScreenState} from '../reducers/screen'

import readXlsxFile from 'read-excel-file'
import {yupErrCheckBatch,} from '../../components/yuperrcheckbatch'

function readExcel({excelfile}){
    let tmp = readXlsxFile(excelfile).then((results) => {
        return results
      })
    return tmp  
}

function exportFromJSON({importdata,defCode,excelfile,screenCode }) {
    let newFileName = excelfile.name.split(/\.xlsx$/)[0] + "@" + defCode + "@" + screenCode + "@.json"
    const data = new Blob([JSON.stringify(importdata)], { type:"text/plain" });
    const jsonURL = window.URL.createObjectURL(data);
    const link = document.createElement('a');
    document.body.appendChild(link);
    link.href = jsonURL;
    link.setAttribute('download', newFileName);
    link.click();
    document.body.removeChild(link);
    return {newFileName,jsonURL,data}
  }

// set fields  [aa,bbb]  --> {f1:aa,f2:bb}
function batchcheck(sheet,nameToCode) {
    let lines =[]
    let header = []
    let orgheader = []
    let errorheader = false
    let linedata
    let importdata = []
    let importError = false
    header.push("confirm")
    orgheader.push("confirm")
    nameToCode["aud"] = "aud"
    sheet.map((row,index)=>{
        linedata = {}
        if(index===0){
            row.map((colunm,idx)=>{
                orgheader.push(colunm)
                if(nameToCode[colunm]){
                    if(header.indexOf(nameToCode[colunm])===-1){
                              header.push(nameToCode[colunm])
                    }else{
                              header.push(`duplicate field error ${idx+1}`)
                              errorheader = true
                               }
                    }
                else{header.push(`field error ${idx+1}`)
                          errorheader = true}      
                    return header
                })
                header.map((colunm,idx)=>{
                  linedata[colunm] = orgheader[idx]
                  return linedata
                })  
        }else{
            row.map((colunm,idx)=>{
                        linedata[header[idx+1]] =  colunm
                        return linedata
                      })
            }
            lines.push(linedata)
            return lines
          })
    if(errorheader){
        lines[0]["confirm"] = "field error"
        importError = true
        importdata = Array.from(lines)
    }else{
          //importdata =  yupErrCheckBatch(lines,screenCode)
          importdata = Array.from(lines)
    } 
    return {importdata,importError}
    //finally{fileDownload(JSON.stringify(rimportdata), files[0].name+".json")}
  }


export function* SetResultsSaga({ payload: {results,defCode,excelfile} }) {
    const screenState = yield select(getScreenState) //message="" confirm=""になっている。
    //let importdata
    //let importError
    let payload
    let nameToCode = screenState.grid_columns_info.nameToCode
    let screenCode = screenState.params.screenCode
    switch (defCode) {
        case "ExcelToJson":
            try{
                let tmp = yield call(readExcel,{excelfile})
                let {importdata,importError} = batchcheck(tmp,nameToCode)
                    try{
                        yield call(exportFromJSON,{importdata,defCode:"check_master",excelfile,screenCode })
                        payload ={results:importdata,complete:false,importError}
                        yield put({ type: SETRESULTS_SUCCESS,payload:payload})
                     }
                    catch(e){
                        let message 
                        message = `check_master write error ${excelfile.name} Screen Code :${screenCode}`
                        yield put({ type: MENU_FAILURE, errors: message })
                    }
            }
             catch(e){
                    let message 
                    message = `excel read error ${excelfile.name} Screen Code :${screenCode}`
                    yield put({ type: MENU_FAILURE, errors: message })
                }
            break
        case "check_master":
            try{
               let {importdata,importError} = yupErrCheckBatch(results,screenCode) 
                yield call(exportFromJSON,{importdata,defCode:"add_update",excelfile,screenCode })
                payload ={results:importdata,complete:false,importError}
                yield put({type:SETRESULTS_SUCCESS,payload:payload})
            }
            catch(e){
                let message 
                message = `master check error ${excelfile.name} Screen Code :${screenCode}`
                yield put({ type:MENU_FAILURE , errors: message })
            }
            break
        case "add_update":
            try{
                let importError = false
                results.map((result)=>{
                    if(result["confirm"].search(/error/)>-1)
                        {importError=true}
                    return importError
                })
                payload ={results,complete:true,importError:importError}
                yield put({type:SETRESULTS_SUCCESS, payload:payload})
            }
            catch(e){
                let message 
                message = ` add update error ${excelfile.name} Screen Code :${screenCode}`
                yield put({ type: MENU_FAILURE, errors:message})
            }
            break
        default:
    }
}
 