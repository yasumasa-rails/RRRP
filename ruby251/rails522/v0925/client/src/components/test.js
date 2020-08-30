//規定値はセットされない。
//export  function yupErrCheckBatch(lines,screenCode) 
function yupErrCheckBatch(lines,screenCode) 
{
    let screenSchema = {}
    let importdata = []
    let tblnamechop = screenCode.split("_")[1].slice(0, -1)
    lines.map((line,inx) => {
        if(["add","update","delete"].includes(line["aud"])){
            try{screenSchema.validateSync(line)
                line[`confirm`] = ""  //rb uploadで confirm=""のみを対象としているため
                Object.keys(line).map((fd)=>{
                    if(screenSchema.fields[fd]){  //対象は入力項目のみ
                        line = {}
                        if(line[`${fd}_gridmessage`] !== "ok"){
                          line[`${fd}_confirm`] = `err ${fd}`
                          line[`${tblnamechop}_confirm_gridmessage`] = `err ${fd}`　
                        }else{
                            let rval = ""
                            line[fd] = rval["linedata"][fd] 
                        }
                    }
                   return line
                  }
                )
            }      
            catch(err){  //jsonにはxxxx_gridmessageはない。
                line[`${tblnamechop}_ confirm_gridmessage`] = `err ${err}`
                line[`confirm`] = false
            }
        }else{
            if(line["aud"]==="aud"){
                }else{
                    line[`confirm`] = "missing aud--> add OR update OR delete "
            }   
        }  
        importdata.push(line) 
        return importdata
    })
    return importdata
}  