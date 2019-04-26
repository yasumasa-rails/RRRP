import { call, put} from 'redux-saga/effects'
import axios         from 'axios'

import { BUTTONLIST_SUCCESS, MENU_FAILURE} from 'actions';

function ButtonListGetApi({token,client,uid}) {
  const url = 'http://localhost:3001/api/menus'
  const headers =  { 'access-token':token.token, 
                    client:client.client,
                    uid:uid.uid,}
  const params =  {uid:uid.uid,req:'bottunlistreq'}

  let getApi = (url, params,headers) => {
    return axios({
      method: "POST",
      url: url,
      params,headers,
    });
  };
  return getApi(url, params,headers)
}

// MenuSaga({ payload: { token,client,uid} })  出し手と合わすこと
export function* ButtonListSaga({ payload: {token,client,uid} }) {
  let response   = yield call(ButtonListGetApi, ({token,client,uid} ) )
  if(response.data){
      yield put({ type: BUTTONLIST_SUCCESS, payload: response.data })}
  else{    
      let message = `error ${response}`;
      if(response.error){
      switch (response.status) {
              case 500: message = 'Menu Internal Server Error'; break;
              case 401: message = 'Menu Invalid credentials'; break;
              default: message = `error status ${response.status}`;}
      yield put({ type: MENU_FAILURE, errors: message })
      }  
    }
 }      
