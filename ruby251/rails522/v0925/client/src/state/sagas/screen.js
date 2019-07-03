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
  let response  = yield call(screenApi,{params ,token,client,uid} )
  if(response){
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
        case "updateGridLineData":
          screenState.data[params.index]["id"] = response.data.params.addId
          screenState.data[params.index]["gridmessage"] = response.data.params.addId
          return yield put({ type: SCREEN_LINEEDIT, payload:{data:screenState.data} })    
        case "fetch_request":
            if(screenState.data[params.index].gridmessage===""||screenState.data[params.index].gridmessage===null||screenState.data[params.index].gridmessage===undefined)
                    {screenState.data[params.index].gridmessage={}}
            if(response.data.params.err){
              response.data.params.keys.map((key)=>{
                 Object.keys(screenState.data[params.index]).map((idx)=>
                    {if(idx.split("_")[0] === key.split("_")[0]){
                          screenState.data[params.index][key]= ""
                          screenState.data[params.index]["gridmessage"][key] = response.data.params.err}
                          return screenState.data})
                 if(key.match(/_code/)&&params.screenCode.split("_")[1].slice(0,-1)!==key.split("_")[0]){
                   screenState.data[params.index][params.screenCode.split("_")[1].slice(0,-1)+"_"+key.replace("code","id")]= ""}
               return screenState.data
               })
              return yield put({ type: FETCH_FAILURE, payload: {data:screenState.data} })   
            }
            else{
              let tmp =  response.data.params.fetchdata
               Object.keys(tmp).map((key)=>{
                  screenState.data[params.index][key]= response.data.params.fetchdata[key]
                  screenState.data[params.index].gridmessage[key] = ""
                return screenState.data
                })
               return yield put({ type: FETCH_RESULT, payload: {data:screenState.data} })   
              } 
        case "yup":  // create yup schema
              return yield put({ type: YUP_RESULT, payload: {message:response.data.params.message} })    
        default:
          return {}
      }
  }else
     {  
      let message;
      switch (response.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = `Something went wrong ${response.error}` ;}
      yield put({ type: SCREEN_FAILURE, errors: message })
  }
 }      

