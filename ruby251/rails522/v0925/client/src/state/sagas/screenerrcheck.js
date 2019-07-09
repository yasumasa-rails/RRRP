import {put,call} from 'redux-saga/effects'
import {SCREEN_ERR_CHECK_RESULT,SCREEN_REQUEST} from '../../actions'
//import {getLoginState} from '../reducers/login'
function  validateApi({schema,data,index}) { 
  let dataIndex =   data[index]    
    return schema.validate(dataIndex)
    .then(response => ({ response }))
    .catch(err => ({ err }))
}

export function * ScreenErrCheckSaga ({payload: {schema,data,index,field,params}}) {
  let dataIndex =   data[index]
  if(dataIndex.gridmessage===""||dataIndex.gridmessage===null||dataIndex.gridmessage===undefined)
    {dataIndex.gridmessage={}} 
  const { err } = yield call( validateApi,{schema,data,index})
  switch(field) {
    case "confirm"  :  //1行すべてのチェック
      if(err){
              dataIndex.confirm = false
              dataIndex.gridmessage[err.path] = err.errors.join(",")
              dataIndex.gridmessage["confirm"] = `err ${err.path}`
              return yield put({ type: SCREEN_ERR_CHECK_RESULT, payload: {data:data}})
                       }
      else{dataIndex.confirm = true
            dataIndex.gridmessage = {}
            params= {...params,req:"updateGridLineData",linedata:dataIndex,index:index}
            return yield put({ type:SCREEN_REQUEST,payload:{params}})}  
    default:  
      if(err){
              dataIndex.gridmessage[field] = err.errors.join(",")
              return yield put({ type: SCREEN_ERR_CHECK_RESULT, payload: {data:data}})
               }
      else{ 
              dataIndex.gridmessage[field] = ""
              return yield put({ type:SCREEN_ERR_CHECK_RESULT, payload:{data:data} }) 
                    }
                     
  }
 }

