import moment from 'moment'
//yupでできなかったこと
//検索項目では　xxxx_gridmessage = in は意味がない。　検索結果がセットされるため。
// 項目の順番が制限される。
export function  onBlurFunc(screenCode,linedata,id){
    let starttime
    //let loca_code
    //let crr_code_pur
    let toduedate
    let qty_case
    let rLineData = Object.create(linedata)
    let sw = true
    let rval = {}
    switch( true ){
        case /itm_code$/.test(id):
            if(/schs$|ords$/.test(screenCode)){
                if(linedata["opeitm_processseq"]===""){
                    rLineData["opeitm_processseq"] = "999"
                    rLineData["opeitm_processseq_gridmessage"] = "in"
                }
                if(linedata["opeitm_priority"]===""){
                    rLineData["opeitm_priority"] = "999"
                    rLineData["opeitm_priority_gridmessage"] = "in"
                }
            }
            break
        case /_duedate/.test(id):
                starttime = id.split("_")[0] + "_starttime" 
                if(linedata[starttime]===""){
                    if(/cust/.test(screenCode)){ //受注の時はopeitmのLT(duration)は使用できない。
                        rLineData[starttime] = moment(linedata[id]).add(- "1",'d').format() 
                    }
                    else{
                        rLineData[starttime] = moment(linedata[id]).add(- linedata["opeitm_duration"],'d').format() 
                    }       
                    rLineData[`${starttime}_gridmessage`] = "in"
                }
                toduedate = id.split("_")[0] + "_toduedate" 
                if(linedata[toduedate]===""){
                        rLineData[toduedate] = linedata[id]
                        rLineData[`${toduedate}_gridmessage`] = "in"
                }
                if(/purords$/.test(screenCode)){
                    if(linedata["opeitm_priority"] === "999")
                            {
                                rLineData["loca_code_supplier"] = linedata["loca_code"]  //linedata["loca_code"] -->opeitmsのlocas_id
                                rLineData["shelfno_code_to"] = linedata["shelfno_code"]
                                rLineData["loca_code_supplier_gridmessage"] = "in"
                                rLineData["shelfno_code_to_gridmessage"] = "in"
                     }
                 }
                 if(/prdords$/.test(screenCode)){
                     if(linedata["opeitm_priority"] === "999")
                             {
                                 rLineData["loca_code_workplace"] = linedata["loca_code"]   //linedata["loca_code"] -->opeitmsのlocas_id
                                 rLineData["shelfno_code_to"] = linedata["shelfno_code"]
                                 rLineData["loca_code_workplace_gridmessage"] = "in"
                                 rLineData["shelfno_code_to_gridmessage"] = "in"
                      }
                  }
                if(/custords$/.test(screenCode)){  //custrordsでは棚まで指定しない。
                         if(linedata["loca_code_fm"]===""){
                             rLineData["loca_code_fm"] = linedata["loca_code_shelfno"]
                             rLineData["custord_loca_id_fm"] = linedata["shelfno_loca_id_shelfno"]
                             rLineData["loca_code_fm_gridmessage"] = "in"
                         }
                     }
            break
        /*case /loca_code_supplier/.test(id):
                rLineData["loca_code"] = linedata[id]
            break */
        case /_qty$/.test(id):
            switch( true ){
            case /_pur/.test(screenCode):
                qty_case = id.split("_")[0] + "_qty_case" 
                    if(Number(linedata["opeitm_packqty"])===0){  //opeitm_packqtyは購入時・作成後の完成時の単位
                        rLineData[qty_case] = linedata[id] 
                    }else{
                        rLineData[id]  = String(Math.ceil(linedata[id]/linedata["opeitm_packqty"])*linedata["opeitm_packqty"])
                        rLineData[qty_case] =  String(Math.ceil(linedata[id]/linedata["opeitm_packqty"]))}
                //
                if( rLineData["crr_code_pur"] ){}
                else{        
                    rLineData["crr_code_pur"] = linedata["crr_code_supplier"] 
                    rLineData["crr_code_pur_gridmessage"] = "in"}
                break 
            case /_prd/.test(screenCode):
                qty_case = id.split("_")[0] + "_qty_case" 
                    if(Number(linedata["opeitm_packqty"])===0){  //opeitm_packqtyは購入時・作成後の完成時の単位
                        rLineData[qty_case] = linedata[id] 
                    }else{
                        rLineData[id]  = String(Math.ceil(linedata[id]/linedata["opeitm_packqty"])*linedata["opeitm_packqty"])
                        rLineData[qty_case] =  String(Math.ceil(linedata[id]/linedata["opeitm_packqty"]))}
                break 
            default:
                sw = false
                 break    
            }        
            break
        default:
             sw = false
             break    
        }
        rval = {"linedata":rLineData,"sw":sw}   
    return rval
}

export function  onBlurFunc7(screenCode,lineData,id){
    let starttime
    //let loca_code
    //let crr_code_pur
    let toduedate
    let qty_case
    switch( true ){
        case /itm_code$/.test(id):
            if(/schs$|ords$/.test(screenCode)){
                if(lineData["opeitm_processseq"]===""){
                    lineData["opeitm_processseq"] = "999"
                    lineData["opeitm_processseq_gridmessage"] = "in"
                }
                if(lineData["opeitm_priority"]===""){
                    lineData["opeitm_priority"] = "999"
                    lineData["opeitm_priority_gridmessage"] = "in"
                }
            }
            break
        case /_duedate/.test(id):
                starttime = id.split("_")[0] + "_starttime" 
                if(lineData[starttime]===""){
                    if(/cust/.test(screenCode)){ //受注の時はopeitmのLT(duration)は使用できない。
                        lineData[starttime] = moment(lineData[id]).add(- "1",'d').format() 
                    }
                    else{
                        lineData[starttime] = moment(lineData[id]).add(- lineData["opeitm_duration"],'d').format() 
                    }       
                    lineData[`${starttime}_gridmessage`] = "in"
                }
                toduedate = id.split("_")[0] + "_toduedate" 
                if(lineData[toduedate]===""){
                        lineData[toduedate] = lineData[id]
                        lineData[`${toduedate}_gridmessage`] = "in"
                }
                if(/purords$/.test(screenCode)){
                    if(lineData["opeitm_priority"] === "999")
                            {
                                lineData["loca_code_supplier"] = lineData["loca_code"]  //lineData["loca_code"] -->opeitmsのlocas_id
                                lineData["shelfno_code_to"] = lineData["shelfno_code"]
                                lineData["loca_code_supplier_gridmessage"] = "in"
                                lineData["shelfno_code_to_gridmessage"] = "in"
                     }
                 }
                 if(/prdords$/.test(screenCode)){
                     if(lineData["opeitm_priority"] === "999")
                             {
                                lineData["loca_code_workplace"] = lineData["loca_code"]   //lineData["loca_code"] -->opeitmsのlocas_id
                                lineData["shelfno_code_to"] = lineData["shelfno_code"]
                                lineData["loca_code_workplace_gridmessage"] = "in"
                                lineData["shelfno_code_to_gridmessage"] = "in"
                      }
                  }
                if(/custords$/.test(screenCode)){  //custrordsでは棚まで指定しない。
                         if(lineData["loca_code_fm"]===""){
                            lineData["loca_code_fm"] = lineData["loca_code_shelfno"]
                            lineData["custord_loca_id_fm"] = lineData["shelfno_loca_id_shelfno"]
                            lineData["loca_code_fm_gridmessage"] = "in"
                         }
                     }
            break
        /*case /loca_code_supplier/.test(id):
                lineData["loca_code"] = lineData[id]
            break */
        case /_qty$/.test(id):
            switch( true ){
            case /_pur/.test(screenCode):
                qty_case = id.split("_")[0] + "_qty_case" 
                    if(Number(lineData["opeitm_packqty"])===0){  //opeitm_packqtyは購入時・作成後の完成時の単位
                        lineData[qty_case] = lineData[id] 
                    }else{
                        lineData[id]  = String(Math.ceil(lineData[id]/lineData["opeitm_packqty"])*lineData["opeitm_packqty"])
                        lineData[qty_case] =  String(Math.ceil(lineData[id]/lineData["opeitm_packqty"]))}
                //
                if( lineData["crr_code_pur"] ){}
                else{        
                    lineData["crr_code_pur"] = lineData["crr_code_supplier"] 
                    lineData["crr_code_pur_gridmessage"] = "in"}
                break 
            case /_prd/.test(screenCode):
                qty_case = id.split("_")[0] + "_qty_case" 
                    if(Number(lineData["opeitm_packqty"])===0){  //opeitm_packqtyは購入時・作成後の完成時の単位
                        lineData[qty_case] = lineData[id] 
                    }else{
                        lineData[id]  = String(Math.ceil(lineData[id]/lineData["opeitm_packqty"])*lineData["opeitm_packqty"])
                        lineData[qty_case] =  String(Math.ceil(lineData[id]/lineData["opeitm_packqty"]))}
                break 
            default:
                lineData["confirm_gridmessage"] = false
                break    
            }        
            break
        default:
            lineData["confirm_gridmessage"] = false
             break    
        }
       
    return  lineData
}