import { call, put } from 'redux-saga/effects'
import axios         from 'axios'
import {EDITUPLOAD_RESULT} from '../../actions'



function EditUploadApi({values}){

  const url = `http://localhost:3001/api/uploads/${values.id}`
  const headers =  { 'access-token':values.token, 
                    client:values.client,
                    uid:values.uid,}
  //                  file:values.excel[0]
  const params = {title:values.title,contents:values.contents,email:values.uid}  
  let getApi = (url, params) => {
    return axios({
      method:"PUT",
      url: url,
      headers,params,
    });
  };
  return getApi(url, params)
}


export function* EditUploadSaga({ payload: { values } }) {
   try{
      let response = yield call(EditUploadApi, { values } )
      let message = response.statusText
      yield put({ type: EDITUPLOAD_RESULT, payload: message })
   }catch(error){
      let message
      if(error){
         switch (error.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = 'Something went wrong   :'&&error;}
      }else{message = 'Something went wrong '}     
      yield put({ type: EDITUPLOAD_RESULT, payload: message })
   }
 }      
