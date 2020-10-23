import {  SCREENINIT_REQUEST,SCREEN_REQUEST,SCREEN_SUCCESS7,
  SCREEN_FAILURE,LOGOUT_REQUEST,SCREEN_PARAMS_SET,
  SCREEN_LINEEDIT,SCREEN_ERR_CHECK_RESULT,SCREEN_ONBLUR,
  //SCREEN_ONKEYUP,
  FETCH_REQUEST,FETCH_RESULT,FETCH_FAILURE,
  YUP_ERR_SET,YUP_RESULT,DROPDOWNVALUE_SET,
  INPUTFIELDPROTECT_REQUEST,INPUTPROTECT_RESULT, MKSHPINSTS_SUCCESS,
} 
  from '../../actions'

export let getScreenState = state => state.screen

const initialValues = {
}

const screenreducer =  ( state= initialValues , action) =>{
switch (action.type) {
// Set the requesting flag and append a message to be shown

case SCREENINIT_REQUEST:
  return {...state,
          params:action.payload.params,
          loading:true,
          message: [{ body: 'screen loading ...', time: new Date() }],
          // editableflg:action.payload.editableflg
}


case SCREEN_PARAMS_SET:
return {...state,
  params:action.payload.params,
}

case SCREEN_ONBLUR:
return {...state,
  data:action.payload.data,
}

//case SCREEN_ONKEYUP:
//return {...state,
//  data:action.payload.data,
//}


case YUP_ERR_SET:
  return {...state,
    data:action.payload.data,
    loading : false,
    error : action.payload.error,
}
  
case SCREEN_ERR_CHECK_RESULT:
return {...state,
  data:action.payload.data,
  loading:false,
  filterable:false,          
}

case SCREEN_REQUEST:
return {...state,
        params:action.payload.params,
        loading:true,
        message: [{ body: 'screen loading ...', time: new Date() }],
        // editableflg:action.payload.editableflg
}

case SCREEN_SUCCESS7: // payloadに統一
return {...state,
  loading:false,
  hostError: null,
  filterable:true,
  disabled:false,
  data: action.payload.data.data,
  params: action.payload.data.params,
  status: action.payload.data.status,
  grid_columns_info:action.payload.data.grid_columns_info,
  //filterable:action.action.data.params.req==="viewtablereq"?true:false,
}

case SCREEN_LINEEDIT:
return {...state,
  data:action.payload.data,
  params:action.payload.params,
  loading:false,
  filterable:false,  
  hostError:action.payload.data[action.payload.params.index].confirm_message
}  

case  DROPDOWNVALUE_SET:
    let {index,field,val} = {...action.payload.dropDownValue}
    state.data[index][field] = val
    return {...state,
      data:state.data
  }  

// Append the error returned from our api
// set the success and requesting flags to false
case SCREEN_FAILURE:
  return {...state,
  hostError: action.payload.message,
  data: action.payload.data,
  loading:false,
}

case FETCH_REQUEST:
return {...state,
  params:action.payload.params, 
  loading:true,
  //editableflg:false
}

case FETCH_FAILURE:
    return {...state,
      data:action.payload.data,  
      params:action.payload.params,  
      loading:false,
      filterable:false,
      hostError: action.payload.params.err,  
    }

case FETCH_RESULT:
          return {...state,
            data:action.payload.data, 
            params:action.payload.params,  
            loading:false,
            filterable:false,
            hostError: null,
    }

case INPUTFIELDPROTECT_REQUEST:
  return {...state,
            }
case INPUTPROTECT_RESULT:
  return {...state,
          }

case YUP_RESULT:
    return {...state,
      message: action.payload.message,
    }

case MKSHPINSTS_SUCCESS:
      return {...state,
        loading:false,
}

case  LOGOUT_REQUEST:
return {}  

default:
return state
}
}

export default screenreducer
