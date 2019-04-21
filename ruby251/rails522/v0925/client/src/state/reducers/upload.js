import {  UPLOAD_REQUEST, UPLOAD_SUCCESS, UPLOAD_FAILURE,LOGOUT_REQUEST} from 'actions'
const initialValues = {
  isSubmitting:false,
  errors:[],
}

const uploadreducer =  (state= initialValues , actions) =>{
  switch (actions.type) {
    
    case UPLOAD_REQUEST:
      return {...state}

    case UPLOAD_SUCCESS:
      return {...state,
        upload:actions.upload,
      }

    case UPLOAD_FAILURE:
      return {errors: {
        body: actions.errors.toString(),
       },       
        messages: [],
    }    

    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default uploadreducer
