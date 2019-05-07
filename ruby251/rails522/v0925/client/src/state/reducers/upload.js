import {  UPLOAD_REQUEST, UPLOADLIST_REQUEST,
          UPLOAD_SUCCESS,UPLOADLIST_SUCCESS,
           CHANGEUPLOADABLE_REQUEST,CHANGEUNUPLOAD_REQUEST,
           CHANGEUPLOADTITLEEDITABLE_REQUEST,EDITUPLOADTITLE_REQUEST,
           EDITUPLOADTITLE_SUCCESS, EDITUPLOAD_RESULT,
          LOGOUT_REQUEST} from 'actions'
const initialValues = {
  isEditable:false,
  isUpload:false,
  isSubmitting:false,
  errors:[],
}

const uploadreducer =  (state= initialValues , actions) =>{
  switch (actions.type) {
    
    case UPLOAD_REQUEST:
      return {...state,
              values:actions.payload.values}
     
    
    case UPLOAD_SUCCESS:
      return {...state,
              imageFromController:actions.payload.imageFromController}          

    case CHANGEUPLOADABLE_REQUEST:
        return {...state,
                isUpload:true,}

    case CHANGEUNUPLOAD_REQUEST:
          return {...state,
                  isEditable:false, 
                  isUpload:false,}

    case UPLOADLIST_REQUEST:
        return {...state,
                values:actions.payload.values}

    case UPLOADLIST_SUCCESS:
        return {...state,
                uploadlists:actions.payload}

    case CHANGEUPLOADTITLEEDITABLE_REQUEST:
         return {...state,
                 upload:actions.payload.upload,
                 isEditable:true, }
        
    case EDITUPLOADTITLE_REQUEST:
    return {...state,
            upload:actions.payload.upload,
            isEditable:true, }

    case EDITUPLOADTITLE_SUCCESS:
         return {...state,
                 data:actions.payload,
                 status:"ok", }
   
    case EDITUPLOAD_RESULT:
        return {...state,
                message:actions.payload.message }
                               
                        
    case  LOGOUT_REQUEST:
    return {}  

    default:
      return state
  }
}

export default uploadreducer
