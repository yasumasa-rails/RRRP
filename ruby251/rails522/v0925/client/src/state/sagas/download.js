import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {DOWNLOAD_SUCCESS,DOWNLOAD_FAILURE,}
         from '../../actions'
import {getLoginState} from '../reducers/auth'
//import { ReactReduxContext } from 'react-redux';


function screenApi({params,token,client,uid}) {
  let url = 'http://localhost:3001/api/menus7'
  const headers = {'access-token':token,'client':client,'uid':uid }

  const options ={method:'POST',
  //  data: qs.stringify(data),
    params: params,
    headers:headers,
    url,}
    return (axios(options));
}

export function* DownloadSaga({ payload: {params}  }) {
  const loginState = yield select(getLoginState) 
  let token = loginState.token       
  let client = loginState.client         
  let uid = loginState.uid 

  let response  = yield call(screenApi,{params ,token,client,uid} )
  let message
  switch (response.status) {
    case 200:  
          yield put({ type: DOWNLOAD_SUCCESS, payload: response })   
          break
    case 500:
           message = 'Internal Server Error';
           yield put({ type: DOWNLOAD_FAILURE, errors: message })
           break
    case 401:
            message = 'Invalid credentials'; 
            yield put({ type: DOWNLOAD_FAILURE, errors: message })
            break
    default:
           message = `${response.status} : Something went wrong ${response.statusText}`;}
           yield put({ type: DOWNLOAD_FAILURE, errors: message })
 }