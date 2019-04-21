import { call,put} from 'redux-saga/effects'
import axios         from 'axios'

import history from 'histrory'
import {  LOGOUT_SUCCESS } from '../../actions';

function logoutApi(auth) {
  const url = 'http://localhost:3001/api/auth/sign_out'
  const headers =  { 'access-token':auth.token, 'client':auth.client,'uid':auth.uid}
  const params =  { 'uid':auth.uid}

  let getApi = (url, params,headers) => {
    return axios({
      method: "DELETE",
      url: url,
      params:params, headers:headers
    });
  };
  return getApi(url, params,headers)
}

export function* LogoutSaga({ payload: auth }) {
      yield call(logoutApi, auth )
      yield put({ type: LOGOUT_SUCCESS})
      yield call(history.push,'/login')  //
      // persistor.purge() これを実行すると、Storageに保存された情報がクリアされる
     //else{  
     // let message;
     // switch (response.status) {
     //         case 500: message = 'Menu Internal Server Error'; break;
     //         case 401: message = 'Menu Invalid credentials'; break;
     //         default: message = response.status;}
     // yield put({ type: MENU_FAILURE, errors: message })
      // persistor.purge() これを実行すると、Storageに保存された情報がクリアされる
    //} 
  } 
//  送信されてない。