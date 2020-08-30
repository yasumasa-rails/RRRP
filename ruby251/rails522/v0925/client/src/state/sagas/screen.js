import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {SCREEN_SUCCESS,SCREEN_SUCCESS7,
        SCREEN_FAILURE,SCREEN_LINEEDIT, FETCH_RESULT, FETCH_FAILURE,}
         from '../../actions'
import {getScreenState} from '../reducers/screen'
import {getLoginState} from '../reducers/auth'
//import { ReactReduxContext } from 'react-redux';

function screenApi({params ,url,headers} ) {
  
    return axios({
        method: "POST",
        url: url,
        contentType: "application/json",
        params:params,
        headers:headers,
    })
  }

export function* ScreenSaga({ payload: {params}  }) {
  const screenState = yield select(getScreenState) //message="" confirm=""になっている。
  const loginState = yield select(getLoginState) 
  let token = loginState.token       
  let client = loginState.client         
  let uid = loginState.uid
  let url = ""
  // let sagaCallTime = new Date()
  // let callTime =  sagaCallTime.getHours() + ":" + sagaCallTime.getMinutes() + ":" + 
  //                 sagaCallTime.getSeconds()  + ":" + sagaCallTime.getMilliseconds()
  switch(true){
    case /7$/.test(params.req):
       url = 'http://localhost:3001/api/menus7'
       break
    default:
      url = 'http://localhost:3001/api/menus'
  }     

  const headers = {'access-token':token,'client':client,'uid':uid }
  try {
      let response  = yield call(screenApi,{params ,url,headers} )
      switch(params.req) {
        case 'viewtablereq':
          response.data["params"] = params
          return yield put({ type: SCREEN_SUCCESS, action: response })    //action --> payload

        case 'editabletablereq':
          response.data["params"] = params
          return yield put({ type: SCREEN_SUCCESS, action: response })   

        case 'inlineaddreq':
            response.data["params"] = params
            return yield put({ type: SCREEN_SUCCESS, action: response })   

        case 'viewtablereq7':
             //response.data["params"]["callTime"] = callTime
              return yield put({ type: SCREEN_SUCCESS7, action: response })    //action --> payload
    
        case 'editabletablereq7':
              return yield put({ type: SCREEN_SUCCESS7, action: response })   
    
        case 'inlineaddreq7':
              return yield put({ type: SCREEN_SUCCESS7, action: response })   
    

        case "confirm":
            screenState.data[params.index] = response.data.linedata
            return yield put({ type: SCREEN_LINEEDIT, payload:{data:screenState.data} })   

        case "fetch_request":  //viewによる存在チェック　内容表示
            let tmp 
            screenState.data[params.index].confirm_gridmessage =  ""
            if(response.data.params.err){
                tmp =  JSON.parse(response.data.params.fetchcode)
                Object.keys(tmp).map((idx)=>{
                  screenState.data[params.index][idx]= tmp[idx]
                  screenState.data[params.index][`${idx}_gridmessage`] = response.data.params.err
                  screenState.data[params.index].confirm_gridmessage =  response.data.params.err
                return screenState.data
                })
              return yield put({ type: FETCH_FAILURE, payload: {data:screenState.data} })   
            }
            else{
                //tmp =  JSON.parse(response.data.params.fetch_data)
                tmp =  response.data.params.fetch_data
                Object.keys(tmp).map((idx)=>{
                  screenState.data[params.index][idx]= tmp[idx]
                  if(tmp[idx]===""){screenState.data[params.index][`${idx}_gridmessage`] = "ok on the way"}
                                    else{screenState.data[params.index][`${idx}_gridmessage`] = "ok fetch"}
                return screenState.data
                })
              return  yield put({ type: FETCH_RESULT, payload: {data:screenState.data} })   
              }    
        case "check_request":   //　項目毎のチェック　帰りはfetchと同じ
                  screenState.data[params.index].confirm_gridmessage =  ""
                  if(response.data.params.err){
                      tmp =  JSON.parse(response.data.params.yupcheckcode)
                      Object.keys(tmp).map((idx)=>{
                        screenState.data[params.index][`${idx}_gridmessage`] = response.data.params.err
                        screenState.data[params.index].confirm_gridmessage =  response.data.params.err
                      return screenState.data
                      })
                    return yield put({ type: FETCH_FAILURE, payload: {data:screenState.data} })   
                  }
                  else{
                      tmp =  JSON.parse(response.data.params.yupcheckcode)
                      Object.keys(tmp).map((idx)=>{
                        screenState.data[params.index][`${idx}_gridmessage`] = "ok check"
                      return screenState.data
                      })
                      tmp = response.data.params.linedata
                      Object.keys(tmp).map((idx)=>{
                        screenState.data[params.index][idx] = tmp[idx]
                      return screenState.data
                      })
                    return  yield put({ type: FETCH_RESULT, payload: {data:screenState.data} })   
                    }    
       // case "yup":  // create yup schema
       //       return yield put({ type: YUP_RESULT, payload: {message:response.data.params.message} })    
        default:
          return {}
      }
  }catch(error)   // status401が拾えない。 
      {  
      let message;
      if(error){ 
          switch (error.status) {
            case 500: message = 'Internal Server Error'; break;
            case 401: message = 'Invalid credentials'; break;
            default: message = `Something went wrong ${error.status} 401 (Unauthorized) or host abort or ???` ;}}
      else{ message = "401 (Unauthorized) ???"
          }        
      yield put({ type: SCREEN_FAILURE, errors: message })
  }
 }      
