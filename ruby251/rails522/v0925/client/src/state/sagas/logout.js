import { call,put} from 'redux-saga/effects'
import axios         from 'axios'
import {persistor} from '../../state/store.js'

import history from 'histrory'
import {  LOGOUT_SUCCESS , MENU_FAILURE} from '../../actions';

function logoutApi(token,client,uid) {
  const url = 'http://localhost:3001/api/auth/sign_out'
  const headers =  { 'access-token':token, 'client':client,'uid':uid}
  const params =  { 'uid':uid}

  let getApi = (url, params,headers) => {
    return axios({
      method: "DELETE",
      url: url,
      params:params, headers:headers
    });
  };
  return (getApi(url, params,headers)
  .then((response ) => {
    return  {response}  ;
  })
  .catch(error => (
    { error }
  )));
}

export function* LogoutSaga({ payload: {token,client,uid} }) {
  let {response,error} = yield call(logoutApi, token,client,uid )
    if(response || !error){
      yield put({ type: LOGOUT_SUCCESS})
      yield call(history.push,'/login')  //
      // persistor.purge() これを実行すると、Storageに保存された情報がクリアされる
    }else{  
      persistor.purge() //これを実行すると、Storageに保存された情報がクリアされる
      yield call(history.push,'/login') 
      let message;
      switch (error.status) {
              case 500: message = 'Menu Internal Server Error'; break;
              case 401: message = 'Menu Invalid credentials'; break;
              default: message = response.status;}
      yield put({ type: MENU_FAILURE, errors: message })
    } 
  } 
//  送信されてない。