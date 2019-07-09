import {  BUTTONLIST_REQUEST, BUTTONLIST_SUCCESS, BUTTONFLG_REQUEST,
          DOWNLOAD_REQUEST,DOWNLOAD_SUCCESS,DOWNLOAD_RESET,
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
      }
    
    case BUTTONLIST_REQUEST:
      return {...state}

    case BUTTONLIST_SUCCESS:
      return {...state,
      buttonListData:actions.payload,
     }

    case DOWNLOAD_REQUEST:
       return {...state,
        excelData:null,
        excelColumns:null,
        totalcnt:null,
        params:actions.payload.params,
        downloadloading:"doing",
     }
    case DOWNLOAD_SUCCESS:
     return {...state,
      excelData:actions.payload.data.excelData,
      excelColumns:actions.payload.data.excelColumns,
      totalcnt:actions.payload.data.totalcnt,
      downloadloading:"done",
   }
   case DOWNLOAD_RESET:
    return {...state,
      excelData:null,
      excelColumns:null,
      totalcnt:null,
      buttonflg:null,
      downloadloading:"",
  }

    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default buttonreducer
