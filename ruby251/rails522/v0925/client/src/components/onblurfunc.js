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
    let rLineData ={}
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
                                rLineData["loca_code_supplier"] = linedata["loca_code"]
                                rLineData["shelfno_code_to"] = linedata["shelfno_code"]
                                rLineData["loca_code_supplier_gridmessage"] = "in"
                                rLineData["shelfno_code_to_gridmessage"] = "in"
                     }
                 }
                 if(/prdords$/.test(screenCode)){
                     if(linedata["opeitm_priority"] === "999")
                             {
                                 rLineData["loca_code_shelfno_to"] = linedata["loca_code_shelfno"]
                                 rLineData["shelfno_code_to"] = linedata["shelfno_code"]
                                 rLineData["loca_code_supplier_gridmessage"] = "in"
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
                    if(linedata["opeitm_packqty"]==="0"){  //opeitm_packqtyは購入時・作成後の完成時の単位
                        rLineData[qty_case] = linedata[id] 
                    }else{
                        rLineData[id]  = String(Math.ceil(linedata[id]/linedata["opeitm_packqty"])*linedata["opeitm_packqty"])
                        rLineData[qty_case] =  String(Math.ceil(linedata[id]/linedata["opeitm_packqty"]))}
                //        
                rLineData["crr_code_pur"] = linedata["crr_code_supplier"] 
                rLineData["crr_code_pur_gridmessage"] = "in"
                break 
            case /_prd/.test(screenCode):
                qty_case = id.split("_")[0] + "_qty_case" 
                    if(linedata["opeitm_packqty"]==="0"){  //opeitm_packqtyは購入時・作成後の完成時の単位
                        rLineData[qty_case] = linedata[id] 
                    }else{
                        rLineData[id]  = String(Math.ceil(linedata[id]/linedata["opeitm_packqty"])*linedata["opeitm_packqty"])
                        rLineData[qty_case] =  String(Math.ceil(linedata[id]/linedata["opeitm_packqty"]))}
                break 
            default:
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