import { call, put} from 'redux-saga/effects'
import { EXCELTOJSON_SUCCESS, MENU_FAILURE, } from 'actions';
import readXlsxFile from 'read-excel-file'

function readExcelApi({file}) {

  let getApi = (file) => {
    return readXlsxFile(file)
  };
  return getApi(file)
}

export function* ExcelToJsonSaga({ payload: {file,screenCode} }) {
  try{
  let sheet   = yield call(readExcelApi, ({file} ) )
      yield put({ type: EXCELTOJSON_SUCCESS, payload:{sheet:sheet,filename:file.name} })
  }
  catch(e){  
      let message 
      message = `Excel file read error file:${file.name} Screen Code :${screenCode}`
      yield put({ type: MENU_FAILURE, errors: message })
    }
 }  