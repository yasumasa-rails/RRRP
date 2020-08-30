import React from 'react';
import {connect} from 'react-redux'
import {LoginRequest} from 'actions'
import { useForm } from 'react-hook-form'
//import  Menus  from './menus'
import  Menus7  from './menus7'
import  SignUp  from './signup'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.

const Login = ({isAuthenticated ,onSubmit,isSignUp,error,uid}) => {
  const { register, handleSubmit, errors, } = useForm()
  if(isAuthenticated){
    return(
       /*   <Menus/> */
          <Menus7/>

    )    
    }
  else{
  if(isSignUp){
    return (
        <SignUp/>
    )}
  else{
    return(
    <div>
    <p>Login</p>
    <form  onSubmit={handleSubmit(onSubmit)}>
      <label htmlFor="email">
      email:
      </label>
      <input type="email" name="email" placeholder="mail" ref={register({
            required: 'this is required',
            pattern: {
              value: /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/,
              message: 'Invalid email address',
            },
          })}/>
      {errors.email && errors.email.message}
      <label htmlFor="password">
      password:
      </label>
      <input type="password" name="password" ref={register({ required: true })}  />

      <button type="submit" >
      Submit
      </button>
    </form>
        <div style={{ color: 'red' }}>
          {Object.keys(errors).length > 0 &&
            'There are errors, check your console.'}
            {error}
        </div>
    
    </div>  
    )
    }
  }
}

const mapDispatchToProps = dispatch => ({
  onSubmit: ({email,password}) => dispatch(LoginRequest(email, password))
})

const mapStateToProps = state =>({
  isAuthenticated:state.auth.isAuthenticated ,
  isSubmitting:state.auth.isSubmitting ,
  error:state.auth.error ,
  isSignUp:state.auth.isSignUp ,
    token:state.auth.token ,
    client:state.auth.client,
    uid:state.auth.uid ,
  
})

export default connect(mapStateToProps,mapDispatchToProps)(Login)
