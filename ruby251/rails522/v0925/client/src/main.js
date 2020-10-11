import React from 'react'
import { Switch, Route,} from 'react-router-dom'
import Login from './components/login'
import Signup from './components/signup'
import Menus7 from './components/menus7'


class Main extends React.Component {
 render(){
    return( 
    <main>
    <Switch>
      <Route exact path="/" component={Login} /> 
      <Route path="/menus7" component={Menus7} />
      <Route path="/signup" component={Signup} />
      <Route path="/login" component={Login} />
    </Switch>
    </main>)}
}

export default (Main)