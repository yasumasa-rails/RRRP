
import {createAction} from 'redux-actions'

export const LOGIN_REQUEST = 'LOGIN_REQUEST'
export const LOGIN_SUCCESS = 'LOGIN_SUCCESS'
export const LOGIN_FAILURE = 'LOGIN_FAILURE'

export const LOGOUT_REQUEST = 'LOGOUT_REQUEST'


export const SIGNUP_REQUEST = 'SIGNUP_REQUEST'
export const SIGNUP_SUCCESS = 'SIGNUP_SUCCESS'
export const SIGNUP_FAILURE = 'SIGNUP_FAILURE'

export const MENU_REQUEST = 'MENU_REQUEST'
export const MENU_SUCCESS = 'MENU_SUCCESS'
export const MENU_FAILURE = 'MENU_FAILURE'

// LOGIN
// Attach our Formik actions as meta-data to our action.

export const authorize = (email, password) => ({
  type: LOGIN_REQUEST,
  payload: { email, password }
})


export const LogoutRequest = createAction(
  LOGOUT_REQUEST,
)

export const SignupRequest = createAction(
  SIGNUP_REQUEST,
  ({values}) => values,
  ({actions}) => actions
)


export const MenuRequest = (token,client,uid) => ({
  type:  MENU_REQUEST,
  payload: { token,client,uid }
})

