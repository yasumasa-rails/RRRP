import moment from 'moment'
//yupでできなかったこと
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
        case /_duedate/.test(id):
                starttime = id.split("_")[0] + "_starttime" 
                rLineData[starttime] = moment(linedata[id]).add(- linedata["opeitm_duration"],'d').format() 
                rLineData[`${starttime}_gridmessage`] = "in"
                toduedate = id.split("_")[0] + "_toduedate" 
                rLineData[toduedate] = linedata[id]
                rLineData[`${toduedate}_gridmessage`] = "in"
            break
        case /loca_code_supplier/.test(id):
                rLineData["loca_code"] = linedata[id]
                rLineData["loca_code_gridmessage"] = "in"
        //        linedata["crr_code_pur"] = linedata["crr_code_supplier"] 
            break
        case /_qty$/.test(id):
                qty_case = id.split("_")[0] + "_qty_case" 
                    if(linedata["opeitm_packqty"]==="0"){
                        rLineData[qty_case] = linedata[id] 
                    }else{
                        let qtyCase = Math.ceil(linedata[id]/linedata["opeitm_packqty"])*linedata["opeitm_packqty"]
                        rLineData[qty_case] = qtyCase }
                        rLineData["crr_code_pur"] = linedata["crr_code_supplier"] 
                        rLineData["crr_code_pur_gridmessage"] = "in" 
            break
        case /itm_code$/.test(id):
            if(/schs$|ords$/.test(screenCode)){
                if(linedata["opeitm_processseq"]===""){rLineData["opeitm_processseq"] = "999"}
                if(linedata["opeitm_priority"]===""){
                    rLineData["opeitm_priority"] = "999"
                    rLineData["opeitm_priority_gridmessage"] = "in"
                }
            }
            break
        default:
             sw = false
             break    
        }
        rval = {"linedata":rLineData,"sw":sw}   
    return rval
}