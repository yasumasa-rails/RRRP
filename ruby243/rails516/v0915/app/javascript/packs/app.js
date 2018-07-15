import React from 'react'
import { Route, Switch } from 'react-router-dom'
import PrivateRoute from './privateRoute'
import GlobalNav from './globalNav'
import Menu from './menu'
import Signup from './signup'
import Login from './login'

class App extends React.Component {
  render() {
    return (
      <div>
        <GlobalNav />
        <div style={{ marginTop: 64 }}>
          <Route exact path="/" component={Menu} />
          <Route path="/signup" component={Signup} />
          <Route path="/auth/sign_in" component={Login} />
          <Switch>
          </Switch>
        </div>
      </div>
    )
  }
}

export default App