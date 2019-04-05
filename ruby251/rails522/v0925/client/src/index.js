import React from 'react'
import ReactDOM from 'react-dom'
import {Provider} from 'react-redux'
import { Switch, Route,Router} from 'react-router-dom'
import history from './histrory'
import { PersistGate } from 'redux-persist/integration/react'

import {store,persistor} from './state/store'


import GlobalNav from './globalNav'
import {Login} from './components/login'
import {Signup} from './components/signup'
import Menu from './components/menu'

ReactDOM.render(
  <Provider store={store}>
  <Router history={ history } >
  <PersistGate loading={null} persistor={persistor}>
    <GlobalNav />
    <Switch>
      <Route exact path="/" component={Menu} />
      <Route path="/menu" component={Menu} />
      <Route path="/signup" component={Signup} />
      <Route path="/login" component={Login} />
    </Switch>
  </PersistGate>
  </Router>
  </Provider>
  , document.getElementById('root'))
