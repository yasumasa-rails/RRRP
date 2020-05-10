import React from 'react';
import { connect } from 'react-redux'
import {yupErrCheckBatch} from './yuperrcheckbatch'
import CsvDownload from 'react-json-to-csv'
import {Button} from '../styles/button'
import EditableUpload from './editableupload'
import exportFromJSON from 'export-from-json'
import {ExcelToJsonRequest} from '../actions'

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
                        if(header.indexOf(nameToCode[colunm])===-1){
                            header.push(nameToCode[colunm])
                        }else{
                            header.push(`duplicate field error ${idx+1}`)
                            errorheader = true
                             }
                    }
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

const Upload = ({sheet,filename,message,screenCode,token,client,uid,
                  exceltojson, nameToCode,results }) =>{
  return (   
    <React.Fragment>
    <div className="has-text-right buttons-padding">
              <input
                      type="file" id="inputExcel" 
                      /* disabled={!ready} */
                      placeholder="Excel File"
                      onChange={ev =>{let excelfilename =  ev.currentTarget.files[0].name
                                      if(excelfilename.search(/\.xlsx$|\.xls$/)>1)
                                          {exceltojson(ev.currentTarget.files[0],screenCode)}
                                      else{alert("please input Excel File")
                                          }
                                    }}
               /> 
                 <Button variant="outlined" color="secondary" 
                        type='submit' disabled={filename?false:true}
                        onClick ={() =>{let lines = batchcheck(sheet,screenCode,nameToCode)
                                        let fileName = filename.replace("@","-") + "@" +  screenCode + "@"
                                        exportFromJSON({data:lines,fileName:fileName,exportType:"json" })
                                  }}>
                  JSON</Button>   
          <EditableUpload></EditableUpload>

          {results&&
          <CsvDownload   data={results}  filename={`rslt_${filename}.csv`} >
            結果確認
          </CsvDownload >}
    </div>
          {message}
     </React.Fragment>  
    )
  }

const mapDispatchToProps = dispatch => ({
  exceltojson :(file,screenCode)=>{
    dispatch(ExcelToJsonRequest(file,screenCode))
    },  
  })
  
const mapStateToProps = state =>({
    sheet:state.upload.sheet,
    filename:state.upload.filename,
    message:state.upload.message,
    screenCode:state.screen.screenCode,
    yup:state.screen.yup,
    nameToCode:state.screen.nameToCode,
    results:state.upload.results,
    token:(state.login.auth?state.login.auth["access-token"]:"") ,
    client:(state.login.auth?state.login.auth.client:""),
    uid:(state.login.auth?state.login.auth.uid:"") ,
  })
  

export default  connect(mapStateToProps,mapDispatchToProps)(Upload)