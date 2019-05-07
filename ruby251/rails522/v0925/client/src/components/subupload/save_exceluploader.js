import React from 'react';
import {connect} from 'react-redux'
import { withFormik } from 'formik'
import Dropzone from "react-dropzone"
import ClassNames from 'classnames';


import Thumb from "./thumb";
const dropzoneStyle = {
  width: "100%",
  height: "100",
  borderWidth: 10,
  borderColor: "rgb(102, 102, 102)",
  borderStyle: "dashed",
  borderRadius: 5,
};

const formikFormup = ({acceptedFiles, rejectedFiles,values,  setFieldValue,} ) => (
      <div className="form-group-dropzropne">
         <Dropzone style={dropzoneStyle} accept=".xlsx" onDrop={(acceptedFiles) => {
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
);
const formikEnhancer = withFormik({
  mapPropsToValues : (props) =>({
    excel:props.upload.values?
                props.upload.values.excel
               :[] ,}) ,
  mapPropsToStatus : (props) =>({
    dropzoneStyle:props.upload.dropzoneStyle,}) ,
})(formikFormup)

const mapStateToProps = (state,ownProps)  =>({  
  upload:state.upload,
  values:state.upload.values,
})

const  ExcelUploader =  connect(mapStateToProps,null)(formikEnhancer)
export  default  ExcelUploader;