import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {DOWNLOAD_SUCCESS,DOWNLOAD_FAILURE,}
         from '../../actions'
import {getLoginState} from '../reducers/auth'
//import { ReactReduxContext } from 'react-redux';


function screenApi({params,token,client,uid}) {
  let url
  switch(true){
    case /7$/.test(params.req):
       url = 'http://localhost:3001/api/menus7'
       break
    default:
      url = 'http://localhost:3001/api/menus'
  }     
  const headers = {'access-token':token,'client':client,'uid':uid }

  const options ={method:'POST',
  //  data: qs.stringify(data),
    params: params,
    headers:headers,
    url,}
    return (axios(options)
      .then((response ) => {
        return  {response}  ;
        })
      .catch(error => (
        { error }
    )));
}

export function* DownloadSaga({ payload: {params}  }) {
  const loginState = yield select(getLoginState) 
  let token = loginState.token       
  let client = loginState.client         
  let uid = loginState.uid 
  
  let {response,error}  = yield call(screenApi,{params ,token,client,uid} )
      if(response || !error){
          return yield put({ type: DOWNLOAD_SUCCESS, payload: response })   
      }else
     {  
      let message
       switch (true) {
           case /code.*500/.test(error): message = 'Internal Server Error'; break;
           case /code.*401/.test(error): message = 'Invalid credentials'; break;
           default: message = `Something went wrong ${error}`;}
      yield put({ type: DOWNLOAD_FAILURE, errors: message })
  }
 } 