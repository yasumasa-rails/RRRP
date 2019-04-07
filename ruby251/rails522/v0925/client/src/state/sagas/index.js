
import {takeLatest} from 'redux-saga/effects'

import {LOGIN_REQUEST,SIGNUP_REQUEST,MENU_REQUEST,SCREEN_REQUEST} from  'actions'

// Route Sagas
import {LoginSaga} from './login'
import {SignupSaga} from './signup'
import {MenuSaga} from './menus'
import {ScreenSaga} from './screen'

// Routes that require side effects on load are mapped here, [type]: saga.

// Watch for all actions dispatched that have an action type in our saga routesMap.
export function * sagas () {
  yield takeLatest(LOGIN_REQUEST,LoginSaga)
  yield takeLatest(SIGNUP_REQUEST,SignupSaga)
  yield takeLatest(MENU_REQUEST,MenuSaga)
  yield takeLatest(SCREEN_REQUEST,ScreenSaga)
}
