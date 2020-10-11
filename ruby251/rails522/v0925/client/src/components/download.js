// https://www.npmjs.com/package/react-export-excel

import React from 'react'
import { connect } from 'react-redux'
import {DownloadReset} from '../actions'
import { useForm} from 'react-hook-form'
import ReactExport from "react-data-export"

const ExcelFile = ReactExport.ExcelFile;
const ExcelSheet = ReactExport.ExcelFile.ExcelSheet;
//const ExcelColumn = ReactExport.ExcelFile.ExcelColumn;
const options = { year: 'numeric', month: 'long', day: 'numeric' ,hour:'numeric',minute:'numeric',second:'numeric'};
const wtime = (new Date()).toLocaleDateString('ja-JA', options).replace(/:/g,"-")



const Download = ({isSubmitting,onSubmit,screenName,filtered,excelData,totalCount}) => {
        const {  handleSubmit, } = useForm()
        const dataset = [{columns:JSON.parse(excelData.columns),data:JSON.parse(excelData.data)}]
        return(                 
        <div>
        <form  onSubmit={handleSubmit(onSubmit)}> 
           <p>export Table:{screenName}</p>
           <p>select condition </p>
           {filtered.length===0?<p>all data selected </p>: filtered.map((val,index) =>{
                                                    return <p key={index}>{val.id} : {val.value}</p>
           })}
           <p>total record count {totalCount}</p>
               <ExcelFile filename={screenName+wtime} element={<button disabled={isSubmitting}> Data Download </button>}>
                  <ExcelSheet dataSet={dataset} name="export">
                  </ExcelSheet>
               </ExcelFile>
        </form> 
        </div> 
        )             
}

  
    const mapStateToProps = (state,ownProps)  =>({  
      button:state.button,
      screenCode:state.screen.params.screenCode,
      screenName:state.screen.params.screenName,
      filtered:state.download.filtered?state.download.filtered:[], 
      excelData:state.download.excelData,
      totalCount:state.download.totalCount,
      errors:state.download.errors,
      isSubmitting:state.download.isSubmitting,
    })
    
    const mapDispatchToProps = dispatch => ({
      onSubmit: () => dispatch(DownloadReset())
    })
    
export  default  connect(mapStateToProps,mapDispatchToProps)(Download)