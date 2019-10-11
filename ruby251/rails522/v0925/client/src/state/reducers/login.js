import { LOGIN_REQUEST,LOGIN_SUCCESS,LOGIN_FAILURE,LOGOUT_REQUEST, } from 'actions'
const initialValues = {
  isSubmitting:false,
  errors:[],
  isAuthenticated:false,
  email:"",
  auth:{},
}

const loginreducer =  (state= initialValues , actions) =>{
  switch (actions.type) {
    // Set the requesting flag and append a message to be shown
    case LOGIN_REQUEST:
      return {
        isSubmitting:true,
        errors:[],
        messages: [{ body: 'Logging in...', time: new Date() }],
        isAuthenticated:false,
        email:actions.payload.email,
        auth:{}
      }

    // Successful?  Reset the login state.
    case LOGIN_SUCCESS:
      return {...state,
        messages: [],
        isAuthenticated:true,
        auth:actions.action,  /// payloadに統一
      }

    // Append the error returned from our api
    // set the success and requesting flags to false
    case LOGIN_FAILURE:
      return {errors: {
        body: actions.errors.toString(),
       },       
        messages: [],
        isAuthenticated:false,
    }

    case LOGOUT_REQUEST:
    return {}


    default:
      return state
  }
}

export default loginreducer
