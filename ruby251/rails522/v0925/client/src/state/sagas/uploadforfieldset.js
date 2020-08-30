/*
import { call, put,select} from 'redux-saga/effects'
import { EXCELTOJSON_SUCCESS, MENU_FAILURE, } from 'actions';
import {getLoginState} from '../reducers/auth'

function uploadFile({jsonfilename,screenCode,token,client,uid}){
  const headers={"access-token":token,"client":client,"uid":uid}
  const body = JSON.stringify({ post: { title:screenCode , excel: jsonfilename }})
  
  // configure your fetch url appropriately
  fetch(`http://localhost:3001/api/uploads`, {
    method: "post",
    body: body,
    headers:headers,
      })
    .then(res => res.json())
    .then(data => {
     // do something with the returned data
     console.log("cc")
        })
    .catch(error => console.error('Error:', error))
      }

export function* UploadForFieldSetSaga({ payload: {jsonfilename,screenCode} }) {
  const loginState = yield select(getLoginState) 
  let token = loginState.token       
  let client = loginState.client         
  let uid = loginState.uid 
     try{
      let jsonfile   = yield call(uploadFile,({jsonfilename,screenCode,token,client,uid}))
      yield put({type:EXCELTOJSON_SUCCESS, payload:{jsonfile:jsonfile}})
     }
     catch(e){
      let message 
      message = `Excel file read error file:${e} Screen Code :${screenCode}`
      yield put({ type: MENU_FAILURE, errors: message })
     }
}  
*/