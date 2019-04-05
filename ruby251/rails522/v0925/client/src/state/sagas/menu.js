import { call, put} from 'redux-saga/effects'
import axios         from 'axios'

import { MENU_SUCCESS, MENU_FAILURE, } from 'actions';
import history from 'histrory'

function MenuGetApi({ token,client,uid}) {
  const url = 'http://localhost:3001/api/menu'
  const params =  {'uid':uid,
                    'access-token':token, 
                    'client':client,
                                }

  let getApi = (url, params) => {
    return axios({
      method: "GET",
      url: url,
      params: params,responseType: 'json',
    });
  };
  return getApi(url, params)
}

export function* MenuSaga({ payload: { token,client,uid} }) {
  try{
      let ret  = yield call(MenuGetApi, { token,client,uid } )
      yield put({ type: MENU_SUCCESS, action: ret.data })
      yield call(history.push('./menu'))
  }catch (error)
     {  
      let message;
      switch (error.status) {
              case 500: message = 'Menu Internal Server Error'; break;
              case 401: message = 'Menu Invalid credentials'; break;
              default: message = 'Menu Something went wrong';}
      yield put({ type: MENU_FAILURE, payload: message })
  }
 }      
