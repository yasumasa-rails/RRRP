//規定値はセットされない。
import {yupschema} from '../yupschema'
import {dataCheck7} from './yuperrcheck'
import {onBlurFunc7} from './onblurfunc'
export  function yupErrCheckBatch(lines,screenCode) 
{
    let Yup = require('yup')
    let screenSchema = Yup.object().shape(yupschema[screenCode])
    let importdata = []
    let importError = false
    let tblnamechop = screenCode.split("_")[1].slice(0, -1)
    lines.map((line,inx) => {
        if(["add","update","delete"].includes(line["aud"])){
            try{screenSchema.validateSync(line)
                line[`confirm`] = ""  //rb uploadで confirm=""のみを対象としているため
                Object.keys(line).map((fd)=>{
                    if(screenSchema.fields[fd]){  //対象は入力項目のみ
                        line = dataCheck7(screenSchema,fd,line)
                        if(line[`${fd}_gridmessage`] !== "ok"){
                          line[`${fd}_confirm`] = `err ${fd}`
                          line[`${tblnamechop}_confirm_gridmessage`] = `error ${fd}`　
                          importError = true
                        }else{
                            let rval = onBlurFunc7(screenCode,line,fd)
                            line[fd] = rval["linedata"][fd] 
                        }
                    }
                   return line
                  }
                )
            }      
            catch(err){  //jsonにはxxxx_gridmessageはない。
                line[`${tblnamechop}_ confirm_gridmessage`] = `error ${err}`
                line[`confirm`] = false
                importError = true
            }
        }else{
            if(line["aud"]==="aud"){
                }else{
                    line[`confirm`] = "missing aud--> add OR update OR delete "
                    importError = true
            }   
        }  
        importdata.push(line) 
        return {importdata,importError}
    })
    return {importdata,importError}
}  




  