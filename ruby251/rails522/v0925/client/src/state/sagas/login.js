import { call, put } from 'redux-saga/effects'
import axios         from 'axios'
import {LOGIN_SUCCESS,LOGIN_FAILURE,MenuRequest} from '../../actions'

function loginApi({ email, password}) {
  const url = 'http://localhost:3001/api/auth/sign_in'
  const params =  JSON.stringify({'email':email, 'password':password  })
  const headers = { 'Content-Type': 'application/json',
               }

  let postApi = (url, params, headers) => {
    return axios({
      method: "POST",
      url: url,
      data: params,
      headers: headers
    });
  };
  return postApi(url, params, headers)
}

export function* LoginSaga({ payload: { email, password } }) {
  try{
      let response  = yield call(loginApi, { email, password} )
      yield put({ type: LOGIN_SUCCESS, action: response.headers })
      const token = response.headers["access-token"]
      const client = response.headers["client"]
      const uid = response.headers["uid"]
      //yield put({ type: MENU_REQUEST, action: (token,client,uid) })
      yield put(MenuRequest(token,client,uid) )
  }catch (error)
     {  
      let message;
      switch (error.response) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = 'Something went wrong';}
      yield put({ type: LOGIN_FAILURE, payload: message })
  }
 }      
