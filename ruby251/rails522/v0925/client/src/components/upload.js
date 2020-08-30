import React from 'react';
import { connect } from 'react-redux'
//import {yupErrCheckBatch} from './yuperrcheckbatch'
//import CsvDownload from 'react-json-to-csv'
import {ExcelToJsonRequest} from '../actions'
//import UploadForFieldSet from './uploadforfieldset'
import {EditableUpload} from './editableupload'
import {ExcelDownload} from './exceldownload'
//import {Button} from '../styles/button'
//import exportFromJSON from 'export-from-json'


const Upload = ({message,exceltojson,results,defCode,excelfile,complete,importError}) =>{
  return (   
    <React.Fragment>
          <div className="has-text-right buttons-padding">
              <label htmlFor='inputExcel'> 登録・変更用 EXCELをJSONに変更
              <input
                      type="file" id="inputExcel" 
                      /* disabled={!ready} */
                      placeholder="Excel File"
                      onChange={ev =>{if( ev.currentTarget.files[0])
                                          {excelfile =  ev.currentTarget.files[0]
                                            let excelfilename =  excelfile.name
                                            if(excelfilename.search(/\.xlsx$/)>1&&excelfilename.search(/\.@/)<0)
                                              {exceltojson(excelfile)}  //.xlsx  は　controllers/api/uploadでも使用
                                            else{alert("please input Excel File")
                                            }
                                          }
                                      }
                                }
               />  </label>
          {results&&importError===false?
              <EditableUpload  defCode={"check_master"} excelfile = {excelfile} >
                <p> 開発メモ・・・スクリプトからファイル選択ダイアログの値を設定することはできません。</p>
              </EditableUpload>
            :importError===true&&defCode==="ExcelToJson"&&
              <p>Header field error please check #check_master json file </p>                  
          }
          {results&&defCode==="check_master"&&importError===false&&complete===false?
              <EditableUpload  defCode={"add_update"} excelfile = {excelfile}  ></EditableUpload>
           :results&&defCode==="check_master"&&importError===true&&complete===false&&
           <p>error please check #add_update json file </p>             
          }
          {/*results&&defCode==="add_update"&&
          <CsvDownload   data={results}  filename={`rslt_${excelfile.name.split(".x")[1]}.csv`} >
            結果確認
          </CsvDownload >*/}

         {results&&complete===true&&
          <ExcelDownload  results={results}  filename={`rslt_${excelfile.name.split(".xlsx")[0]}`} >
          </ExcelDownload >}
          {results&&complete===true&&importError===true?
            <p>error please check rlst excel file </p>
          :results&&complete===true&&importError===false&&  <p>completed </p>
          }   
    </div>
          {message}
     </React.Fragment>  
    )
  }

const mapDispatchToProps = dispatch => ({
  exceltojson :(excelfile)=>{
    dispatch(ExcelToJsonRequest(excelfile))
    },  
  })
  
const mapStateToProps = state =>({
    excelfile:state.upload.excelfile?state.upload.excelfile:{name:""},
    message:state.upload.message,
    errors:state.menu.message,
    yup:state.screen.yup,
    results:state.upload.results,
    defCode:state.upload.defCode,
    complete:state.upload.complete,
    importError:state.upload.importError,
  })

export default  connect(mapStateToProps,mapDispatchToProps)(Upload)
