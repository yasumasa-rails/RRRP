/*
import { call, put,} from 'redux-saga/effects'
import { EXCELTOJSON_SUCCESS, MENU_FAILURE, } from 'actions';
import readXlsxFile from 'read-excel-file'
function* seq1(file,nameToCode){
  let sheet   = yield call(readExcelApi, ({file}))
  //return  sheet
  return {sheet}
}

function readExcelApi({file}) {

  let getApi = (file) => {return readXlsxFile(file)};
  return getApi(file)
}


function* seq2({importdata,file,screenCode}){
  //let {newFileName, jsonURL ,data} = yield call(exportFromJSONApi,({importdata,file,screenCode}))
  return // {newFileName, jsonURL,data}
}


export function* ExcelToJsonSaga({ payload: {file,screenCode,nameToCode} }) {
  try{
    const  {importdata} = yield* seq1(file,nameToCode)
    try{
     const {newFileName,jsonURL,data} = yield* seq2({importdata,file,screenCode})
     yield put({type:EXCELTOJSON_SUCCESS, payload:{newFileName,jsonURL,data}})
    }
    catch(e){
     let message 
     message = `sheet read error ${file.name} Screen Code :${screenCode}`
     yield put({ type: MENU_FAILURE, errors: message })
    }
  }
  catch(e){
    let message 
    message = `Excel file read error file:${file.name} Screen Code :${screenCode}`
    yield put({ type: MENU_FAILURE, errors: message })
   }
}
*/