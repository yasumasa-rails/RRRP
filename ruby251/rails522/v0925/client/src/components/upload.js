import React from 'react';
import { connect } from 'react-redux'
import {yupErrCheckBatch} from './yuperrcheckbatch'
import CsvDownload from 'react-json-to-csv'
import {Button} from '../styles/button'
import EditableUpload from './editableupload'
import {CheckJsonDataRequest,ExcelToJsonRequest} from '../actions'

function batchcheck(sheet,screenCode,nameToCode) {
  let lines =[]
  let header = []
  let orgheader = []
  let errorheader = false
  let linedata
  let importdata = []
  header.push("confirm")
  orgheader.push("confirm")
  nameToCode["aud"] = "aud"
  sheet.map((row,index)=>{
          linedata = {}
          if(index===0){
              row.map((colunm,idx)=>{
                  orgheader.push(colunm)
                  if(nameToCode[colunm]){
                        header.push(nameToCode[colunm])}
                  else{header.push(`field error ${idx+1}`)
                        errorheader = true}      
                  return header
                    })
              header.map((colunm,idx)=>{
                linedata[colunm] = orgheader[idx]
                return linedata
              })  
          }else{
              row.map((colunm,idx)=>{
                      linedata[header[idx+1]] =  colunm
                      return linedata
                    })
          }
          lines.push(linedata)
          return lines
        })
          if(errorheader){
            lines[0]["confirm"] = "field error"
            importdata = Array.from(lines)
          }else{
            importdata =  yupErrCheckBatch(lines,screenCode)
          }
  return JSON.stringify(importdata)
  //finally{fileDownload(JSON.stringify(rimportdata), files[0].name+".json")}
}


const Upload = ({sheet,filenamestr,message,screenCode,yup,
                  exceltojson, checkjsondata,nameToCode,results }) =>{
  return (
       
    <React.Fragment>
    <div className="has-text-right buttons-padding">
            <input
                    type="file" id="inputExcel" 
                    /* disabled={!ready} */
                    onChange={ev =>exceltojson(ev.currentTarget.files[0],screenCode)}
             /> 
    <div className="control has-text-left editable-buttons">
      <Button variant="outlined" color="secondary" 
             type='submit' disabled={filenamestr?false:true}
            onClick ={() => checkjsondata(sheet,screenCode,yup,nameToCode,)}>
             チェック</Button> 
    </div>
        {message}

      {results&&filenamestr&& 
      <CsvDownload   data={results}  filename={`rslt_${filenamestr}.csv`} >
        結果確認
      </CsvDownload >}
     <EditableUpload/> 
    </div>
     </React.Fragment>  
    )
  }

const mapDispatchToProps = dispatch => ({
  exceltojson :(file,screenCode)=>{
    dispatch(ExcelToJsonRequest(file,screenCode))
    },  
    checkjsondata :(sheet,screenCode,yup,nameToCode)=>{
      let lines = batchcheck(sheet,screenCode,nameToCode)
      dispatch(CheckJsonDataRequest(lines,screenCode,yup))
      },  
  })
  
const mapStateToProps = state =>({
    sheet:state.upload.sheet,
    filenamestr:state.upload.filename,
    message:state.upload.message,
    screenCode:state.screen.screenCode,
    yup:state.screen.yup,
    nameToCode:state.screen.nameToCode,
    results:state.upload.results,
  })
  

export default  connect(mapStateToProps,mapDispatchToProps)(Upload)