
import {createAction} from 'redux-actions'
// create actionの使用は止める

export const LOGIN_REQUEST = 'LOGIN_REQUEST'
export const LOGIN_SUCCESS = 'LOGIN_SUCCESS'
export const LOGIN_FAILURE = 'LOGIN_FAILURE'

export const LOGOUT_REQUEST = 'LOGOUT_REQUEST'
export const LOGOUT_SUCCESS = 'LOGOUT_SUCCESS'
export const SCREEN_RESET_REQUEST = 'SCREEN_RESET_REQUEST'


export const SIGNUP_REQUEST = 'SIGNUP_REQUEST'
export const SIGNUP_SUCCESS = 'SIGNUP_SUCCESS'
export const SIGNUP_FAILURE = 'SIGNUP_FAILURE'

export const MENU_REQUEST = 'MENU_REQUEST'
export const MENU_SUCCESS = 'MENU_SUCCESS'
export const MENU_FAILURE = 'MENU_FAILURE'


export const SCREEN_REQUEST = 'SCREEN_REQUEST'
export const SCREEN_SUCCESS = 'SCREEN_SUCCESS'
export const SCREEN_PARAMS_SET = 'SCREEN_PARAMS_SET'
export const SCREEN_FAILURE = 'SCREEN_FAILURE'


export const UPLOAD_REQUEST = 'UPLOAD_REQUEST'
export const UPLOAD_SUCCESS = 'UPLOAD_SUCCESS'
export const UPLOAD_FAILURE = 'UPLOAD_FAILURE'

// LOGIN
// Attach our Formik actions as meta-data to our action.


export const SignupRequest = createAction(
  SIGNUP_REQUEST,
  ({values}) => values,
  ({actions}) => actions
)


export const authorize = (email, password) => ({
  type: LOGIN_REQUEST,
  payload: { email, password }
})


export const LogoutRequest = (token,client,uid) => ({
  type: LOGOUT_REQUEST,
  payload: {token:token,client:client,uid:uid }
})

export const LogoutSuccess = () => ({
  type: LOGOUT_SUCCESS,
 // payload: {token,client,uid }
})



export const MenuRequest = (token,client,uid) => ({
  type:  MENU_REQUEST,
  payload:{token,client,uid} 
})


export const MenuFailure = (errors) => ({
  type: MENU_FAILURE,
  errors: { errors }  //
})


export const ScreenRequest = (params,token,client,uid,lineEdit,screenName) => ({
  type:  SCREEN_REQUEST,
  payload: { params,token,client,uid ,lineEdit,screenName}  //
})

export const ScreenParamsSet = (subparams) => ({
  type:  SCREEN_PARAMS_SET,
  payload: { subparams }  //
})

export const ScreenFailure = (errors) => ({
  type: SCREEN_FAILURE,
  errors: { errors }  //
})

export const UploadRequest = (formPayLoad) => ({
  type: UPLOAD_REQUEST,
  payload: { formPayLoad}
})


