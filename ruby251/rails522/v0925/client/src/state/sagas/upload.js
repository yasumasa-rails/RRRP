import { call, put } from 'redux-saga/effects'
import {UPLOAD_SUCCESS,MENU_FAILURE} from '../../actions'



function uploadApi({formPayLoad}){

  fetch(`http://localhost:3001/api/menu`, {
    credentials: 'same-origin',
    headers: {},
    method: 'POST',
    body: formPayLoad
  })

  // might be a good idea to put error handling here

  //.then(response => response.json())
  //.then(imageFromController => {
    // optionally, you can set the state of the component to contain the image
    // object itself that was returned from the rails controller, completing
    // the post cycle
  //  this.setState({uploads: this.state.uploads.concat(imageFromController)})
  //})
}

export function* UploadSaga({ payload: { formPayLoad } }) {
      let {imageFromController,status} = yield call(uploadApi, { formPayLoad} )
      if(imageFromController){
      //let rresponse = response.json()
      //.then(imageFromController => {
        // optionally, you can set the state of the component to contain the image
        // object itself that was returned from the rails controller, completing
        // the post cycle
      //  this.setState({uploads: this.state.uploads.concat(imageFromController)})
        
      yield put({ type: UPLOAD_SUCCESS, uploads: imageFromController })

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
