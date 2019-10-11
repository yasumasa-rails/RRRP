import { call, put} from 'redux-saga/effects'
import axios         from 'axios'

import { UPLOADLIST_SUCCESS, MENU_FAILURE, } from 'actions';

function UploadListApi({values}) {
  const url = 'http://localhost:3001/api/uploads'
  const headers =  { 'access-token':values.token, 
                    client:values.client,
                    uid:values.uid,}
  const params =  {email:values.email,count:values.count}

  let getApi = (url, params,headers) => {
    return axios({
      method: "GET",
      url: url,
      params,headers,
    });
  };
  return getApi(url, params,headers)
}

export function* UploadListSaga({ payload: {values} }) {
  let response   = yield call(UploadListApi, ({values} ) )
  if(response.data){
      yield put({ type: UPLOADLIST_SUCCESS, payload: response.data })
  }
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
