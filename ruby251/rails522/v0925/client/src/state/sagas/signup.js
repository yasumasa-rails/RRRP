//new_api_user_registration GET /api/auth/sign_up(.:format)   api/auth/registrations#new
import {call,put} from 'redux-saga/effects'
import axios         from 'axios'
import {SIGNUP_SUCCESS,SIGNUP_FAILURE} from '../../actions'

function signupApi({email,password,password_confirmation }) {
  //const url = 'http://localhost:3001/api/auth/sign_up'
  const url = 'http://localhost:3001/api/auth'
  //const params = {email:email,password:password,password_confirmation:password_confirmation,provider:"email"}
  const params = {email:email,password:password,password_confirmation:password_confirmation}
  const headers = { 'Content-Type': 'application/json',
               }
  return (axios({
    method: "POST",
    url: url,
    params: params,
    headers: headers
  }).then((results) => {
    return  results ;
  })
  .catch(error => (
    { error }
  ))
  )
}

export function * SignupSaga({payload:{email,password,password_confirmation}}) {
  let {results,error} = yield call(signupApi, {email,password,password_confirmation } )
  if (results || !error) {
    // 成功したので適当なactionをdispatchして画面更新    
    yield put({ type: SIGNUP_SUCCESS, actions: results })
  } else {
    // todo: エラーハンドリング
         let message
         switch (true) {
             case /code.*500/.test(error): message = 'Internal Server Error'; break;
             case /code.*422/.test(error): message = 'dupulicate Error'; break;
             case /code.*401/.test(error): message = 'Invalid credentials'; break;
             default: message = `Something went wrong ${error}`;}
    yield put({ type: SIGNUP_FAILURE, payload: message })
  }
}
