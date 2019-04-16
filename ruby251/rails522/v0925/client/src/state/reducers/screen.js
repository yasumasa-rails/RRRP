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
        pageSize:action.payload.params.pageSize,
        page:action.payload.params?action.payload.params.page:0,
        screenCode:action.payload.params.screenCode, 
        sort:action.payload.params.sort, 
        filter:action.payload.params.filter, 
        token:action.payload.token, 
        client:action.payload.client, 
        uid:action.payload.uid, 
        messages: [{ body: 'screen loading ...', time: new Date() }],
      }

    // Successful?  .
    case SCREEN_SUCCESS:
      return {...state,
        messages: [],
        columns: action.action.data.columns,
        data: action.action.data.data,
        pages: action.action.data.pageInfo.totalPage 
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
