// https://www.npmjs.com/package/react-export-excel

import React from 'react'
import { connect } from 'react-redux'
import { Form, withFormik} from 'formik';
import {DownloadReset} from '../actions'
import ReactExport from "react-data-export";

const ExcelFile = ReactExport.ExcelFile;
const ExcelSheet = ReactExport.ExcelFile.ExcelSheet;
//const ExcelColumn = ReactExport.ExcelFile.ExcelColumn;
const options = { year: 'numeric', month: 'long', day: 'numeric' ,hour:'numeric',minute:'numeric',second:'numeric'};
const wtime = (new Date()).toLocaleDateString('ja-JA', options).replace(/:/g,"-")

/*
// EXCELのヘッダーの色は変更でない。
const sample = [
  {
      columns: [
          {title: "Headings"},
          {title: "Text Style"},
          {title: "Colors", width: {wpx: 120}},
      ],
      data: [
          [
              {value: "H1"},
              {value: "Bold",style: {fill: {patternType: "solid",fgColor: {rgb: "FFF86B"}}}},
              {value: "Red"},
          ],
          [
              {value: "H2"},
              {value: "underline",style: {fill: {fgColor:{rgb:"123456"}}}},
              {value: "Blue"},
          ],        
      ]
  }
];
*/
const formikForm = ({isSubmitting,handleSubmit,status, values}) => {
        const {screenName,filtered,excelData,totalcnt} = status
        const dataset = [{columns:JSON.parse(excelData.columns),data:JSON.parse(excelData.data)}]
        return(                 
        <div>
          <Form {...values} onSubmit={handleSubmit}>
           <p>export Table       {screenName}</p>
           <p>select condition </p>
           {filtered.length===0?<p>all data selected </p>: filtered.map((val,index) =>{
                                                    return <p key={index}>{val.id} : {val.value}</p>
           })}
           <p>total record count {totalcnt}</p>
               <ExcelFile filename={screenName+wtime} element={<button disabled={isSubmitting}> Data Download </button>} >
                  <ExcelSheet dataSet={dataset} name="export">
                  </ExcelSheet>
               </ExcelFile>
          </Form>
        </div> 
        )             
}

    const formikEnhancer = withFormik({
      mapPropsToValues : (props) =>({
        }),
      mapPropsToStatus : (props) =>({
        screenCode:props.button.screenCode,
        screenName:props.button.screenName,
        filtered:props.button.filtered?props.button.filtered:[], 
        excelData:props.button.excelData,
        totalcnt:props.button.totalcnt,
        }),
      handleSubmit : (values,{props}) =>{ /*
        let params={screenCode:values.screencode,filtered:values.filtered,req:"download"}
        props.dispatch(DownloadRequest(params)) */
        props.dispatch(DownloadReset()) 
            }, 
          }, 
    )(formikForm)
    
    const mapStateToProps = (state,ownProps)  =>({  
      button:state.button,
    })

const  Download =  connect(mapStateToProps,null)(formikEnhancer)
export  default  Download;