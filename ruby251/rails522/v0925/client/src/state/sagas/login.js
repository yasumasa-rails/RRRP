import { call, put } from 'redux-saga/effects'
import axios         from 'axios'
import {LOGIN_SUCCESS,LOGIN_FAILURE,
        MenuRequest,ButtonListRequest} from '../../actions'

function loginApi({ email, password}) {
  const url = 'http://localhost:3001/api/auth/sign_in'
  const params =  {'email':email, 'password':password  }
  const headers = { 'Content-Type': 'application/json',
               }

  let postApi = (url, params, headers) => {
    return axios({
      method: "POST",
      url: url,
      params: params,
      headers: headers
    });
  };
  return postApi(url, params, headers)
  .then(response => ({ response }))
  .catch(error => ({ error }))
}

export function* LoginSaga({ payload: { email, password } }) {
  
  let {response,error}  = yield call(loginApi, { email, password} )
    if(response.headers){
      yield put({ type: LOGIN_SUCCESS, action: response.headers })
      const token = {token:response.headers["access-token"]}
      const client = {client:response.headers["client"]}
      const uid = {uid:response.headers["uid"]}
      //yield put({ type: MENU_REQUEST, action: (token,client,uid) })

      yield put(MenuRequest(token,client,uid) )
      
      yield put(ButtonListRequest(token,client,uid) )
  }else
     {  
       let message
      switch (error.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = `Something went wrong ${error.error}`;}
      yield put({ type: LOGIN_FAILURE, payload: message })
  }
 }      
