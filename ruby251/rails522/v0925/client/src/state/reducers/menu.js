import {  MENU_REQUEST, MENU_SUCCESS,LOGOUT_REQUEST,MENU_FAILURE} from 'actions'
const initialValues = {
  isSubmitting:false,
  isSignUp:false,
  errors:[],
}

const menureducer =  (state= initialValues , actions) =>{
  switch (actions.type) {
    
    case MENU_REQUEST:
      return {...state,
        token:actions.payload.token,
        client:actions.payload.client,
        uid:actions.payload.uid,}

    case MENU_SUCCESS:
      return {...state,
        menuListData:actions.action,
      }

    case MENU_FAILURE:
      return {...state,
        message:actions.errors,
    }        

    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default menureducer