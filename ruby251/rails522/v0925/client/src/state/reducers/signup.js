import { SIGNUP_REQUEST,SIGNUP_SUCCESS,SIGNUP_FAILURE} from '../../actions'
const initialValues = {
  isSubmitting:false,
  errors:[],
}

const signupreducer =  (state= initialValues , action) =>{
  switch (action.type) {
    // Set the requesting flag and append a message to be shown
    case SIGNUP_REQUEST:
      return {...state,
        isSubmitting:true,
        messages: [{ body: 'signining in...', time: new Date() }],
      }

    // Successful?  Reset the signup state.
    case SIGNUP_SUCCESS:
      return {...state,
        messages: [],
        email: action.actions.email,    /// payloadに統一
      }

    // Append the error returned from our api
    // set the success and requesting flags to false
    case SIGNUP_FAILURE:
      return {
          body: action.errors.toString(),
          time: new Date(),
      }

    default:
      return state
  }
}

export default signupreducer
