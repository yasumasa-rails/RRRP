import { call, put} from 'redux-saga/effects'
import axios         from 'axios'

import { MENU_SUCCESS, MENU_FAILURE, } from 'actions';
import history from 'histrory'

function MenuGetApi({ token,client,uid}) {
  const url = 'http://localhost:3001/api/menus'
  const headers =  { 'access-token':token, 
                    'client':client,
                    'uid':uid,}
  const params =  { 'uid':uid,}

  let getApi = (url, params) => {
    return axios({
      method: "POST",
      url: url,
      params: params,headers:headers,
    });
  };
  return getApi(url, params)
}

export function* MenuSaga({ payload: { token,client,uid} }) {
  try{
      let ret  = yield call(MenuGetApi, { token,client,uid } )
      yield put({ type: MENU_SUCCESS, action: ret.data })
      yield call(history.push('./menus'))
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
