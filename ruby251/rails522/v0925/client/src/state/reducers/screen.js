import { SCREEN_REQUEST,SCREEN_SUCCESS,SCREEN_FAILURE,
  LOGOUT_REQUEST,SCREEN_PARAMS_SET,
  SCREEN_LINEEDIT,SCREEN_ERR_CHECK_RESULT,
  FETCH_REQUEST,FETCH_RESULT,FETCH_FAILURE,
  YUP_ERR_SET,YUP_RESULT,DROPDOWNVALUE_SET,
//  INPUTFIELDPROTECT_REQUEST
} 
  from '../../actions'

export let getScreenState = state => state.screen
const screenreducer =  (state= {} , action) =>{
switch (action.type) {
// Set the requesting flag and append a message to be shown
case SCREEN_REQUEST:
return {...state,
screenCode:action.payload.params.screenCode, 
pageSize:action.payload.params.pageSize, 
screenName:action.payload.params.screenName, 
loading:true,
message: [{ body: 'screen loading ...', time: new Date() }],
// editableflg:action.payload.editableflg
}

case SCREEN_PARAMS_SET:
return {...state,
  params:action.payload.params,
}

case YUP_ERR_SET:
  return {...state,
    data:action.payload.data,
    loading : false
}
  

case SCREEN_ERR_CHECK_RESULT:
return {...state,
  data:action.payload.data,
  loading:false,
  filterable:false,          
}

// Successful?  .
case SCREEN_SUCCESS:
return {...state,
message: [],
columns: action.action.data.columns,　　/// payloadに統一
data: action.action.data.data,
params: action.action.data.params,
pages: action.action.data.pageInfo.totalPage,
sizePerPageList: action.action.data.pageInfo.sizePerPageList,
screenwidth: action.action.data.pageInfo.screenwidth,
yup:action.action.data.yup,
dropDownList:action.action.data.dropdownlist,
status: action.action.data.status,
loading:false,
filterable:action.action.data.params.req==="viewtablereq"?true:false,
originalreq: action.action.data.params.req,
pageText: 'total count xx,xxx,xxx   Page',
nameToCode:action.action.data.nameToCode,
}


case SCREEN_LINEEDIT:
return {...state,
  data:action.payload.data,
  loading:false,
  filterable:false,  
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
return {
message: action.errors.message,
}

case FETCH_REQUEST:
return {...state,
  params:action.payload.params, 
  token:action.payload.token, 
  client:action.payload.client, 
  uid:action.payload.uid, 
  loading:true,
  //editableflg:false
}

case FETCH_FAILURE:
    return {...state,
      data:action.payload.data,  
      loading:false,
      filterable:false,
    }

case FETCH_RESULT:
          return {...state,
            data:action.payload.data, 
            loading:false,
            filterable:false,
    }

//  case INPUTFIELDPROTECT_REQUEST:
//            return {...state,
//              //columns:action.payload.columns, 
//              editableflg:false
//            }

case YUP_RESULT:
    return {...state,
      message: action.payload.message,
    }

case  LOGOUT_REQUEST:
return {}  

default:
return state
}
}

export default screenreducer
