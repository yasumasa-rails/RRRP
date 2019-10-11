import React from 'react';
import {connect} from 'react-redux'
import { Form, Field,withFormik } from 'formik';
import ClassNames from "classnames"
import Dropzone from "react-dropzone"
import "../../index.css"

//import ExcelUploader from './exceluploader'
import Thumb from "./thumb";
import {UploadRequest,EditUploadTitleRequest} from '../../actions'

const InputFeedback = ({ error }) =>
  error ? <div className={ClassNames("input-feedback")}>{error}</div> : null;

// Checkbox input
const Checkbox = ({
  field: { name, value, onChange, onBlur },
  form: { errors, touched, setFieldValue },
  id,
  label,
  className,
  ...props
}) => {
  return (
    <div>
      <input
        name={name}
        id={id}
        type="checkbox"
        value={value}
        checked={value}
        onChange={onChange}
        onBlur={onBlur}
        className={ClassNames("radio-button")}
      />
      <label htmlFor={id}>{label}</label>
      {touched[name] && <InputFeedback error={errors[name]} />}
    </div>
  );
};

const dropzoneStyle= {
  width: "50%",
  height: "10",
  borderWidth: 10,
  borderColor: "rgb(102, 102, 102)",
  borderStyle: "dashed",
  borderRadius: 5,
};

const dropzoneRef = createRef()

const formikForm = ({status,acceptedFiles, rejectedFiles,values,setFieldValue}) =>(

  <React.Fragment>
      <Form > 
        {status.isUpload?
           <div className="form-group">
            <p>excelデータの upload (titleとコメントを付加)</p>
                 <Dropzone style={dropzoneStyle}  accept=".xlsx" onDrop={(acceptedFiles) => {
                                 if (acceptedFiles.length === 0) { return; }    
                                         // Do something with files
                                 setFieldValue("excel", values.excel.concat(acceptedFiles));        
                                        }}>
                          {({ isDragActive, isDragReject, acceptedFiles, rejectedFiles }) => {
                            if (isDragActive) {
                              return "This file is authorized";
                            }
        
                            if (isDragReject) {
                              return "This file is not authorized";
                            }
        
                            if (values.excel.length === 0) {
                              return <p>Try dragging a file here!</p>
                            }
        
                            return values.excel.map((file, i) => (<Thumb key={i} file={file} />));
                          }}
              </Dropzone>
          </div>    
          :<div  className="form-group"><p>過去のuploadデータのtitle変更</p></div>
        }
           <div  className="form-group">  
              id:{values.id} 
             <Field
              name="id"  type="hidden" />
          </div>
          <div>    
             <label  className="label">Title</label>
             <Field
              name="title"
              className="input" 
              type="text" />
            </div>  
          <div className="control">
          <label className="label">Contents</label>
            <Field
              name="contents"    component="textarea"/>
          </div>
          {status.isEditable&&
            <div>
              <label className="label">Delete yes:check
                <Field name="deleteflg" label="delete" component={Checkbox} />
              </label></div>
          }    
          <div className="control has-text-left editable-buttons">
            <input type="submit" value="Submit" className="button is-danger" />
          </div>
       </Form>
      </React.Fragment>
    );

const formikEnhancer = withFormik({
      mapPropsToValues : (props) =>({
        id:props.upload.values?props.upload.values.id:"",
        excel:props.upload.values?props.upload.values.excel:[],
        title:props.upload.values?props.upload.values.title:"",
        contents:props.upload.values?props.upload.values.contents:"",}),
      mapPropsToStatus : (props) =>({
          isUpload:props.upload.isUpload,
          isEditable:props.upload.isEditable,
          uid:props.login.auth.uid ,}),
      handleSubmit : (values,{props}) =>{let auth = props.login.auth
           values["token"] = auth["access-token"]
           values["client"] = auth.client
           values["uid"] = auth.uid
           props.upload.isUpload?
             props.dispatch(UploadRequest(values))
            :props.dispatch(EditUploadTitleRequest(values))}, 
})(formikForm)
    
const mapStateToProps = (state,ownProps)  =>({  
  login:state.login ,
  upload:state.upload,
  dropzoneStyle:state.dropzoneStyle
})

const  EditableUpload =  connect(mapStateToProps,null)(formikEnhancer)
export  default  EditableUpload;