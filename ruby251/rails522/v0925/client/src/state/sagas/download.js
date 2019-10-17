import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {DOWNLOAD_SUCCESS,DOWNLOAD_FAILURE,}
         from '../../actions'
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

export function* DownloadSaga({ payload: {params}  }) {
  const loginState = yield select(getLoginState) 
  let token = loginState.auth["access-token"]       
  let client = loginState.auth.client         
  let uid = loginState.auth.uid 
  let response  = yield call(screenApi,{params ,token,client,uid} )
  if(response){
          return yield put({ type: DOWNLOAD_SUCCESS, payload: response })   
  }else
     {  
      let message;
      switch (response.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = `Something went wrong ${response.error}` ;}
      yield put({ type: DOWNLOAD_FAILURE, errors: message })
  }
 } 