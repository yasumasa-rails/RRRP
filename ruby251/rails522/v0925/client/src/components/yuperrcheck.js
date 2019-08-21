export  function yupErrCheck (schema,field,params,data) {
  let mfield
  let linedata = data[params.index] 

  try{schema.validateSync(linedata)
    switch(field) {
    case "confirm"  :  //1行すべてのチェック})
            linedata.confirm = true
            linedata.confirm_gridmessage = "*"
            params= {...params,req:"updateGridLineData",linedata:linedata}
            data[params.index] = linedata
            break
    default:  
            mfield = field+"_gridmessage"
            linedata[mfield] = ""
            linedata.confirm_gridmessage = "ok"
            data[params.index] = linedata
        }
      }      
  catch(err){
    switch(field){
    case "confirm"  :  //1行すべてのチェック
              linedata.confirm = false
              mfield = err.path+"_gridmessage"
              linedata[mfield] = err.errors.join(",")
              linedata.confirm_gridmessage = `err ${err.path}`
              data[params.index] = linedata
              break
    default:  
              mfield = field+"_gridmessage"
              linedata[mfield] = err.errors.join(",")
              linedata.confirm_gridmessage = `err ${err.path}`
              data[params.index] = linedata
        }
  }
  return data
}  