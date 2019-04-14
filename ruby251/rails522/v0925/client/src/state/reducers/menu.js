import {  MENU_REQUEST, MENU_SUCCESS, MENU_FAILURE,} from 'actions'
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
      return {errors: {
        body: actions.errors.toString(),
       },       
        messages: [],
        isAuthenticated:false,
    }      

    default:
      return state
  }
}

export default menureducer
