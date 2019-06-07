import { SCREEN_REQUEST,SCREEN_SUCCESS,SCREEN_FAILURE,
          LOGOUT_REQUEST,SCREEN_PARAMS_SET,
          SCREEN_LINEEDIT,FETCH_REQUEST,FETCH_RESULT,INPUTFIELDPROTECT_REQUEST} 
          from '../../actions'
/* const initialValues = {
  errors:[],
  columns:[{name:"loadung"}],
  data:[{name:"loadung"}],
  pageInfo:{totalpage:0},
} */

export let getScreenState = state => state.screen
const screenreducer =  (state= {} , action) =>{
  switch (action.type) {
    // Set the requesting flag and append a message to be shown
    case SCREEN_REQUEST:
      return {...state,
        screenCode:action.payload.params.screenCode, 
        pageSize:action.payload.params.pageSize, 
        screenName:action.payload.screenName, 
        messages: [{ body: 'screen loading ...', time: new Date() }],
        editableflg:action.payload.editableflg
      }

      case SCREEN_PARAMS_SET:
        return {...state,
          pageSize:action.payload.state.pageSize,
          page:action.payload.state.page,
          sorted:action.payload.state.sorted, 
          filtered:action.payload.state.filtered, 
          messages: [],
      }


    // Successful?  .
    case SCREEN_SUCCESS:
      return {...state,
        messages: [],
        columns: action.action.data.columns,　　/// payloadに統一
        data: action.action.data.data,
        params: action.action.data.params,
        pages: action.action.data.pageInfo.totalPage,
        status: action.action.data.status,
      }
    
    
      case SCREEN_LINEEDIT:
        return {...state,
          messages: [],
          editableflg:true
        /*  params: action.payload.data.params,
          pages: action.payload.data.params.pages,
          page: action.payload.data.params.page, */
      //    status: action.payload.data.status,
        }  

    // Append the error returned from our api
    // set the success and requesting flags to false
    case SCREEN_FAILURE:
      return {
          body: action.errors.toString(),
          time: new Date(),
      }

    case FETCH_REQUEST:
        return {...state,
          params:action.payload.params, 
          token:action.payload.token, 
          client:action.payload.client, 
          uid:action.payload.uid, 
          editableflg:false
        }
  
      case FETCH_RESULT:
            return {...state,
              messages: [],
              data:action.payload.data, 
              editableflg:true
            }
      case INPUTFIELDPROTECT_REQUEST:
                return {...state,
                  //columns:action.payload.columns, 
                  editableflg:false
                }
      

    case  LOGOUT_REQUEST:
      return {}  

    default:
      return state
  }
}

export default screenreducer
