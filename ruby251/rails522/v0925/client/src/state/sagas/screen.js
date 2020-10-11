import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {SCREEN_SUCCESS7,
        SCREEN_FAILURE,SCREEN_LINEEDIT, FETCH_RESULT, FETCH_FAILURE,}
         from '../../actions'
import {getLoginState} from '../reducers/auth'
import {getButtonState} from '../reducers/button'
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

 // const delay = (ms) => new Promise(res => setTimeout(res, ms)) 
export function* ScreenSaga({ payload: {params,data,loading}  }) {
  const loginState = yield select(getLoginState)  //loginStateの変更は不可　思わぬことが発生。
  const buttonState = yield select(getButtonState) //buttonStateの変更は不可　思わぬことが発生。
  let token = loginState.token       
  let client = loginState.client         
  let uid = loginState.uid
  let url = ""
  // let sagaCallTime = new Date()
  // let callTime =  sagaCallTime.getHours() + ":" + sagaCallTime.getMinutes() + ":" + 
  //             
  url = 'http://localhost:3001/api/menus7'

  const headers = {'access-token':token,'client':client,'uid':uid }
    let message;
    // while (loading===true) {
    //   console.log("delay")
    //   yield delay(100)
    // }
    let xparams = {}
    try{
      let response  = yield call(screenApi,{params ,url,headers} )
      switch (response.status) {
        case 200:  
          switch(params.req) {
            case 'viewtablereq7':
             //response.data["params"]["callTime"] = callTime
              return yield put({ type: SCREEN_SUCCESS7, payload: response })    //action --> payload
    
            case 'inlineedit7':
              return yield put({ type: SCREEN_SUCCESS7, payload: response })   
    
            case 'inlineadd7':
              return yield put({ type: SCREEN_SUCCESS7, payload: response })   
                    
            case "confirm7":
              data[params.index] = {...response.data.linedata}
              params.req = buttonState.buttonflg
              return yield put({ type: SCREEN_LINEEDIT, payload:{data:data,params:params} })   

            case "fetch_request":  //viewによる存在チェック　内容表示
              let tmp 
              xparams = {...response.data.params}
              xparams.req = buttonState.buttonflg
              data[params.index].confirm_gridmessage =  ""
              if(response.data.params.err){
                 tmp =  JSON.parse(response.data.params.fetchcode) //javascript -->rails hush で渡せず
                 tmp.map((idx)=>{
                   data[params.index][`${Object.keys(idx)[0]}_gridmessage`] = response.data.params.err
                   data[params.index].confirm_gridmessage =  response.data.params.err
                 return null
                 })
                return yield put({ type: FETCH_FAILURE, payload: {data:data,params:xparams} })   
              }
              else{
                  //tmp =  JSON.parse(response.data.params.fetch_data)
                   Object.keys(response.data.params.fetch_data).map((idx)=>{
                             data[params.index][idx]= response.data.params.fetch_data[idx]
                             if(response.data.params.fetch_data[idx]==="")
                                         {data[params.index][`${idx}_gridmessage`] = "on the way"}
                                     else{data[params.index][`${idx}_gridmessage`] = "detected"}
                     return null
                   })
                return  yield put({ type: FETCH_RESULT, payload: {data:data,params:xparams} })   
              }    
            case "check_request":   //　項目毎のチェック　帰りはfetchと同じ
                  xparams = {...response.data.params}
                  xparams.req = buttonState.buttonflg
                  data[params.index].confirm_gridmessage =  ""
                  if(response.data.params.err){
                       tmp =  JSON.parse(response.data.params.yupcheckcode)
                       Object.keys(tmp).map((idx)=>{
                         data[params.index][`${idx}_gridmessage`] = response.data.params.err
                         data[params.index].confirm_gridmessage =  response.data.params.err
                       return null
                      })
                    return yield put({ type: FETCH_FAILURE, payload: {data:data,params:xparams} })   
                  }
                  else{
                       tmp =  JSON.parse(response.data.params.yupcheckcode)
                       Object.keys(tmp).map((idx)=>{
                         data[params.index][`${idx}_gridmessage`] = "ok check"
                       return data
                       })
                       tmp = response.data.params.linedata
                       Object.keys(tmp).map((idx)=>{
                         data[params.index][idx] = tmp[idx]
                       return null
                       })
                    return  yield put({ type: FETCH_RESULT, payload: {data:data,params:xparams} })   
                    }    
              // case "yup":  // create yup schema
              //       return yield put({ type: YUP_RESULT, payload: {message:response.data.params.message} })    
              default:
                return {}
            }
            case 500: message = `${response.status}: Internal Server Error ${response.statusText}`;
                    data[params.index]["confirm_gridmessage"] = message
                    break;
            case 401: message = `${response.status}: Invalid credentials ${response.statusText}`;
                    data[params.index]["confirm_gridmessage"] = message
                    break;
            default:
                    data[params.index]["confirm_gridmessage"] = message
                    message = `${response.status}: Something went wrong ${response.statusText} `;
      }
      return  yield put({ type: SCREEN_FAILURE, payload:{message:message,data:data  }})   
    }
    catch(e){
      message = ` Something went wrong ${e} `;
      data[params.index]["confirm_gridmessage"] = message
      return  yield put({ type: SCREEN_FAILURE, payload:{message:message,data}})   
    }
  }
