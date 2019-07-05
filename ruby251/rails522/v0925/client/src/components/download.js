// https://www.npmjs.com/package/react-export-excel

import React from 'react'
import { connect } from 'react-redux'
import { Formik, ErrorMessage } from 'formik';
import {DownloadRequest} from '../actions'
import ReactExport from "react-data-export";

const ExcelFile = ReactExport.ExcelFile;
const ExcelSheet = ReactExport.ExcelFile.ExcelSheet;
const ExcelColumn = ReactExport.ExcelFile.ExcelColumn;
const options = { year: 'numeric', month: 'long', day: 'numeric' ,hour:'numeric',minute:'numeric',second:'numeric'};
const wtime = (new Date()).toLocaleDateString('ja-JA', options).replace(/:/g,"-")
const DownloadForm = ({isSubmitting,screenCode,screenName,filtered,handleSubmit,
                       excelData,excelColumns}) => (
    <div>
       <p>export Table {screenName}</p>
  <form  onSubmit={handleSubmit(screenCode,filtered)} >
    <button type="submit" disabled={isSubmitting}>
    export
    </button>
      </form>
        {excelData&&
             <ExcelFile filename={screenName+wtime}>
                <ExcelSheet data={excelData} name="export">
                   {excelColumns.map((val,index) =>{ 
                     return (  <ExcelColumn label={val.label} value={val.vale} />)
                    }) }
                </ExcelSheet>
            </ExcelFile>
            }
    </div>              
  )



const initialValues = {
  }
const  mapStateToProps = (state) => ({
              screenCode:state.screen.params.screenCode,
              screenName:state.screen.params.screenName,
              filtered:state.screen.parms.filtered, 
              excelData:state.button.excelData,
              excelColumns:state.button.excelColumns
  })
       
  const mapDispatchToProps = dispatch => ({
    handleSubmit: (screenCode,filtered) => dispatch(DownloadRequest(screenCode,filtered))
    })

  const Container = ({onSubmit}) => (
      <Formik 
        initialValues={initialValues}
        validateOnBlur={false}
        validateOnChange={false}
        onSubmit={onSubmit}
        render={(props) => <DownloadForm {...props} />}
      />
)  

export  const Download = connect(mapStateToProps,mapDispatchToProps)(Container)