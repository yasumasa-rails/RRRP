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

export function* ScreenSaga({ payload: {params,data}  }) {
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
      let response  = yield call(screenApi,{params ,url,headers} )
      let message;
      switch (response.status) {
        case 200:  
          switch(params.req) {
            case 'viewtablereq7':
             //response.data["params"]["callTime"] = callTime
              return yield put({ type: SCREEN_SUCCESS7, action: response })    //action --> payload
    
            case 'inlineedit7':
              return yield put({ type: SCREEN_SUCCESS7, action: response })   
    
            case 'inlineadd7':
              return yield put({ type: SCREEN_SUCCESS7, action: response })   
                    
            case "confirm7":
              data[params.index] = response.data.linedata
              params.req = buttonState.buttonflg
              return yield put({ type: SCREEN_LINEEDIT, payload:{data:data,params:params} })   

            case "fetch_request":  //viewによる存在チェック　内容表示
              let tmp 
              params.req = buttonState.buttonflg
              data[params.index].confirm_gridmessage =  ""
              if(response.data.params.err){
                tmp =  JSON.parse(response.data.params.fetchcode)
                Object.keys(tmp).map((idx)=>{
                  data[params.index][idx]= tmp[idx]
                  data[params.index][`${idx}_gridmessage`] = response.data.params.err
                  data[params.index].confirm_gridmessage =  response.data.params.err
                return data
                })
                return yield put({ type: FETCH_FAILURE, payload: {data:data,params:params} })   
                }
                else{
                  //tmp =  JSON.parse(response.data.params.fetch_data)
                  tmp =  response.data.params.fetch_data
                  Object.keys(tmp).map((idx)=>{
                    data[params.index][idx]= tmp[idx]
                    if(tmp[idx]===""){data[params.index][`${idx}_gridmessage`] = "ok on the way"}
                                    else{data[params.index][`${idx}_gridmessage`] = "detected"}
                    return data
                  })
                return  yield put({ type: FETCH_RESULT, payload: {data:data,params:params} })   
                }    
            case "check_request":   //　項目毎のチェック　帰りはfetchと同じ
                  params.req = buttonState.buttonflg
                  data[params.index].confirm_gridmessage =  ""
                  if(response.data.params.err){
                      tmp =  JSON.parse(response.data.params.yupcheckcode)
                      Object.keys(tmp).map((idx)=>{
                        data[params.index][`${idx}_gridmessage`] = response.data.params.err
                        data[params.index].confirm_gridmessage =  response.data.params.err
                      return data
                      })
                    return yield put({ type: FETCH_FAILURE, payload: {data:data,params:params} })   
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
                      return data
                      })
                    return  yield put({ type: FETCH_RESULT, payload: {data:data,params:params} })   
                    }    
              // case "yup":  // create yup schema
              //       return yield put({ type: YUP_RESULT, payload: {message:response.data.params.message} })    
              default:
                return {}
            }
            case 500: message = `${response.status}: Internal Server Error ${response.statusText}`; break;
            case 401: message = `${response.status}: Invalid credentials ${response.statusText}`; break;
            default: message = `${response.status}: Something went wrong ${response.statusText} `;
      }
      return  yield put({ type: SCREEN_FAILURE, payload:message  })   
    }
