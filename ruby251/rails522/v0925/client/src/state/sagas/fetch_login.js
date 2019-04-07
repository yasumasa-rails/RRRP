import {call,put, } from 'redux-saga/effects'

import {LOGIN_SUCCESS,LOGIN_FAILURE} from 'actions'
import history from 'histrory'
// Fake API call with appropriate responses based on inputs.

const loginUrl = `http://localhost:3001/api/auth/sign_in`
function loginAPI (email, password) {
     const fb = {'email':email, 'password':password }
     const params ={
              method: 'POST',mode: 'cors', 
              headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Headers':'*',
              },
            body: JSON.stringify(fb),
            }
     return  fetch(loginUrl,params )
             .then(response =>{ for( let header of response.headers){
                      `${header[0]}:${header[1]}`}})
 }  

// Function for storing our API token, perhaps in localStorage or Redux state.
// function * storeToken (token) {}

// Our SUBMIT_LOGIN action passes along the form values as the payload and form actions as
// meta data. This allows us to not only use the values to do whatever API calls and such
// we need, but also to maintain control flow here in our saga.
export function * LoginSaga ({payload: values, meta: actions}) {
 // const {setSubmitting} = actions
  
  // Connect to our "API" and get an API token for future API calls.
  const response =  yield call(loginAPI, values.email, values.password)
  if(response){
     yield put({ type: LOGIN_SUCCESS, actions: response}) 
     yield call(history.push, '/menus')
    // Reset the form just to be clean, then send the user to our Dashboard which "requires"
    // authentication.
    }
  else{ 
    // If our API throws an error we will leverage Formik's existing error system to pass it along
    // to the view layer, as well as clearing the loading indicator.
      yield put({type:LOGIN_FAILURE, errors:response})
     // yield call(setSubmitting, false)
    }  
}
