
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
export const SCREEN_ERR_SET = 'SCREEN_ERR_SET'
export const SCREEN_ERR_CHECK_RESULT = 'SCREEN_ERR_CHECK_RESULT'
export const SCREEN_ERR_CHECK = 'SCREEN_ERR_CHECK'

export const BUTTONLIST_REQUEST = 'BUTTONLIST_REQUEST'
export const BUTTONLIST_SUCCESS = 'BUTTONLIST_SUCCESS'
export const BUTTONLIST_FAILFURE = 'BUTTONLIST_FAILURE'

export const BUTTONFLG_REQUEST = 'BUTTONFLG_REQUEST'

export const UPLOAD_REQUEST = 'UPLOAD_REQUEST'
export const UPLOADLIST_REQUEST = 'UPLOADLIST_REQUEST'
export const UPLOAD_SUCCESS = 'UPLOAD_SUCCESS'
export const UPLOADLIST_SUCCESS = 'UPLOADLIST_SUCCESS'
export const CHANGEUPLOADABLE_REQUEST = 'CHANGEUPLOADABLE_REQUEST'
export const CHANGEUNUPLOAD_REQUEST = 'CHANGEUNUPLOAD_REQUEST'
export const CHANGEUPLOADTITLE_REQUEST = 'CHANGEUPLOADTITLE_REQUEST'
export const CHANGEUPLOADTITLEEDITABLE_REQUEST = 'CHANGEUPLOADTITLEEDITABLE_REQUEST'
export const EDITUPLOADTITLE_REQUEST = 'EDITUPLOADTITLE_REQUEST'
export const EDITUPLOADTITLE_SUCCESS = 'EDITUPLOADTITLE_SUCCESS'
export const EDITUPLOAD_REQUEST = 'EDITUPLOAD_REQUEST'
export const EDITUPLOAD_RESULT = 'EDITUPLOAD_RESULT'

export const DOWNLOAD_REQUEST = 'DOWNLOAD_REQUEST'
export const DOWNLOAD_SUCCESS = 'DOWNLOAD_SUCCESS'
export const DOWNLOAD_FAILURE = 'DOWNLOAD_FAILURE'
export const DOWNLOAD_RESET = 'DOWNLOAD_RESET'

export const SCREEN_LINEEDIT = 'SCREEN_LINEEDIT'


export const FETCH_REQUEST = 'FETCH_REQUEST'
export const FETCH_RESULT = 'FETCH_RESULT'
export const FETCH_FAILURE = 'FETCH_FAILURE'
export const INPUTFIELDPROTECT_REQUEST = ' INPUTFIELDPROTECT_REQUEST'

export const YUP_RESULT = 'YUP_RESULT'
export const YUP_REQUEST = 'YUP_REQUEST'
export const TBLFIELD_REQUEST = 'TBLFIELD_REQUEST'
export const TBLFIELD_SUCCESS = 'TBLFIELD_SUCCESS'
export const TBLFIELD_FAILURE = 'TBLFIELD_FAILFURE'


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

export const ScreenRequest = (params) => ({
  type:  SCREEN_REQUEST,
  payload: { params}  //
})

export const ScreenParamsSet = (params) => ({
  type:  SCREEN_PARAMS_SET,
  payload: { params}  //
})

export const ScreenErrSet = (data,token,client,uid) => ({
  type:  SCREEN_ERR_SET,
  payload: { data,token,client,uid }  //
})


export const ScreenErrCheck = (schema,data,index,field,params) => ({
  type:  SCREEN_ERR_CHECK,
  payload: {schema,data,index,field,params}  //
})

export const ScreenFailure = (errors) => ({
  type: SCREEN_FAILURE,
  errors: { errors }  //
})

export const DownloadRequest = (params) => ({
  type: DOWNLOAD_REQUEST,
  payload: { params}
})

export const DownloadReset = () => ({
  type: DOWNLOAD_RESET,
  payload: { }
})


/*
export const DownloadSuccess = (response) => ({
  type: DOWNLOAD_SUCCESS,
  payload: {response}
})
*/

export const ButtonListRequest = (token,client,uid) => ({
  type:  BUTTONLIST_REQUEST,
  payload:{token,client,uid} 
})
export const ButtonListSuccess = (buttonListData) => ({
  type:  BUTTONLIST_SUCCESS,
  payload:{buttonListData} 
})
export const ButtonListFailure = (error) => ({
  type:  BUTTONLIST_FAILFURE,
  payload:{error} 
})


export const ButtonFlgRequest = (buttonflg,params) => ({
  type: BUTTONFLG_REQUEST,
  payload: { buttonflg,params}
})

export const ChangeUploadableRequest = (isUpload) => ({
  type: CHANGEUPLOADABLE_REQUEST,
  payload: {isUpload}
})

export const ChangeUnUploadRequest = (isUpload) => ({
  type: CHANGEUNUPLOAD_REQUEST,
  payload: {isUpload}
})


export const UploadRequest = (values) => ({
  type: UPLOAD_REQUEST,
  payload: { values}
})

export const UploadSuccess = (imageFromController) => ({
  type: UPLOAD_SUCCESS,
  payload: {imageFromController}
})

export const UploadListRequest = (values) => ({
  type: UPLOADLIST_REQUEST,
  payload: { values }
})

export const UploadListSuccess = (uploadlists) => ({
  type: UPLOADLIST_SUCCESS,
  payload: { uploadlists}
})

export const ChangeUploadTitleEditableRequest = () => ({
  type: CHANGEUPLOADTITLEEDITABLE_REQUEST,
  payload: {}
})

export const ChangeUploadTitleRequest = (upload) => ({
  type: CHANGEUPLOADTITLE_REQUEST,
  payload: { upload}
})


export const EditUploadTitleRequest = (upload) => ({
  type: EDITUPLOADTITLE_REQUEST,
  payload: { upload}
})

export const EditUploadTitleSuccess = (data) => ({
  type: EDITUPLOADTITLE_SUCCESS,
  payload: { data}
})


export const EditUploadRequest = (values) => ({
  type: EDITUPLOAD_REQUEST,
  payload: { values}
})

export const EditUploadResult = (message) => ({
  type: EDITUPLOAD_RESULT,
  payload: { message}
})


export const FetchRequest = (params,token,client,uid) => ({
  type: FETCH_REQUEST,
  payload: { params ,token,client,uid}
})

export const InputFieldProtect = (columns) => ({
  type: INPUTFIELDPROTECT_REQUEST,
  payload: { columns}
})

export const FetchResult = (data,columns) => ({
  type: FETCH_RESULT,
  payload: { data,columns}
})

export const FetchFailure = (data,columns) => ({
  type: FETCH_FAILURE,
  payload: { data,columns}
})


export const YupRequest = (params) => ({
  type:  YUP_REQUEST,
  payload: { params}  //
})

export const TblfieldRequest = (params) => ({
  type:  TBLFIELD_REQUEST,
  payload: { params}  //
})