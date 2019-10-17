import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {SCREEN_SUCCESS,SCREEN_FAILURE,SCREEN_LINEEDIT, FETCH_RESULT, FETCH_FAILURE,YUP_RESULT}
         from '../../actions'
import {getScreenState} from '../reducers/screen'
import {getLoginState} from '../reducers/login'
//import { ReactReduxContext } from 'react-redux';

function screenApi({params,token,client,uid}) {
  const url = 'http://localhost:3001/api/menus'
  const headers = {'access-token':token,'client':client,'uid':uid }

  let postApi = (url, params, headers) => {
    return axios({
        method: "POST",
        url: url,
        contentType: "application/json",
        params:params,
        headers:headers,
    });
  };
  return postApi(url, params, headers)
}

export function* ScreenSaga({ payload: {params}  }) {
  const screenState = yield select(getScreenState) //message="" confirm=""になっている。
  const loginState = yield select(getLoginState) 
  let token = loginState.auth["access-token"]       
  let client = loginState.auth.client         
  let uid = loginState.auth.uid 
  try {
      let response  = yield call(screenApi,{params ,token,client,uid} )
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

        case "confirm":
            screenState.data[params.index] = response.data.linedata
            return yield put({ type: SCREEN_LINEEDIT, payload:{data:screenState.data} })   

        case "fetch_request":
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
                  screenState.data[params.index][`${idx}_gridmessage`] = "ok"
                return screenState.data
                })
              return  yield put({ type: FETCH_RESULT, payload: {data:screenState.data} })   
              }    
        case "check_request":   //帰りはfetchと同じ
                  screenState.data[params.index].confirm_gridmessage =  ""
                  if(response.data.params.err){
                      tmp =  JSON.parse(response.data.params.checkcode)
                      Object.keys(tmp).map((idx)=>{
                        screenState.data[params.index][`${idx}_gridmessage`] = response.data.params.err
                        screenState.data[params.index].confirm_gridmessage =  response.data.params.err
                      return screenState.data
                      })
                    return yield put({ type: FETCH_FAILURE, payload: {data:screenState.data} })   
                  }
                  else{
                      tmp =  JSON.parse(response.data.params.checkcode)
                      Object.keys(tmp).map((idx)=>{
                        screenState.data[params.index][`${idx}_gridmessage`] = "ok"
                      return screenState.data
                      })
                    return  yield put({ type: FETCH_RESULT, payload: {data:screenState.data} })   
                    }    
        case "yup":  // create yup schema
              return yield put({ type: YUP_RESULT, payload: {message:response.data.params.message} })    
        default:
          return {}
      }
  }catch(e)
     {  
      let message;
      switch (e.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = `Something went wrong ${e.error}` ;}
      yield put({ type: SCREEN_FAILURE, errors: message })
  }
 }      
