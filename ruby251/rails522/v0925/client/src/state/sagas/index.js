
import {takeEvery} from 'redux-saga/effects'

import {LOGIN_REQUEST,SIGNUP_REQUEST,MENU_REQUEST,
        LOGOUT_REQUEST,SCREEN_REQUEST,BUTTONLIST_REQUEST,
        EXCELTOJSON_REQUEST,FETCH_REQUEST,GANTTCHART_REQUEST,
        DOWNLOAD_REQUEST,
        YUP_REQUEST,TBLFIELD_REQUEST,
      //  UPLOAD_REQUEST,
      } from  'actions'

// Route Sagas
import {LoginSaga} from './login'
import {SignupSaga} from './signup'
import {MenuSaga} from './menus'
import {ExcelToJsonSaga} from './exceltojson'
import {DownloadSaga} from './download'
import {ScreenSaga} from './screen'//
import {ButtonListSaga} from './buttonlist'
import {GanttChartSaga} from './ganttchart'
import {TblfieldSaga} from './tblfield'
import {LogoutSaga} from './logout'

// Routes that require side effects on load are mapped here, [type]: saga.
// Watch for all actions dispatched that have an action type in our saga routesMap.
export function * sagas () {
  yield takeEvery(LOGIN_REQUEST,LoginSaga)
  yield takeEvery(SIGNUP_REQUEST,SignupSaga)
  yield takeEvery(MENU_REQUEST,MenuSaga)
  yield takeEvery(SCREEN_REQUEST,ScreenSaga)
  yield takeEvery(FETCH_REQUEST,ScreenSaga)
  yield takeEvery(BUTTONLIST_REQUEST,ButtonListSaga)
  yield takeEvery(EXCELTOJSON_REQUEST,ExcelToJsonSaga)
  yield takeEvery(DOWNLOAD_REQUEST,DownloadSaga)
  yield takeEvery(YUP_REQUEST,TblfieldSaga)
  yield takeEvery(TBLFIELD_REQUEST,TblfieldSaga)
  yield takeEvery(GANTTCHART_REQUEST,GanttChartSaga)
  yield takeEvery(LOGOUT_REQUEST,LogoutSaga)
}