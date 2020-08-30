import {  UPLOAD_REQUEST,
        UPLOAD_SUCCESS,EXCELTOJSON_SUCCESS,UPLOADFORFIELDSET_REQUEST,
        SETRESULTS_REQUEST,SETRESULTS_SUCCESS,
        // CHANGEUPLOADTITLEEDITABLE_REQUEST,EXCELTOJSON_REQUEST,
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

  //case EXCELTOJSON_REQUEST:
  //      return {...state,
  //              file:actions.payload.file,
  //              screenCode:actions.payload.screenCode,
  //              nameToCode:actions.payload.nameToCode,
  //              }

  case EXCELTOJSON_SUCCESS:
      return {...state,
                //newFileName:actions.payload.newFileName, 
                //jsonURL:actions.payload.jsonURL,  
                //data:actions.payload.data, 
          }
/*
  case CHANGEUPLOADTITLEEDITABLE_REQUEST:
       return {...state,
               upload:actions.payload.upload,
               isEditable:true, }
*/      
case UPLOADFORFIELDSET_REQUEST:  //uploadしrailsで処理した結果
        return {...state,
                jsonfilename: actions.payload.jsonfilename,
                screenCode: actions.payload.screenCode,
    }

case SETRESULTS_REQUEST:
        return {...state,
          results: actions.payload.results,
          defCode: actions.payload.defCode,
          excelfile: actions.payload.excelfile,
    }    
case SETRESULTS_SUCCESS:
        return {...state,
                results: actions.payload.results,
                complete: actions.payload.complete,
                importError: actions.payload.importError,
           }
                       
  case  LOGOUT_REQUEST:
  return {}  

  default:
    return {...state}
        }
}

export default uploadreducer
