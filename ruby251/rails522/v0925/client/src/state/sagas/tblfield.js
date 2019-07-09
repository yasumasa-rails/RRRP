import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import {TBLFIELD_SUCCESS, TBLFIELD_FAILURE,
        }     from '../../actions'
import {getLoginState} from '../reducers/login'
import {getScreenState} from '../reducers/screen'
//import { ReactReduxContext } from 'react-redux';


function screenApi({params,token,client,uid}) {
  const url = 'http://localhost:3001/api/tblfields'
  const headers = {'access-token':token,'client':client,'uid':uid }

  let postApi = (url, params, headers) => {
    return axios({
        method: "POST",
        url: url,
        contentType: "application/json",
        params:params,
        headers:headers,
    });
  };
  return postApi(url, params, headers)
}

export function* TblfieldSaga({ payload: {params}  }) {
  const loginState = yield select(getLoginState) 
  let token = loginState.auth["access-token"]       
  let client = loginState.auth.client         
  let uid = loginState.auth.uid    
  const screenState = yield select(getScreenState) //
  params["data"] = screenState.data
  let response  = yield call(screenApi,{params ,token,client,uid} )
  if(response){
      switch(params.req) {
        case "yup":  // create yup schema
              return yield put({ type: TBLFIELD_SUCCESS, payload: {message:response.data.params.message} })   
        case "createTblViewScreen":  // create  or add field table and create or replacr view  and create screen
              return yield put({ type: TBLFIELD_SUCCESS, payload: {message:response.data.params.message} })     
        default:
          return {}
      }
  }else
     {  
      let message;
      switch (response.status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = `Something went wrong ${response.error}` ;}
      yield put({ type: TBLFIELD_FAILURE, errors: message })
  }
 }      

