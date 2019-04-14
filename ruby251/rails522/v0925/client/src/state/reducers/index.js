
import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'

import  loginreducer  from './login'
import  signupreducer  from './signup'
import  menureducer  from './menu'
import  screenreducer  from './screen'


const reducer = combineReducers({
  login:loginreducer,
  signup:signupreducer,
  menu:menureducer,
  screen:screenreducer,
  routing: routerReducer,
})

export default reducer
