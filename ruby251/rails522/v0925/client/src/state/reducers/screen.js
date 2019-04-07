import { SCREEN_REQUEST,SCREEN_SUCCESS,SCREEN_FAILURE} from '../../actions'
const initialValues = {
  path:"",
  errors:[],
}

const screenreducer =  (state= initialValues , action) =>{
  switch (action.type) {
    // Set the requesting flag and append a message to be shown
    case SCREEN_REQUEST:
      return {...state,
        search:action.payload.search,
        token:action.payload.token,
        client:action.payload.client,
        uid:action.payload.uid,
        messages: [{ body: 'screen loading ...', time: new Date() }],
      }

    // Successful?  Reset the signup state.
    case SCREEN_SUCCESS:
      return {...state,
        messages: [],
        response: action.actions.response,
      }

    // Append the error returned from our api
    // set the success and requesting flags to false
    case SCREEN_FAILURE:
      return {
          body: action.errors.toString(),
          time: new Date(),
      }

    default:
      return state
  }
}

export default screenreducer
