import {  UPLOAD_REQUEST,EXCELTOJSON_REQUEST,
        UPLOAD_SUCCESS,EXCELTOJSON_SUCCESS,
         CHANGEUPLOADTITLEEDITABLE_REQUEST,CHECKJSONDATA_SUCCESS,
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

  case EXCELTOJSON_REQUEST:
        return {...state,
                file:actions.payload.file,
                screenCode:actions.payload.screenCode,
                filename:null}

  case EXCELTOJSON_SUCCESS:
      return {...state,
              sheet:actions.payload.sheet,
              filename:actions.payload.filename,  }

  case CHANGEUPLOADTITLEEDITABLE_REQUEST:
       return {...state,
               upload:actions.payload.upload,
               isEditable:true, }
      
  case CHECKJSONDATA_SUCCESS:
       return {...state,
               results:actions.payload.results,
         }
                       
  case  LOGOUT_REQUEST:
  return {}  

  default:
    return {...state}
        }
}

export default uploadreducer
