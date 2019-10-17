import React from 'react'
import {connect} from 'react-redux'
import { Form, Field,withFormik, } from 'formik'
import ActiveStorageProvider from 'react-activestorage-provider'
import ClassNames from "classnames"
import "../index.css"
//import Excel from 'exceljs' // fs.  が使用できない
//import XLSX from 'xlsx'　　　//_fs.　が使用できない。
import readXlsxFile from 'read-excel-file'
import {yupErrCheckBatch} from './yupcherrcheckbatch'
//import fileDownload from 'js-file-download'
import CsvDownload from 'react-json-to-csv'

//import ExcelUploader from './exceluploader'
import {EditUploadTitleRequest,CheckExcelDataRequest} from '../actions'

function fcheckexcel(files,screenCode) {
  let importdata = {}
  let lines =[]
  let sheets = []
   readXlsxFile(files, { getSheets: true }).then((sheetnames) => {
      // `rows` is an array of rows
      // each row being an array of cells.
      sheets = sheetnames
    })
      sheets.map((sheet)=>{
              importdata[sheet["name"]] = []
               readXlsxFile(files, { sheet: sheet["name"] }).then((rows) => {
               //console.log(rows)
               let linedata = {}
               let header = []
               rows.map((row,index)=>{
                 if(index===0){
                    row.map((colunm,idx)=>{
                      header[idx] = colunm
                      return header
                    })
                 }else{
                    row.map((colunm,idx)=>{
                      linedata[header[idx]] =  colunm
                      return linedata
                    })
                 }
                 linedata =  yupErrCheckBatch(screenCode,linedata)
                 return linedata
               })
               lines.push(linedata)
               return lines
              })
              importdata[sheet["name"]].push(lines)
              return importdata
    }) 
  return JSON.stringify(importdata)
  //finally{fileDownload(JSON.stringify(rimportdata), files[0].name+".json")}
}


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
const formikForm = ({status,values,handleSubmit,setFieldValue,checkexcel}) =>{
    const {auth,isUpload,isEditable,message,screenCode,rimportdata,filename} = status
    return( 
    <React.Fragment>
    {rimportdata&&Object.keys(JSON.parse(rimportdata)).map((key)=>
        <CsvDownload   data={JSON.parse(rimportdata)[key]}  filename={"result_"+key+"_"+filename} />)}
      <Form > 
           <div className="form-group">
            <p>excelデータの upload (titleとコメントを付加)</p>
            <input
                    type="file" id="inputExcel" 
                    /* disabled={!ready} */
                    onChange={ev =>checkexcel(ev.currentTarget.files[0],screenCode)}
                    
             />
            <ActiveStorageProvider
              endpoint={{
                          path: 'https://localhost:9292/api/uploads',  //localhostでないとダメ　0.0.0.0 ,127.0.0.1  -->ng
                          model: 'Upload',                             // 404が発生
                          attribute: 'excel',
                          method: 'POST',
                          host: 'localhost',
                          port: '9292',
                          }}
              headers={{"access-token":auth["access-token"],client:auth.client,uid:auth.uid}}            
              onSubmit={upload => setFieldValue("id",upload.id) }
              render={({ handleUpload,uploads, ready }) => (
                <div>

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
               disabled={values.title?false:true}/>
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
          screenCode:props.screenCode,
        }),
      handleSubmit : (values,{props}) =>{let auth = props.login.auth
           values["token"] = auth["access-token"]
           values["client"] = auth.client
           values["uid"] = auth.uid
           props.dispatch(EditUploadTitleRequest(values))}, 
      }, 
)(formikForm)
    
const mapStateToProps = (state,ownProps)  =>({  
  login:state.login ,
  upload:state.upload,
  rimportdata:state.upload.rimportdata,
  filename:state.upload.filename,
  screenCode:state.button.screenCode,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
  checkexcel :(filename,screenCode)=>{
    let importdata = fcheckexcel(filename,screenCode)
    dispatch(CheckExcelDataRequest(importdata,screenCode,filename))
  }  
})   

const  ElsxToJson =  connect(mapStateToProps,mapDispatchToProps)(formikEnhancer)
export  default  ElsxToJson;