import React from 'react';
import {connect} from 'react-redux'
import {SignUpRequest} from 'actions'
import { useForm} from 'react-hook-form'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple signup form however.
const SignUp = ({isSubmitting,onSubmit,error}) => {
  const { register, handleSubmit, errors, watch, } = useForm()
  return(
  <div>
  <form  onSubmit={handleSubmit(onSubmit)}>
  <ul>
    <li>
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
    </li>
    <li>
      <label htmlFor="password">
      password:
      </label>
      <input type="password" name="password" ref={register({ required: true })}  />
    </li>
    <li>
      <label htmlFor="password_confirmation">
      password_confirmation:
      </label>
      <input type="password" name="password_confirmation"
             ref={register({validate: (value) => value === watch('password') || "Passwords don't match."})}  />
    </li>
  </ul>
    <button type="submit" disabled={isSubmitting}>
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

const mapDispatchToProps = dispatch => ({
  onSubmit: ({email, password,password_confirmation}) => dispatch(SignUpRequest(email, password,password_confirmation))
})

const mapStateToProps = state =>({
  isSubmitting:state.auth.isSubmitting ,
  isSignUp:state.auth.isSignUp ,
  error:state.auth.error ,
})



export  default  connect(mapStateToProps,mapDispatchToProps)(SignUp)
