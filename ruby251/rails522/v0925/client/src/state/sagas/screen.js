import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {SCREEN_SUCCESS,SCREEN_FAILURE,SCREEN_LINEEDIT, FETCH_RESULT} from '../../actions'
import {getScreenState} from '../reducers/screen'
//import { ReactReduxContext } from 'react-redux';

function screenApi({params,token,client,uid}) {
  const url = 'http://localhost:3001/api/menus'
  const headers = {'access-token':token,'client':client,'uid':uid }

  let postApi = (url, params, headers) => {
    return axios({
        method: "POST",
        url: url,
        params,headers,
    });
  };
  return postApi(url, params, headers)
}

export function* ScreenSaga({ payload: {params,token,client,uid}  }) {
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
          return yield put({ type: SCREEN_LINEEDIT, payload: response })    
        case "fetch_request":
            const screenState = yield select(getScreenState)
            let tmp =  response.data.params.fetchdata
            Object.keys(tmp).map((key)=>{
              screenState.data[params.rowInfo.index][key]= response.data.params.fetchdata[key]
              return screenState.data
            })
            return yield put({ type: FETCH_RESULT, payload: {data:screenState.data} })  
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

