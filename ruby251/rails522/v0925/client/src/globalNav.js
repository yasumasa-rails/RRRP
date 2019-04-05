import React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import { LogoutRequest } from './actions'

class GlobalNav extends React.Component {
  signout(e) {
    e.preventDefault()
    this.props.dispatch(LogoutRequest())
  }
  render() {
    const { isAuthenticated, isSubmitting, } = this.props
    return (
      <div>
      <AppBar title="RRRP" position="static">
         <Toolbar>
          <Link to="/menu">Menu</Link>
          <Typography variant="caption" color="inherit" >
            RRRP 
          </Typography>
          <Typography variant="caption" color="inherit" >
          { !isAuthenticated &&<Link to="/signup" color="primary" >Signup</Link>}
          { !isAuthenticated &&<Link to="/login">Login</Link>  }
          { isAuthenticated && <button type='submit' disabled={false} href="#" onClick={this.signout.bind(this)}>
             Logout{isSubmitting && <i className='fa fa-spinner fa-spin' />}</button> }
          </Typography>
          </Toolbar>
      </AppBar>
      </div>
    )
  }
}


function mapStateToProps(state) {
  const { isSubmitting ,isAuthenticated} = state.login
  return { isSubmitting ,isAuthenticated}
}

export default connect(mapStateToProps)(GlobalNav)