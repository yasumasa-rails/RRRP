//規定値はセットされない。
import {yupschema} from '../yupschema'
export  function yupErrCheckBatch(lines,screenCode) 
{
    let Yup = require('yup')
    let screenSchema = Yup.object().shape(yupschema[screenCode])
    let importdata = []
    lines.map((line) => {
        if(["add","update","delete"].includes(line["aud"])){
            try{screenSchema.validateSync(line)
              line["confirm"] = ""
            }      
            catch(err){  //jsonにはxxxx_gridmessageはない。
                line["confirm"] = `err ${err.path}`
            }
        }else{
            if(line["confirm"]==="confirm"&line["aud"]==="aud"){
                }else{
            line["confirm"] = "missing aud--> add OR update OR delete "
            }   
        }  
        importdata.push(line) 
        return importdata
    })
    return importdata
}  