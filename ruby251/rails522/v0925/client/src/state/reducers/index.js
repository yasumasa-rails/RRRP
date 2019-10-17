import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import  loginreducer  from './login'
import  signupreducer  from './signup'
import  menureducer  from './menu'
import  screenreducer  from './screen'
import  uploadreducer  from './upload'
import  buttonreducer  from './button'
import  ganttchartreducer  from './ganttchart'


const reducer = combineReducers({
  login:loginreducer,
  signup:signupreducer,
  menu:menureducer,
  screen:screenreducer,
  upload:uploadreducer,
  button:buttonreducer,
  ganttchart:ganttchartreducer,
  routing: routerReducer,
})

export default reducer
