import { call, put } from 'redux-saga/effects'
import axios         from 'axios'
import {UPLOAD_SUCCESS,MENU_FAILURE} from '../../actions'



function UploadApi({values}){

  const url = `http://localhost:3001/api/uploads/`
  const headers =  { 'access-token':values.token, 
                    client:values.client,
                    uid:values.uid,}
  const params =  {excel:values.excel,title:values.title,contents:values.contents}

  let getApi = (url, params,headers) => {
    return axios({
      method:"POST",
      url: url,
      params,headers,
    });
  };
  return getApi(url, params,headers)
}

  // might be a good idea to put error handling here

  //.then(response => response.json())
  //.then(imageFromController => {
    // optionally, you can set the state of the component to contain the image
    // object itself that was returned from the rails controller, completing
    // the post cycle
  //  this.setState({uploads: this.state.uploads.concat(imageFromController)})
  //})

export function* UploadSagaOld({ payload: { values } }) {
      let {imageFromController,status} = yield call(UploadApi, { values } )
      if(imageFromController){
      //let rresponse = response.json()
      //.then(imageFromController => {
        // optionally, you can set the state of the component to contain the image
        // object itself that was returned from the rails controller, completing
        // the post cycle
      //  this.setState({uploads: this.state.uploads.concat(imageFromController)})
        
      yield put({ type: UPLOAD_SUCCESS, payload: imageFromController })

  }else
     {  
      let message;
      switch (status) {
              case 500: message = 'Internal Server Error'; break;
              case 401: message = 'Invalid credentials'; break;
              default: message = 'Something went wrong';}
      yield put({ type: MENU_FAILURE, payload: message })
  }
 }      
