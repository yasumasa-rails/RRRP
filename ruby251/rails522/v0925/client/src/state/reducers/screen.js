import { SCREEN_REQUEST,SCREEN_SUCCESS,SCREEN_FAILURE,  LOGOUT_REQUEST} 
          from '../../actions'
const initialValues = {
  errors:[],
  columns:[{name:"loadung"}],
  data:[{name:"loadung"}],
  pageInfo:{totalpage:0},
}

const screenreducer =  (state= initialValues , action) =>{
  switch (action.type) {
    // Set the requesting flag and append a message to be shown
    case SCREEN_REQUEST:
      return {
        params:action.payload.params,
        token:action.payload.token,
        client:action.payload.client,
        uid:action.payload.uid,
        messages: [{ body: 'screen loading ...', time: new Date() }],
      }

    // Successful?  Reset the signup state.
    case SCREEN_SUCCESS:
      return {...state,
        messages: [],
        columns: action.action.data.columns,
        data: action.action.data.data,
        pageInfo: action.action.data.pageInfo?action.action.data.pageInfo:{},
      }

    // Append the error returned from our api
    // set the success and requesting flags to false
    case SCREEN_FAILURE:
      return {
          body: action.errors.toString(),
          time: new Date(),
      }

      case  LOGOUT_REQUEST:
      return {}  

    default:
      return state
  }
}

export default screenreducer
