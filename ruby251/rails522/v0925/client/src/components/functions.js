
export function  contentEditablefunc (cellInfo){
    let response ={}
    let type = null
      if(cellInfo.row.screenfield_type){type = cellInfo.row.screenfield_type}
        else{
            if(cellInfo.row.fieldcode_ftype){type = cellInfo.row.fieldcode_ftype}
                else{ response["type"] = true 
                      response["val"] = { __html: cellInfo.value}}}
    
    if(type){ 
        switch (cellInfo.column.id) {
        case "fieldcode_dataprecision":
            switch (type) {
                case "numeric": response["type"] = true;
                                 response["val"] = { __html: cellInfo.value};
                                 break;
                case "varchar":  response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.fieldcode_dataprecision = 0
                                     break;
                case "char": response["type"] = false;
                                 response["val"] =  { __html: "0"};
                                 cellInfo.row.fieldcode_dataprecision = 0
                                 break;
                case "date": response["type"] = false;
                             response["val"] =  { __html: "0"};
                             cellInfo.row.fieldcode_dataprecision = 0
                             break;
                case "timestamp(6)": response["type"] = false;
                                         response["val"] =  { __html: "0"};
                                         cellInfo.row.fieldcode_dataprecision = 0
                                         break;
                default:  response["type"] = true  ; 
                             response["val"] = { __html: cellInfo.value};
            }      
            break;      
        case "screenfield_dataprecision":
            switch (type) {
                case "numeric": response["type"] = true;
                                 response["val"] = { __html: cellInfo.value};
                                 break;
                case "varchar": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.screenfield_dataprecision = 0
                                     break;
                case "char": response["type"] = false;
                                 response["val"] =  { __html: "0"};
                                 cellInfo.row.screenfield_dataprecision = 0
                                 break;
                case "date": response["type"] = false;
                                 response["val"] =  { __html: "0"};
                                 cellInfo.row.screenfield_dataprecision = 0
                                 break;
                case "text": response["type"] = false;
                                 response["val"] =  { __html: "0"};
                                 cellInfo.row.screenfield_dataprecision = 0
                                 break;
                case "select": response["type"] = false;
                                 response["val"] =  { __html: "0"};
                                 cellInfo.row.screenfield_dataprecision = 0
                                 break;
                case "timestamp(6)": response["type"] = false;
                                    response["val"] =  { __html: "0"};
                                    cellInfo.row.screenfield_dataprecision = 0
                                    break;
                default:  response["type"] = true   ;
                              response["val"] = { __html: cellInfo.value};
                              break;
            }     
            break;
        case "fieldcode_datascale":
                switch (type) {
                    case "numeric": response["type"] = true;
                                     response["val"] = { __html: cellInfo.value};
                                     break;
                    case "varchar": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.fieldcode_datascale = 0
                                     break;
                    case "char": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.fieldcode_datascale = 0
                                     break;
                    case "date": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.fieldcode_datascale = 0
                                     break;
                    case "timestamp(6)": response["type"] = false;
                                    response["val"] =  { __html: "0"};
                                    cellInfo.row.fieldcode_datascale = 0
                                    break;
                    default:  response["type"] = true    ; 
                                 response["val"] = { __html: cellInfo.value};
                                 break;
                }       
                break;     
        case "screenfield_datascale":
                switch (type) {
                    case "numeric": response["type"] = true;
                                     response["val"] = { __html: cellInfo.value};
                                     break;
                    case "varchar": response["type"] = false;
                                         response["val"] =  { __html: "0"};
                                         cellInfo.row.screenfield_datascale = 0
                                         break;
                    case "char": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.screenfield_datascale = 0
                                     break;
                    case "date": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.screenfield_datascale = 0
                                     break;
                    case "text": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.screenfield_datascale = 0
                                     break;
                    case "select": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.screenfield_datascale = 0
                                     break;
                    case "timestamp(6)": response["type"] = false;
                                         response["val"] =  { __html: "0"};
                                         cellInfo.row.screenfield_datascale = 0
                                         break;
                    default:  response["type"] = true   ; 
                                  response["val"] = { __html: cellInfo.value};
                                  break;
                }   
                break;  
        case "fieldcode_fieldlength":
                switch (type) {
                    case "numeric": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.fieldcode_fieldlength = 0
                                     break;
                    case "varchar": response["type"] = true;
                                     response["val"] = { __html: cellInfo.value};
                                     break;
                    case "char": response["type"] = true;
                                     response["val"] = { __html: cellInfo.value};
                                     break;
                    case "date": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.fieldcode_fieldlength = 0
                                     break;
                    case "timestamp(6)": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.fieldcode_fieldlength = 0
                                     break;
                    default:  response["type"] = true  ;  
                               response["val"] = { __html: cellInfo.value};
                               break;
                }  
                break; 
        case "screenfield_edoptmaxlength":
                switch (type) {
                    case "numeric": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.screenfield_edoptmaxlength = 0
                                     break;
                    case "varchar": response["type"] = true;
                                     response["val"] = { __html: cellInfo.value};
                                     break;
                    case "text": response["type"] = true;
                                     response["val"] = { __html: cellInfo.value};
                                     break;
                    case "select": response["type"] = false;
                                     response["val"] =  { __html: "0"};
                                     cellInfo.row.screenfield_edoptmaxlength = 0
                                     break;
                    case "char": response["type"] = true;
                                     response["val"] = { __html: cellInfo.value};
                                     break;
                    case "date": response["type"] = false;
                                    response["val"] =  { __html: "0"};
                                    cellInfo.row.screenfield_edoptmaxlength = 0
                                    break;
                    case "timestamp(6)": response["type"] = false;
                                    response["val"] =  { __html: "0"};
                                    cellInfo.row.screenfield_edoptmaxlength = 0
                                    break;
                    default:  response["type"] = true   
                                response["val"] =  { __html: "0"};
                                cellInfo.row.screenfield_edoptmaxlength = 0
                    break;
                }   
                break;
        default:  response["type"] = true  ;
                     response["val"] = { __html: cellInfo.value};
                     break;
        }
    }
    return response    
}
