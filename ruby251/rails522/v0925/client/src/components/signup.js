import React from 'react';
import { Formik, Form, Field, ErrorMessage } from 'formik';
import {connect} from 'react-redux'
import {SignupRequest} from 'actions'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple signup form however.
const SignupForm = ({isSubmitting,errors, touched }) => (
  <div>
  <Form>
  <ul>
    <li>
    email:
    <Field type="email" name="email" />
    {errors.email && touched.email ? (<div>{errors.email}</div>) : null}
    <ErrorMessage name="email" component="div" />
    </li>
    <li>
    password:
    <Field type="password" name="password" />
    {errors.password && touched.password ? (<div>{errors.password}</div>) : null}
    <ErrorMessage name="password" component="div" />
    </li>
    <li>
    password_confirmation:
    <Field type="password" name="passwordConfirmation" />
    {errors.passwordConfirmation && touched.passwordConfirmation ? (<div>{errors.passwordConfirmation}</div>) : null}
    <ErrorMessage name="passwordConfirmation" component="div" />
    </li>
  </ul>
    <button type="submit" disabled={isSubmitting}>
    Submit
    </button>
  </Form>
  </div>
)

// FORM CONFIGURATION

const initialValues = {
  email: '',
  password: '',
  passwordConfirmation:'',
  isAuthenticated:false,
  isSubmitting:false,
  errors:[],
}

// LOGIN CONTAINER
const mapDispatchToProps = dispatch => ({
  onSubmit: (values, actions) => dispatch(SignupRequest({values, actions}))
})


const Container = ({onSubmit}) => (
      <Formik
        initialValues={initialValues}
        validateOnBlur={false}
        validateOnChange={false}
        onSubmit={onSubmit}
        render={props => <SignupForm {...props} />}
      />
)

export  const  Signup = connect(null,mapDispatchToProps)(Container)
