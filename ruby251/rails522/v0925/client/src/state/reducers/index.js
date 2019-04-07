
import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import  loginreducer  from './login'
import  signupreducer  from './signup'
import  screenreducer  from './screen'


const reducer = combineReducers({
  login:loginreducer,
  signup:signupreducer,
  screen:screenreducer,
  routing: routerReducer,
})

export default reducer
