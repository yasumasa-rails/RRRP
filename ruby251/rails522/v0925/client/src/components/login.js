import React from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import {connect} from 'react-redux'
import {authorize} from 'actions'
import { Link,} from 'react-router-dom'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.
const LoginForm = ({isSubmitting,errors,values,}) => (
  <div>
    <p>Login</p>
  <Form {...values} >
    email:
    <Field type="email" name="email" />
    {errors.email ? (<div>{errors.email}</div>) : null}
    <ErrorMessage name="email" component="div" />
    password:
    <Field type="password" name="password" />
    {errors.password ? (<div>{errors.email}</div>) : null}
    <ErrorMessage name="password" component="div" />
    <button type="submit" disabled={isSubmitting}>
    Submit
    </button>
  </Form>
  <Link to="/signup" color="primary" >Signup</Link>
  </div>
)

// FORM CONFIGURATION

// LOGIN CONTAINER

const initialValues = {
  email: '',
  password: '',
}


const validate = values => {
  const errors = {};
  if (!values.email) {
    errors.email = 'Required';
  } else if (!/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i.test(values.email)) {
    errors.email = 'Invalid email address';
  }
  if (!values.password) {
    errors.password = 'Required';
  } 
  return errors;
};

const mapDispatchToProps = dispatch => ({
  onSubmit: (values) => dispatch(authorize(values.email, values.password))
})

const mapStateToProps = state =>({
  isAuthenticated:state.login.isAuthenticated ,
    token:(state.login.auth?state.login.auth["access-token"]:"") ,
    client:(state.login.auth?state.login.auth.client:""),
    uid:(state.login.auth?state.login.auth.uid:"") ,
  
})

const Container = ({onSubmit}) => (
      <Formik 
        initialValues={initialValues}
        validate={validate}
        validateOnBlur={false}
        validateOnChange={false}
        onSubmit={onSubmit}
        render={(props) => <LoginForm {...props} />}
      />
)

export  const  Login = connect(mapStateToProps,mapDispatchToProps)(Container)
