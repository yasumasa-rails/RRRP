import { SCREEN_REQUEST,SCREEN_SUCCESS,SCREEN_FAILURE,  LOGOUT_REQUEST,SCREEN_PARAMS_SET} 
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
      return {...state,
        screenCode:action.payload.params.screenCode, 
        pageSize:action.payload.params.pageSize, 
        screenName:action.payload.screenName, 
        messages: [{ body: 'screen loading ...', time: new Date() }],
      }

      case SCREEN_PARAMS_SET:
      return {...state,
        pageSize:action.payload.subparams.pageSize,
        page:action.payload.subparams.page,
        sort:action.payload.subparams.sorted, 
        filter:action.payload.subparams.filtered, 
        messages: [],
      }


    // Successful?  .
    case SCREEN_SUCCESS:
      return {...state,
        messages: [],
        columns: action.action.data.columns,　　/// payloadに統一
        data: action.action.data.data,
        pages: action.action.data.pageInfo.totalPage,
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
