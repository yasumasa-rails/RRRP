import {call,put} from 'redux-saga/effects'
import history from '../../histrory'
import {SIGNUP_SUCCESS,SIGNUP_FAILURE} from '../../actions'
// Fake API call with appropriate responses based on inputs.

const signupUrl = `http://localhost:3001/api/auth`
function signupAPI (email, password,passwordConfirmation) {
    const fb = {'email':email,
                'password': password,
                'password_confirmation':passwordConfirmation,
                'confirm_success_url':'http://localhost:3001/confirm_success'}
     return  fetch(signupUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(fb),
    })
}

// Function for storing our API token, perhaps in localStorage or Redux state.
// function * storeToken (token) {}

// Our SUBMIT_LOGIN action passes along the form values as the payload and form actions as
// meta data. This allows us to not only use the values to do whatever API calls and such
// we need, but also to maintain control flow here in our saga.
export function * SignupSaga ({payload: values, meta: actions}) {
  const {setSubmitting} = actions
  
  // Connect to our "API" and get an API token for future API calls.
  try{
      const response = yield call(signupAPI, values.email, values.password,values.passwordConfirmation)
      yield put({type:SIGNUP_SUCCESS, response})
      // Reset the form just to be clean, then send the user to our Dashboard which "requires"
      // authentication. 
      yield call(history.push, '/login')
    }
  catch(errors){ 
      // If our API throws an error we will leverage Formik's existing error system to pass it along
      // to the view layer, as well as clearing the loading indicator.
      yield put({type:SIGNUP_FAILURE, errors:errors.statusText})
      yield call(setSubmitting, false)
    }  
}