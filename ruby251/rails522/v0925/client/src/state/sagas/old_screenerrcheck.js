import {put,call, select} from 'redux-saga/effects'
import {SCREEN_ERR_CHECK_RESULT,SCREEN_REQUEST} from '../../actions'
import {getScreenState} from '../reducers/screen'
//import {getLoginState} from '../reducers/login'
function  validateApi({schema,linedata}) { 
    return schema.validate(linedata)
    .then(response => ({ response }))
    .catch(err => ({ err }))
}

export function * ScreenErrCheckSaga ({payload: {schema,linedata,field,params}}) {
  if(linedata.gridmessage===""||linedata.gridmessage===null||linedata.gridmessage===undefined)
       {linedata.gridmessage={}} 
  const screenState = yield select(getScreenState) //message="" confirm=""になっている。
  const { err } = yield call( validateApi,{schema,linedata})
  screenState.data[params.index] = linedata
  switch(field) {
    case "confirm"  :  //1行すべてのチェック
      if(err){
              linedata.confirm = false
              linedata.gridmessage[err.path] = err.errors.join(",")
              linedata.gridmessage["confirm"] = `err ${err.path}`
              return yield put({ type: SCREEN_ERR_CHECK_RESULT, payload: {data:screenState.data}})
                       }
      else{linedata.confirm = true
            linedata.gridmessage = {}
            linedata.gridmessage["confirm"] = ""
            params= {...params,req:"updateGridLineData",linedata:linedata}
            return yield put({ type:SCREEN_REQUEST,payload:{params}})}  
    default:  
      if(err){
              linedata.gridmessage[field] = err.errors.join(",")
              linedata.gridmessage["confirm"] = `err ${err.path}`
              return yield put({ type: SCREEN_ERR_CHECK_RESULT, payload: {data:screenState.data}})
               }
      else{ 
              linedata.gridmessage[field] = ""
              linedata.gridmessage["confirm"] = ""
              return yield put({ type:SCREEN_ERR_CHECK_RESULT, payload:{data:screenState.data} }) 
                    }
                     
  }
 }

