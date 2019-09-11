import React from 'react';
import { connect } from 'react-redux'
//import PropTypes from 'prop-types';
import EditableUpload from './subupload/editableupload';
import NonEditableUpload from './subupload/noneditableupload';
import {ChangeUploadableRequest,ChangeUnUploadRequest} from '../actions'

const Upload = ({ uploadlist,isUpload ,onClieckChangeUploadable}) => (
       
    <React.Fragment>
    <div className="has-text-right buttons-padding">
    
    </div>    
            {isUpload?
            <div>
            <a
            className="button is-primary"
             onClick={()=>onClieckChangeUploadable(isUpload)}>
              Close
            </a>
              <EditableUpload />
            </div>
              :
              <div>
              <p>
              <a
              className="button is-primary"
               onClick={()=>onClieckChangeUploadable(isUpload)}>
                 Upload画面への移動
              </a>
              </p>  
              <p>過去のuploadデータの参照</p>
              <NonEditableUpload uploadlist={uploadlist} />
            </div>
            }
     </React.Fragment>   
    )


const mapDispatchToProps = dispatch => ({
    onClieckChangeUploadable: (isUpload) => {
                                isUpload = !isUpload
                                isUpload?
                                    dispatch(ChangeUploadableRequest(isUpload))
                                    :dispatch(ChangeUnUploadRequest(isUpload))
                                }
  })
  
const mapStateToProps = state =>({
    isAuthenticated:state.login.isAuthenticated ,
      token:(state.login.auth?state.login.auth["access-token"]:"") ,
      client:(state.login.auth?state.login.auth.client:""),
      uid:(state.login.auth?state.login.auth.uid:"") ,
      isEditable:state.upload.isEditable,
      isUpload:state.upload.isUpload,
      uploads:state.button.uploads
    
  })
  

export default  connect(mapStateToProps,mapDispatchToProps)(Upload)