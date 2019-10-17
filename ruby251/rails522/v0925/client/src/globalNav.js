import React from 'react'
import { connect } from 'react-redux'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import Typography from '@material-ui/core/Typography'
import {Button} from './styles/button'
import { LogoutRequest, } from './actions'

class GlobalNav extends React.Component {
  //signout(e) {
  //  e.preventDefault()
  //  const {email, password,token,client,uid} = this.props
  //  this.props.dispatch(LogoutRequest(email, password,token,client,uid))    
  //}
  render() {
    //email, password,token,client,uid うまく渡らない
    const { isAuthenticated, isSubmitting,LogoutClick, token,client,uid } = this.props
    return (
      <div>
      <AppBar title="RRRP" position="static">
         <Toolbar>
          <Typography variant="caption" color="inherit" >
            RRRP 
          </Typography>
          <Typography variant="caption" color="inherit" >
          { isAuthenticated && <Button variant="outlined" color="secondary" 
             type='submit' disabled={false}
            onClick ={() => LogoutClick(token,client,uid)}>
             Logout{isSubmitting && <i className='fa fa-spinner fa-spin' />}</Button> }
          </Typography>
          </Toolbar>
      </AppBar>
      </div>
    )
  }
}

//this.ownProps.history.replace(`/login`),
const mapDispatchToProps = (dispatch,ownProps ) => {
//  const { email, password,auth} = ownProps.login?ownProps.login:{ email:"", password:"",auth:[]}
//  const {client,uid} = auth?auth:{client:"",uid:""}
//  const token = auth?{token:auth["access-token"]}:{token:""}
  return{
         LogoutClick: (token,client,uid) => dispatch(LogoutRequest(token,client,uid),
                          )
        }
}
const  mapStateToProps = (state) => {
  const { isSubmitting ,isAuthenticated,auth} = state.login
  const {client,uid} = auth?auth:{client:"",uid:""}
  const {token} = auth?{token:auth["access-token"]}:{token:""}
  return { isSubmitting ,isAuthenticated, token,client,uid}
}

export default connect(mapStateToProps, mapDispatchToProps )(GlobalNav)