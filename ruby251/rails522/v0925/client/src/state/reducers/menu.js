import {  MENU_REQUEST, MENU_SUCCESS, MENU_FAILURE,LOGOUT_REQUEST} from 'actions'
const initialValues = {
  isSubmitting:false,
  errors:[],
}

const menureducer =  (state= initialValues , actions) =>{
  switch (actions.type) {
    
    case MENU_REQUEST:
      return {...state}

    case MENU_SUCCESS:
      return {...state,
        menuListData:actions.action,
      }

    case MENU_FAILURE:
      return {errors:actions.errors,
              messages: [],
              isAuthenticated:false,
    }    

    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default menureducer
