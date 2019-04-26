import {  UPLOAD_REQUEST, LOGOUT_REQUEST} from 'actions'
const initialValues = {
  isSubmitting:false,
  errors:[],
}

const uploadreducer =  (state= initialValues , actions) =>{
  switch (actions.type) {
    
    case UPLOAD_REQUEST:
      return {...state}


    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default uploadreducer
