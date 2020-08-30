import {  DOWNLOAD_REQUEST,DOWNLOAD_SUCCESS,DOWNLOAD_RESET,LOGOUT_REQUEST,RESET_REQUEST,
            SCREEN_SUCCESS,GANTTCHART_SUCCESS } from 'actions'
const initialValues = {
errors:[],
buttonflg:""
}

const downloadreducer =  (state= initialValues , actions) =>{
switch (actions.type) {
case DOWNLOAD_REQUEST:
return {...state,
excelData:null,
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
totalcnt:actions.payload.data.totalcnt,
downloadloading:"done",
disabled:false,
}
case DOWNLOAD_RESET:
return {...state,
excelData:null,
totalcnt:null,
buttonflg:null,
downloadloading:"",
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

export default downloadreducer