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
import Menus from './components/menus'
import ScreenGrid from './components/screengrid'

ReactDOM.render(
  <Provider store={store}>
  <Router history={ history } >
  <PersistGate loading={null} persistor={persistor}>
    <GlobalNav />
    <Switch>
      <Route exact path="/" component={Menus} />
      <Route path="/menus" component={Menus} />
      <Route path="/signup" component={Signup} />
      <Route path="/login" component={Login} />
    </Switch>
  </PersistGate>
  </Router>
  </Provider>
  , document.getElementById('root'))
