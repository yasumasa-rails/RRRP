import { call, put ,select } from 'redux-saga/effects'
import axios         from 'axios'
import {CHECKJSONDATA_SUCCESS, MENU_FAILURE} from '../../actions'
import {getLoginState} from '../reducers/login'

function jsonApi({lines,screenCode,yup,token,client,uid}){

  const url = `http://localhost:3001/api/jsons`
  const headers =  { 'access-token':token, 
                    client:client,
                    uid:uid,}

  const params = {screenCode:screenCode,lines:lines,uid:uid,
                  yupfetchcode:yup.yupfetchcode,yupcheckcode:yup.yupcheckcode}  
  let getApi = (url, params) => {
    return axios({
      method:"POST",
      url: url,
      headers,params,
    });
  };
  return getApi(url, params)
}


export function* CheckJsonDataSaga({ payload: {lines,screenCode,yup } }) {
  const loginState = yield select(getLoginState) 
  let token = loginState.auth["access-token"]       
  let client = loginState.auth.client         
  let uid = loginState.auth.uid 
   try{
      let response = yield call(jsonApi, {lines,screenCode,yup,token,client,uid } )
      yield put({ type: CHECKJSONDATA_SUCCESS, payload: {results:response.data.results} })
   }catch(error){
      let message
      if(error){
         switch (error.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = 'Something went wrong   :'&&error;}
      }else{message = 'Something went wrong '}     
      yield put({ type: MENU_FAILURE, payload: message })
   }
 }      
