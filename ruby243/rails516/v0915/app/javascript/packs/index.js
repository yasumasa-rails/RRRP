// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.
//https://github.com/saitoxu/react-devise-token-auth-sample/tree/master/app/javascript/packs

import React from 'react'
import ReactDOM from 'react-dom'
import { Provider, connect } from 'react-redux'
import createHistory from 'history/createBrowserHistory'
import { ConnectedRouter, routerReducer, routerMiddleware } from 'react-router-redux'
import { compose, createStore, applyMiddleware, combineReducers } from 'redux'
import thunkMiddleware from 'redux-thunk'
import persistState from 'redux-localstorage'
import App from './app'
import auth from './modules/auth'

const history = createHistory()

//A reducer function that stores location updates from history. If you use combineReducers, it should be nested under the routing key.

const rootReducer = combineReducers({
  auth,
  router: routerReducer
})

const middlewares = [thunkMiddleware, routerMiddleware(history)]

if (process.env.NODE_ENV === 'development') {
  const { logger } = require('redux-logger')
  middlewares.push(logger)
}

const enhancer = compose(
  applyMiddleware(...middlewares),
  persistState('auth', { key: 'AUTH' })
)

const store = createStore(rootReducer, {}, enhancer)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={store}>
      <ConnectedRouter history={history}>
        <App />
      </ConnectedRouter>
    </Provider>,
    document.getElementById('root')
  )
})