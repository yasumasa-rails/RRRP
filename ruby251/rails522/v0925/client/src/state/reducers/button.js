import {  BUTTONLIST_REQUEST, BUTTONLIST_SUCCESS, BUTTONFLG_REQUEST,
          DOWNLOAD_REQUEST,DOWNLOAD_SUCCESS,DOWNLOAD_RESET,
          TBLFIELD_SUCCESS,SCREEN_SUCCESS,
          LOGOUT_REQUEST} from 'actions'
const initialValues = {
  errors:[],
  buttonflg:""
}

const buttonreducer =  (state= initialValues , actions) =>{
  switch (actions.type) {

    case BUTTONFLG_REQUEST:
      return {...state,
        buttonflg:actions.payload.buttonflg, 
        screenCode:actions.payload.params.screenCode,
        screenName:actions.payload.params.screenName,
        filtered:actions.payload.params.filtered,  
        disabled:true,  
        messages:null,
        message:null, 
      }
    
    case BUTTONLIST_REQUEST:
      return {...state,
        disabled:true,
        messages:null,
        message:null,}

    case BUTTONLIST_SUCCESS:
      return {...state,
      buttonListData:actions.payload,
      disabled:false,
     }

    case DOWNLOAD_REQUEST:
       return {...state,
        excelData:null,
        excelColumns:null,
        totalcnt:null,
        params:actions.payload.params,
        downloadloading:"doing",
        disabled:true,
        messages:null,
        message:null,
     }
    case DOWNLOAD_SUCCESS:
     return {...state,
      excelData:actions.payload.data.excelData,
      excelColumns:actions.payload.data.excelColumns,
      totalcnt:actions.payload.data.totalcnt,
      downloadloading:"done",
      disabled:false,
   }
   case DOWNLOAD_RESET:
    return {...state,
      excelData:null,
      excelColumns:null,
      totalcnt:null,
      buttonflg:null,
      downloadloading:"",
      disabled:false,
  }
  case TBLFIELD_SUCCESS:
   return {...state,
    messages:actions.payload.messages,
    message:actions.payload.message,
    disabled:false,
 }

 case SCREEN_SUCCESS:
  return {...state,
   disabled:false,
   messages:null,
   message:null,
}

    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default buttonreducer
