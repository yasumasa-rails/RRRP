export  function yupErrCheck (schema,field,params,data) {
  let mfield
  let linedata =  data[params.index]  
  try{schema.validateSync(linedata)
    switch(field) {
    case "confirm"  :  //1行すべてのチェック})
            linedata.confirm = true
            linedata.confirm_gridmessage = "done"
            params = {...params,req:"confirm",linedata:linedata}
            Object.keys(linedata).map((fd)=>{
                if(schema.fields[field]){  //対象は入力項目のみ
                  linedata = datacheck(schema,fd,linedata)
                  if(linedata[`${fd}_gridmessage`] !== "ok"){
                      linedata.confirm = false
                      linedata.confirm_gridmessage =  `err ${fd}　${linedata[`${fd}_gridmessage`]}　`
                    }
                }  
                return linedata
              }
            )
            data[params.index] =  linedata
            return data
    default: 
            datacheck(schema,field,linedata) 
            data[params.index] =  linedata
            return data
    }
  }      
  catch(err){
    switch(field){
    case "confirm"  :  //1行すべてのチェック
              linedata.confirm = false
              mfield = err.path+"_gridmessage"
              linedata[mfield] = err.errors.join(",")
              linedata.confirm_gridmessage = `err ${err.path}　${linedata[mfield]}　`
              data[params.index] =  linedata
              return data
    default:  
              mfield = field+"_gridmessage"
              linedata[mfield] = err.errors.join(",")
              data[params.index] =  linedata
              return data
        }
  }
}  

//未実施　yupでは数値項目で　"スペース999" がエラーにならない。

// yupでは　2019/12/32等がエラーにならない。　2020/01/01になってしまう
export function datacheck(schema,field,linedata){ 
  if(schema.fields[field]){
    switch(schema.fields[field]["_type"]){
      case "date" :
          let moment = require('moment');
          let yyyymmdd = linedata[field].split(/-|\//)
          if(yyyymmdd[1] === undefined){linedata[`${field}_gridmessage`] = "not date type yyyy/mm/dd or yyyy-mm-dd"}
          else{
              if(yyyymmdd[1].length===1){yyyymmdd[1] = "0"+yyyymmdd[1]}
              if(yyyymmdd[2] === undefined ){yyyymmdd[2] = "01"
                                        linedata[field] = yyyymmdd[0]+"-"+yyyymmdd[1]+"-"+yyyymmdd[2]}
              //if(/(\d){4}\/|-\d+\d+\/|-\d+\d+/.test(linedata[field])){ // "/"や2019-2-30 だとうるう年等のチェックができない。
              if(yyyymmdd.length===3){ // "/"だとうるう年等のチェックができない。
                  if(moment(yyyymmdd[0]+"-"+yyyymmdd[1]+"-"+yyyymmdd[2]).isValid()){
                      linedata[`${field}_gridmessage`] = "ok"
                  }else{
                      linedata[`${field}_gridmessage`] = "not date "
                  }
              }else{
                    linedata[`${field}_gridmessage`] = "not date type yyyy/mm/dd or yyyy-mm-dd"
               }
              }
        break     
      default:
        switch(field){
            case "screen_rowlist":
                if(linedata[`${field}_gridmessage`]===""){linedata[`${field}_gridmessage`] = "ok"}
                linedata[field].split(",").map((rowcnt)=>{
                    if(isNaN(rowcnt)){ linedata[`${field}_gridmessage`] = " must be xxx,yyy,zzz :xxx-->numeric"}
                    return linedata
                })
              break
            case "screenfield_indisp":  //tipが機能しない。
                if(/_code/.test(linedata["pobject_code_sfd"])&linedata["screenfield_editable"]!=="0")
                    {if(linedata["screenfield_indisp"]!=="1"){linedata["screenfield_indisp_gridmessage"] = " must be Required"}}
              break
            default:
                    linedata[`${field}_gridmessage`] = "ok"
       }
      }    
  }else{
        linedata[`${field}_gridmessage`] = ` field:${field} not exists in yupschema. please creat 'yupschema' by yup button `
  }    
  return linedata    
}

//未実施　yupでは数値項目で　"スペース999" がエラーにならない。

// yupでは　2019/12/32等がエラーにならない。　2020/01/01になってしまう
export function dataCheck7(schema,updateRow){ 
  let confirm_gridmessage = "done"
  Object.keys(updateRow).map((field)=>{
    switch(schema.fields[field]["_type"]){
      case "date" :
          let moment = require('moment');
          let yyyymmdd = updateRow[field].split(/-|\//)
          if(yyyymmdd[1] === undefined){updateRow[`${field}_gridmessage`] = "not date type yyyy/mm/dd or yyyy-mm-dd"
                                        confirm_gridmessage =  updateRow[`${field}_gridmessage`] + confirm_gridmessage}
          else{
              if(yyyymmdd[1].length===1){yyyymmdd[1] = "0"+yyyymmdd[1]}
              if(yyyymmdd[2] === undefined ){yyyymmdd[2] = "01"
                                            updateRow[field] = yyyymmdd[0]+"-"+yyyymmdd[1]+"-"+yyyymmdd[2]}
              //if(/(\d){4}\/|-\d+\d+\/|-\d+\d+/.test(updateRow[field])){ // "/"や2019-2-30 だとうるう年等のチェックができない。
              if(yyyymmdd.length===3){ // "/"だとうるう年等のチェックができない。
                  if(moment(yyyymmdd[0]+"-"+yyyymmdd[1]+"-"+yyyymmdd[2]).isValid()){
                    updateRow[`${field}_gridmessage`] = "ok"
                  }else{
                    updateRow[`${field}_gridmessage`] = "not date "
                    confirm_gridmessage =  updateRow[`${field}_gridmessage`] + confirm_gridmessage
                  }
              }else{
                    updateRow[`${field}_gridmessage`] = "not date type yyyy/mm/dd or yyyy-mm-dd"
                    confirm_gridmessage =  updateRow[`${field}_gridmessage`] + confirm_gridmessage
               }
              }
        break     
      default:
        switch(field){
            case "screen_rowlist":
                if(updateRow[`${field}_gridmessage`]===""){updateRow[`${field}_gridmessage`] = "ok"}
                    updateRow[field].split(",").map((rowcnt)=>{
                    if(isNaN(rowcnt)){ 
                        updateRow[`${field}_gridmessage`] = " must be xxx,yyy,zzz :xxx-->numeric"
                        confirm_gridmessage =  updateRow[`${field}_gridmessage`] + confirm_gridmessage
                      }
                    return updateRow
                })
              break
            case "screenfield_indisp":  //tipが機能しない。
                if(/_code/.test(updateRow["pobject_code_sfd"])&updateRow["screenfield_editable"]!=="0")
                    {if(updateRow["screenfield_indisp"]!=="1")
                            {updateRow["screenfield_indisp_gridmessage"] = " must be Required"}
                            confirm_gridmessage =  updateRow[`${field}_gridmessage`] + confirm_gridmessage
                          }
                break
            default:
                updateRow[`${field}_gridmessage`] = "ok"
       }
      }   
      return  updateRow  
  })
  
  updateRow["confirm_gridmessage"] = confirm_gridmessage
  return updateRow   
}   

