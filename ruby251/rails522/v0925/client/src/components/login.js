import React from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import {connect} from 'react-redux'
import {authorize} from 'actions'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.
const LoginForm = ({isSubmitting,errors,values}) => (
  <div>
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
  </div>
)

// FORM CONFIGURATION

// LOGIN CONTAINER
const mapDispatchToProps = dispatch => ({
  onSubmit: (values) => dispatch(authorize(values.email, values.password))
})
const initialValues = {
  email: '',
  password: '',
}

const Container = ({onSubmit}) => (
      <Formik 
        initialValues={initialValues}
        validateOnBlur={false}
        validateOnChange={false}
        onSubmit={onSubmit}
        render={(props) => <LoginForm {...props} />}
      />
)

export  const  Login = connect(null,mapDispatchToProps)(Container)
