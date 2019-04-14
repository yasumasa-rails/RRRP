import { call, put} from 'redux-saga/effects'
import axios         from 'axios'

import history from 'histrory'
import {  MENU_FAILURE } from '../../actions';

function logoutApi({ email,token,client,uid}) {
  const url = 'http://localhost:3001/api/auth/sign_out'
  const headers =  { 'access-token':token.token, 
                    client,uid,}
  const params =  { uid}

  let getApi = (url, params,headers) => {
    return axios({
      method: "DELETE",
      url: url,
      params: params,headers:headers,
    });
  };
  return getApi(url, params)
}

export function* LogoutSaga({ payload: { email,token,client,uid} }) {
  try{
      yield call(logoutApi, {email, token,client,uid } )
      yield call(history.push('/login'))  ///有効にならない
  }catch (error)
     {  
      let message;
      switch (error.status) {
              case 500: message = 'Menu Internal Server Error'; break;
              case 401: message = 'Menu Invalid credentials'; break;
              default: message = error.errors;}
      yield put({ type: MENU_FAILURE, payload: message })
  }
 }      
