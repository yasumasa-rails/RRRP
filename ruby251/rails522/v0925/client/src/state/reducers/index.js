
import { combineReducers } from 'redux'
import { routerReducer } from 'react-router-redux'
import  loginreducer  from './login'
import  signupreducer  from './signup'


const reducer = combineReducers({
  login:loginreducer,
  signup:signupreducer,
  routing: routerReducer,
})

export default reducer
