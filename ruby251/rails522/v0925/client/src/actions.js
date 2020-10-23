
export const LOGINFORM_REQUEST = 'LOGINFORM_REQUEST'
export const LOGINFORM_SUCCESS = 'LOGINFORM_SUCCESS'
export const LOGIN_REQUEST = 'LOGIN_REQUEST'
export const LOGIN_SUCCESS = 'LOGIN_SUCCESS'
export const LOGIN_FAILURE = 'LOGIN_FAILURE'

export const LOGOUT_REQUEST = 'LOGOUT_REQUEST'
export const LOGOUT_SUCCESS = 'LOGOUT_SUCCESS'

export const SIGNUPFORM_REQUEST = 'SIGNUPFORM_REQUEST'
export const SIGNUPFORM_SUCCESS = 'SIGNUPFORM_SUCCESS'
export const SIGNUP_REQUEST = 'SIGNUP_REQUEST'
export const SIGNUP_SUCCESS = 'SIGNUP_SUCCESS'
export const SIGNUP_FAILURE = 'SIGNUP_FAILURE'

export const MENU_REQUEST = 'MENU_REQUEST'
export const MENU_SUCCESS = 'MENU_SUCCESS'
export const MENU_FAILURE = 'MENU_FAILURE'


export const SCREENINIT_REQUEST = 'SCREENINIT_REQUEST'
export const SCREEN_REQUEST = 'SCREEN_REQUEST'
export const SCREEN_SUCCESS = 'SCREEN_SUCCESS'
export const SCREEN_SUCCESS7 = 'SCREEN_SUCCESS7'
export const SCREEN_PARAMS_SET = 'SCREEN_PARAMS_SET'
export const SCREEN_LINEEDIT = 'SCREEN_LINEEDIT'

export const SCREEN_FAILURE = 'SCREEN_FAILURE'
export const SCREEN_ERR_CHECK_RESULT = 'SCREEN_ERR_CHECK_RESULT'
export const SCREEN_ONBLUR = 'SCREEN_ONBLUR'
//export const SCREEN_ONKEYUP = 'SCREEN_ONKEYUP'

export const BUTTONLIST_REQUEST = 'BUTTONLIST_REQUEST'
export const BUTTONLIST_SUCCESS = 'BUTTONLIST_SUCCESS'
export const BUTTONLIST_FAILFURE = 'BUTTONLIST_FAILURE'

export const BUTTONFLG_REQUEST = 'BUTTONFLG_REQUEST'
export const BUTTON_RESET = 'BUTTON_RESET'
export const GANTT_RESET = 'GANTT_RESET'

export const IMPORT_REQUEST = 'IMPORT_REQUEST'
export const UPLOADLIST_REQUEST = 'UPLOADLIST_REQUEST'
export const UPLOAD_SUCCESS = 'UPLOAD_SUCCESS'
export const UPLOADLIST_SUCCESS = 'UPLOADLIST_SUCCESS'
export const CHANGEUPLOADABLE_REQUEST = 'CHANGEUPLOADABLE_REQUEST'
export const CHANGEUNUPLOAD_REQUEST = 'CHANGEUNUPLOAD_REQUEST'
//export const CHANGEUPLOADTITLE_REQUEST = 'CHANGEUPLOADTITLE_REQUEST'
//export const CHANGEUPLOADTITLEEDITABLE_REQUEST = 'CHANGEUPLOADTITLEEDITABLE_REQUEST'
//export const EXCELTOJSON_REQUEST = 'EXCELTOJSON_REQUEST'
export const EXCELTOJSON_SUCCESS = 'EXCELTOJSON_SUCCESS'
export const UPLOADFORFIELDSET_REQUEST = 'UPLOADFORFIELDSET_REQUEST'

export const DOWNLOAD_REQUEST = 'DOWNLOAD_REQUEST'
export const DOWNLOAD_SUCCESS = 'DOWNLOAD_SUCCESS'
export const DOWNLOAD_FAILURE = 'DOWNLOAD_FAILURE'
export const DOWNLOAD_RESET = 'DOWNLOAD_RESET'

export const FETCH_REQUEST = 'FETCH_REQUEST'
export const FETCH_RESULT = 'FETCH_RESULT'
export const FETCH_FAILURE = 'FETCH_FAILURE'
export const INPUTFIELDPROTECT_REQUEST = 'INPUTFIELDPROTECT_REQUEST'
export const INPUTPROTECT_RESULT = 'INPUTPROTECT_RESULT'

export const YUP_RESULT = 'YUP_RESULT'
export const YUP_REQUEST = 'YUP_REQUEST'
export const YUP_ERR_SET = 'YUP_ERR_SET'
export const TBLFIELD_REQUEST = 'TBLFIELD_REQUEST'
export const TBLFIELD_SUCCESS = 'TBLFIELD_SUCCESS'
export const TBLFIELD_FAILURE = 'TBLFIELD_FAILFURE'
export const DROPDOWNVALUE_SET = 'DROPDOWNVALUE_SET'

export const GANTTCHART_REQUEST = 'GANTTCHART_REQUEST'
export const GANTTCHART_FAILURE = 'GANTTCHART_FAILURE'
export const GANTTCHART_SUCCESS = 'GANTTCHART_SUCCESS'

export const MKSHPINSTS_SUCCESS = 'MKSHPINSTS_SUCCESS'

export const SETRESULTS_REQUEST = 'SETRESULTS_REQUEST'
export const SETRESULTS_SUCCESS = 'SETRESULTS_SUCCESS'

export const RESET_REQUEST = 'RESET_REQUEST'

// LOGIN
// Attach our Formik actions as meta-data to our action.

export const SignUpFormRequest =  ( isSignUp) => ({
  type:SIGNUPFORM_REQUEST,
  payload: { isSignUp }
})

export const SignUpFormSuccess =  ( isSignUp) => ({
  type:SIGNUPFORM_SUCCESS,
  payload: { isSignUp }
})

export const LoginFormRequest =  ( isSignUp) => ({
  type:LOGINFORM_REQUEST,
  payload: { isSignUp }
})

export const LoginFormSuccess =  ( isSignUp) => ({
  type:LOGINFORM_SUCCESS,
  payload: { isSignUp }
})

export const SignUpRequest =  (email, password,password_confirmation) => ({
  type:SIGNUP_REQUEST,
  payload: { email, password ,password_confirmation}
})

export const LoginRequest  = (email, password) => ({
  type: LOGIN_REQUEST,
  payload: { email, password }
})

export const LogoutRequest =  (token,client,uid) => ({
  type: LOGOUT_REQUEST,
  payload: { token,client,uid }
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

export const ScreenInitRequest = (params,data) => ({
  type:  SCREENINIT_REQUEST,
  payload: { params,data}  //
})

export const ScreenRequest = (params,data) => ({
  type:  SCREEN_REQUEST,
  payload: { params,data}  //
})


export const ResetRequest = (params) => ({
  type:  RESET_REQUEST,
  payload: { params}  //
})


export const ScreenParamsSet = (params) => ({
  type:  SCREEN_PARAMS_SET,
  payload: { params}  //
})

export const ScreenOnblur = (data) => ({
  type:  SCREEN_ONBLUR,
  payload: {data}  //
})

//export const ScreenOnKeyUp = (data) => ({
//  type:  SCREEN_ONKEYUP,
//  payload: {data}  //
//})


export const YupErrSet = (data,error) => ({
  type:  YUP_ERR_SET,
  payload: {data,error}  //
})

export const DropDownValueSet = (dropDownValue) => ({
  type:  DROPDOWNVALUE_SET,
  payload: {dropDownValue}  //
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


export const ImportRequest = () => ({
  type: IMPORT_REQUEST,
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

export const FetchRequest = (params,data,loading) => ({
  type: FETCH_REQUEST,
  payload: { params,data,loading }
})

export const InputFieldProtectRequest = () => ({
  type: INPUTFIELDPROTECT_REQUEST,
})
export const InputProtectResult = () => ({
  type: INPUTPROTECT_RESULT,
})


export const FetchResult = (data,params) => ({
  type: FETCH_RESULT,
  payload: { data,params}
})

export const FetchFailure = (data,params) => ({
  type: FETCH_FAILURE,
  payload: { data,params}
})


export const YupRequest = (params) => ({
  type:  YUP_REQUEST,
  payload: { params}  //
})

export const TblfieldRequest = (params) => ({
  type:  TBLFIELD_REQUEST,
  payload: { params}  //
})


export const TblfielSuccess = (messages) => ({
  type:  TBLFIELD_SUCCESS,
  payload: { messages}  //
})

export const GanttChartRequest = (params) => ({
  type:  GANTTCHART_REQUEST,
  payload: { params}  //
})


export const ButtonReset = () => ({
  type:  BUTTON_RESET,
   //
})

export const GanttReset = () => ({
  type:  GANTT_RESET,
})

export const uploadForFieldSetRequest = (jsonfilename,screenCode) => ({
  type:  UPLOADFORFIELDSET_REQUEST,
  payload:{jsonfilename,screenCode}
})

export const SetResultsRequest = (results,defCode,excelfile,screenCode) => ({
  type:  SETRESULTS_REQUEST,
  payload:{results,defCode,excelfile,screenCode}
})

export const ExcelToJsonRequest = (excelfile) => ({
  type: SETRESULTS_REQUEST,  // sagaはExcelToJsonRequestと同じものを使用
  payload: {results:null,defCode:"ExcelToJson", excelfile}
})

export const EditUploadResult = (message) => ({
  type: EXCELTOJSON_SUCCESS,
  payload: { message}
})
