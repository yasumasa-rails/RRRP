import {  BUTTONLIST_REQUEST, BUTTONLIST_SUCCESS, BUTTONFLG_REQUEST,
          LOGOUT_REQUEST} from 'actions'
const initialValues = {
  errors:[],
  buttonflg:""
}

const buttonreducer =  (state= initialValues , actions) =>{
  switch (actions.type) {
    
    case BUTTONLIST_REQUEST:
      return {...state}

    case BUTTONLIST_SUCCESS:
      return {...state,
      buttonListData:actions.payload,
     }

    case BUTTONFLG_REQUEST:
       return {...state,
        buttonflg:actions.payload.buttonflg,
        loading : true,
     }

    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default buttonreducer
