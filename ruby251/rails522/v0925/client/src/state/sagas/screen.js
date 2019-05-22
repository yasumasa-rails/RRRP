
import React from 'react'
import { call, put } from 'redux-saga/effects'
import axios         from 'axios'
import {SCREEN_SUCCESS,SCREEN_FAILURE} from '../../actions'

function screenApi({params,token,client,uid}) {
  const url = 'http://localhost:3001/api/menus'
  const headers = {'access-token':token,'client':client,'uid':uid }

  let postApi = (url, params, headers) => {
    return axios({
        method: "POST",
        url: url,
        params,headers,
    });
  };
  return postApi(url, params, headers)
}

export function* ScreenSaga({ payload: {params,token,client,uid}  }) {
  let response  = yield call(screenApi,{params ,token,client,uid} )
  if(response){
      response.data["params"] = params
      yield put({ type: SCREEN_SUCCESS, action: response })
  }else
     {  
      let message;
      switch (response.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = `Something went wrong ${response.error}` ;}
      yield put({ type: SCREEN_FAILURE, errors: message })
  }
 }      

