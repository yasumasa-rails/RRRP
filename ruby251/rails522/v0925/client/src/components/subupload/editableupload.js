import React from 'react'
import {connect} from 'react-redux'
import { Form, Field,withFormik, } from 'formik'
import ActiveStorageProvider from 'react-activestorage-provider'
import ClassNames from "classnames"
import "../../index.css"

//import ExcelUploader from './exceluploader'
import {EditUploadTitleRequest,EditUploadRequest} from '../../actions'



const InputFeedback = ({ error }) =>
  error ? <div className={ClassNames("input-feedback")}>{error}</div> : null;

// Checkbox input
const Checkbox = ({
  field: { name, value, onChange, onBlur },
  form: { errors, touched,},
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
const formikForm = ({status,values,handleSubmit,setFieldValue,handleChange}) =>{
    const {auth,isUpload,isEditable,message,} = status
    return( 
    <React.Fragment>
      <Form > 
        {isUpload?
           <div className="form-group">
            <p>excelデータの upload (titleとコメントを付加)</p>
            <ActiveStorageProvider
              endpoint={{
                          path: 'http://localhost:3001/api/uploads',
                          model: 'Upload',
                          attribute: 'excel',
                          method: 'POST',
                          host: 'localhost',
                          port: '9292',
                          }}
              headers={{"access-token":auth["access-token"],client:auth.client,uid:auth.uid}}            
              onSubmit={upload => setFieldValue("id",upload.id) }
              render={({ uploads, ready,handleUpload }) => (
                <div>
                  <input
                    type="file"
                    disabled={!ready}
                    onChange={ev =>handleUpload(ev.currentTarget.files)}
                  />

                {uploads.map(file => {
                  switch (file.state) {
                    case 'waiting':
                      return <p key={file.id}>Waiting to upload {file.file.name}</p>
                    case 'uploading':
                      return ( <p key={file.id}>
                                Uploading {file.file.name}: {file.progress}%
                              </p>
                      )
                    case 'error':
                      return (
                        <p key={file.id}>
                          Error uploading {file.file.name}: {file.error}
                        </p>
                      )   
                    case 'finished':
                      return (
                        <p key={file.id}>Finished uploading {file.file.name}</p>
                      )
                    default:
                      return (<p>.....</p>)    
                  }     
                })}
                </div>  
              )}
            />
          </div>    
          :<div  className="form-group"><p>過去のuploadデータのtitle変更</p></div>
        }
           <div  className="form-group">  
              id:{values.id} 
             <Field
              name="id"  type="hidden"   className="input"   />
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
          {isEditable&&
            <div>
              <label className="label">Delete yes:check
                <Field name="deleteflg" label="delete" component={Checkbox} />
              </label></div>
          }    
          <div className="control has-text-left editable-buttons">
            <input type="submit" value="Submit" className="button is-danger"
               disabled={values.id&&values.title?false:true}/>
          </div>
          {message}
       </Form>
       
      </React.Fragment>
    )};

    

const formikEnhancer = withFormik({
      mapPropsToValues : (props) =>({
        id:props.upload.values?props.upload.values.id:"",
        title:props.upload.values?props.upload.values.title:"",
        contents:props.upload.values?props.upload.values.contents:"",
        }),
      mapPropsToStatus : (props) =>({
          isUpload:props.upload.isUpload,
          isEditable:props.upload.isEditable,
          auth:props.login.auth,
          message:props.upload.message,
        }),
      handleSubmit : (values,{props}) =>{let auth = props.login.auth
           values["token"] = auth["access-token"]
           values["client"] = auth.client
           values["uid"] = auth.uid
           props.upload.isUpload?props.dispatch(EditUploadRequest(values))
           :props.dispatch(EditUploadTitleRequest(values))}, 
      }, 
)(formikForm)
    
const mapStateToProps = (state,ownProps)  =>({  
  login:state.login ,
  upload:state.upload,
})

const  EditableUpload =  connect(mapStateToProps,null)(formikEnhancer)
export  default  EditableUpload;