import { call, put} from 'redux-saga/effects'
import axios         from 'axios'

import { EDITUPLOADTITLE_SUCCESS, MENU_FAILURE, } from 'actions';

function EditUploadTitleApi({values}) {
  const url = `http://localhost:3001/api/uploads/:${values.id}`
  const headers =  { 'access-token':values.token, 
                    client:values.client,
                    uid:values.uid,}
  const params =  {id:values.id,title:values.title,contents:values.contents}

  let getApi = (url, params,headers) => {
    return axios({
      method: values.deleteflg?"DELETE":"PUT",
      url: url,
      params,headers,
    });
  };
  return getApi(url, params,headers)
}

export function* EditUploadTitleSaga({ payload: {values} }) {
  let response   = yield call(EditUploadTitleApi, ({values} ) )
  if(response.data){
      yield put({ type: EDITUPLOADTITLE_SUCCESS, payload: response.data })
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
