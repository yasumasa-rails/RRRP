import { call, put, select } from 'redux-saga/effects'
import axios         from 'axios'
import { GANTTCHART_SUCCESS,GANTTCHART_FAILURE,}     from '../../actions'
import {getLoginState} from '../reducers/login'
import {getScreenState} from '../reducers/screen'
//import { ReactReduxContext } from 'react-redux';


function GanttApi({params,token,client,uid}) {
  const url = 'http://localhost:3001/api/ganttcharts'
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

export function* GanttChartSaga({ payload: {params}  }) {
  const loginState = yield select(getLoginState) 
  let token = loginState.auth["access-token"]       
  let client = loginState.auth.client         
  let uid = loginState.auth.uid    
  const screenState = yield select(getScreenState) //
  params["linedata"] = screenState.data[params.onClickSelect.index]
  let response  = yield call(GanttApi,{params ,token,client,uid} )
  if(response){
      switch(params.req) {
        case "ganttchart":  // create yup schema
              return yield put({ type: GANTTCHART_SUCCESS, payload: response.data} )  
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
      yield put({ type:GANTTCHART_FAILURE, errors: message })
  }
 }      

