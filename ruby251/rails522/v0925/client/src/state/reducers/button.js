import {  BUTTONLIST_REQUEST, BUTTONLIST_SUCCESS, BUTTONFLG_REQUEST,GANTT_RESET,SCREENINIT_REQUEST,
  TBLFIELD_SUCCESS,GANTTCHART_SUCCESS,LOGOUT_REQUEST,DOWNLOAD_RESET,SCREEN_SUCCESS7,DOWNLOAD_SUCCESS} //RESET_REQUEST
   from 'actions'

export let getButtonState = state => state.button
const initialValues = {
errors:[],
buttonflg:"viewtablereq7",
messages:null,
message:null, 
}

const buttonreducer =  (state= initialValues , actions) =>{
switch (actions.type) {

case BUTTONFLG_REQUEST:
return {...state,
buttonflg:actions.payload.buttonflg, 
screenCode:actions.payload.params.screenCode,
screenName:actions.payload.params.screenName,
disabled:true,  
messages:null,
message:null, 
}


case SCREENINIT_REQUEST:
  return {...state,
    buttonflg:actions.payload.params.req, 
          // editableflg:action.payload.editableflg
}

case SCREEN_SUCCESS7:
return {...state,
disabled:false,
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

case GANTTCHART_SUCCESS:
return {...state,
  buttonflg:"ganttchart",
}


case DOWNLOAD_SUCCESS:
return {...state,
buttonflg:"export",
}

case DOWNLOAD_RESET:
return {...state,
  disabled:false,
}


case  LOGOUT_REQUEST:
return {}  

default:
return state
}
}

export default buttonreducer