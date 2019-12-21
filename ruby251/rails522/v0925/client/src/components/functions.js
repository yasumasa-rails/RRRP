//yupでできなかったこと
export function  contentEditablefunc (cellInfo){
    let response ={}
    let type = null
    if(cellInfo.row.screenfield_type){type = cellInfo.row.screenfield_type}
    else{
        if(cellInfo.row.fieldcode_ftype){type = cellInfo.row.fieldcode_ftype}
        else{response["type"] = true 　//  response["type"] = true 　画面からの修正可能
                      response["val"] = { __html: cellInfo.value}}}
//ダイナミックに入力・可・不可    
    if(type){ //type 入力の可否
        switch (cellInfo.column.id) {
        case "fieldcode_dataprecision":
            switch (type) {
                case "numeric": response["type"] = true;
                                 response["val"] = { __html: cellInfo.value};
                                 break;
                case "varchar":  response["type"] = false;　　//  response["type"] = true 　画面からの修正不可
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
 
    //規定値       yupで対応できず   
    if(cellInfo.styles.textAlign === "right"){  // 数字判断
        //if(/_priority/.test(cellInfo.column.id)||/_processseq/.test(cellInfo.column.id)){
        //    response["val"] = { __html: cellInfo.value?cellInfo.value:999};
        //    cellInfo.row[cellInfo.column.id] =  cellInfo.value.isInteger?cellInfo.value:999
        //}else{
            response["val"] = { __html: cellInfo.value?cellInfo.value:0};
            //cellInfo.row[cellInfo.column.id] =  isNaN(cellInfo.value)?cellInfo.value:0
       // }
    }   
    let today = new Date();
    switch( true ){ //初期値
        case /_expiredate/.test(cellInfo.column.id):
                response["type"] = true;
                response["val"] = { __html: cellInfo.value?cellInfo.value:"2099-12-31"};
                cellInfo.row[cellInfo.column.id] = cellInfo.value?cellInfo.value.length>3?cellInfo.value:"2099-12-31":"2099-12-31"
            break
        case /_isudate/.test(cellInfo.column.id):   
                response["val"] = { __html: cellInfo.value?cellInfo.value:today.getFullYear() + "-" + (today.getMonth() + 1) + "-" +  today.getDate()};
                cellInfo.row[cellInfo.column.id] = cellInfo.value?cellInfo.value:today.getFullYear() + "-" + (today.getMonth() + 1) + "-" +  today.getDate();
            break
        case /pobject_objecttype_tbl/.test(cellInfo.column.id):
                    response["val"] = { __html: cellInfo.value?cellInfo.value:"tbl"};
                    cellInfo.row[cellInfo.column.id] = cellInfo.value?cellInfo.value:"tbl";
            break
        default: break    
        }
    return response    
}