
import {takeLatest} from 'redux-saga/effects'

import {LOGIN_REQUEST,SIGNUP_REQUEST,MENU_REQUEST,
        LOGOUT_REQUEST,SCREEN_REQUEST,BUTTONLIST_REQUEST,
        EDITUPLOAD_REQUEST,UPLOADLIST_REQUEST,EDITUPLOADTITLE_REQUEST,
        FETCH_REQUEST,SCREEN_ERR_CHECK,GANTTCHART_REQUEST,
        DOWNLOAD_REQUEST,
        YUP_REQUEST,TBLFIELD_REQUEST,
      //  UPLOAD_REQUEST,
      } from  'actions'

// Route Sagas
import {LoginSaga} from './login'
import {SignupSaga} from './signup'
import {MenuSaga} from './menus'
import {UploadListSaga} from './uploadlist'
import {EditUploadSaga} from './editupload'
import {EditUploadTitleSaga} from './edituploadtitle'
import {DownloadSaga} from './download'
import {ScreenSaga} from './screen'//
import {ScreenErrCheckSaga} from './screenerrcheck'
import {ButtonListSaga} from './buttonlist'
import {GanttChartSaga} from './ganttchart'
import {TblfieldSaga} from './tblfield'
import {LogoutSaga} from './logout'

// Routes that require side effects on load are mapped here, [type]: saga.
// Watch for all actions dispatched that have an action type in our saga routesMap.
export function * sagas () {
  yield takeLatest(LOGIN_REQUEST,LoginSaga)
  yield takeLatest(SIGNUP_REQUEST,SignupSaga)
  yield takeLatest(MENU_REQUEST,MenuSaga)
  yield takeLatest(SCREEN_REQUEST,ScreenSaga)
  yield takeLatest(FETCH_REQUEST,ScreenSaga)
  yield takeLatest(SCREEN_ERR_CHECK,ScreenErrCheckSaga)
  yield takeLatest(BUTTONLIST_REQUEST,ButtonListSaga)
  yield takeLatest(EDITUPLOAD_REQUEST,EditUploadSaga)
  yield takeLatest(UPLOADLIST_REQUEST,UploadListSaga)
  yield takeLatest(EDITUPLOADTITLE_REQUEST,EditUploadTitleSaga)
  yield takeLatest(DOWNLOAD_REQUEST,DownloadSaga)
  yield takeLatest(YUP_REQUEST,TblfieldSaga)
  yield takeLatest(TBLFIELD_REQUEST,TblfieldSaga)
  yield takeLatest(GANTTCHART_REQUEST,GanttChartSaga)
  yield takeLatest(LOGOUT_REQUEST,LogoutSaga)
}