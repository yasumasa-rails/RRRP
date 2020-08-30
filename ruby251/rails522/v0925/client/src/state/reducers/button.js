import {  BUTTONLIST_REQUEST, BUTTONLIST_SUCCESS, BUTTONFLG_REQUEST,GANTT_RESET,
  TBLFIELD_SUCCESS,SCREEN_SUCCESS,GANTTCHART_SUCCESS,LOGOUT_REQUEST,RESET_REQUEST} from 'actions'
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

case GANTT_RESET:
  return {...state,
    disabled:false,}


case BUTTONLIST_SUCCESS:
return {...state,
buttonListData:actions.payload,
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

case GANTTCHART_SUCCESS:
return {...state,
disabled:false,
messages:null,
message:null,
}


case  LOGOUT_REQUEST:
return {}  

case RESET_REQUEST:
return {...state,
  excelData:null,
  totalcnt:null,
  buttonflg:null,
  downloadloading:"",
  disabled:false,
}


default:
return state
}
}

export default buttonreducer