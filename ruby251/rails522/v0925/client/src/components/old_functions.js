
export function  contentEditablefuncchk (cellInfo){
    let type
      if(cellInfo.row.screenfield_type){type = cellInfo.row.screenfield_type}
        else{
            if(cellInfo.row.fieldcode_ftype){type = cellInfo.row.fieldcode_ftype}
                else{return true}}
              
    switch (cellInfo.column.id) {
        case "fieldcode_dataprecision":
            switch (type) {
                case "nemeric":return true;
                case "varchar":return false;
                case "char":return false;
                case "date":return false;
                case "timestamp(6)":return false;
                default: return true    
            }            
        case "screenfield_dataprecision":
            switch (type) {
                case "nemeric":return true;
                case "varchar":return false;
                case "char":return false;
                case "date":return false;
                case "text":return false;
                case "select":return false;
                case "timestamp(6)":return false;
                default: return true   
            }     
        case "fieldcode_datascale":
                switch (type) {
                    case "nemeric":return true;
                    case "varchar":return false;
                    case "char":return false;
                    case "date":return false;
                    case "timestamp(6)":return false;
                    default: return true    
                }            
        case "screenfield_datascale":
                switch (type) {
                    case "nemeric":return true;
                    case "varchar":return false;
                    case "char":return false;
                    case "date":return false;
                    case "text":return false;
                    case "select":return false;
                    case "timestamp(6)":return false;
                    default: return true   
                }     
        case "fieldcode_fieldlength":
                switch (type) {
                    case "nemeric":return false;
                    case "varchar":return true;
                    case "char":return true;
                    case "date":return false;
                    case "timestamp(6)":return false;
                    default: return true    
                }   
        case "screenfield_edoptmaxlength":
                switch (type) {
                    case "nemeric":return false;
                    case "varchar":return true;
                    case "text":return true;
                    case "select":return false;
                    case "char":return true;
                    case "date":return false;
                    case "timestamp(6)":return false;
                    default: return true    
                }   
        default: return true    
    }
}


export  function contentEditablefuncval (cellInfo){
    let type
    if(cellInfo.row.screenfield_type){type = cellInfo.row.screenfield_type}
      else{
          if(cellInfo.row.fieldcode_ftype){type = cellInfo.row.fieldcode_ftype}
              else{return  { __html: cellInfo.value}   }}
              
    switch (cellInfo.column.id) {
        case "fieldcode_dataprecision":
            switch (type) {
                case "nemeric": return{ __html: cellInfo.value};
                case "varchar":return { __html: "0"};
                case "char": return{ __html: "0"};
                case "date":return { __html: "0"};
                case "timestamp(6)": return{ __html: "0"};
                default: return { __html: cellInfo.value}    
            }            
        case "screenfield_dataprecision":
            switch (type) {
                case "nemeric":return { __html: cellInfo.value};
                case "varchar": return{ __html: "0"};
                case "char":return { __html: "0"};
                case "date": return{ __html: "0"};
                case "text":return { __html: "0"};
                case "select":return { __html: "0"};
                case "timestamp(6)": return{ __html: "0"};
                default: return { __html: cellInfo.value}   
            }     
        case "fieldcode_datascale":
                switch (type) {
                    case "nemeric": return{ __html: cellInfo.value};
                    case "varchar": return{ __html: "0"};
                    case "char":return { __html: "0"};
                    case "date":return { __html: "0"};
                    case "timestamp(6)":return { __html: "0"};
                    default:  return{ __html: cellInfo.value}    
                }            
        case "screenfield_datascale":
                switch (type) {
                    case "nemeric":return { __html: cellInfo.value};
                    case "varchar": return{ __html: "0"};
                    case "char":return { __html: "0"};
                    case "date":return { __html: "0"};
                    case "text":return { __html: "0"};
                    case "select":return { __html: "0"};
                    case "timestamp(6)": return{ __html: "0"};
                    default: return { __html: cellInfo.value}   
                }     
        case "fieldcode_fieldlength":
                switch (type) {
                    case "nemeric":return { __html: "0"};
                    case "varchar": return{ __html: cellInfo.value};
                    case "char": return{ __html: cellInfo.value};
                    case "date":return { __html: "0"};
                    case "timestamp(6)": return{ __html: "0"};
                    default: return { __html: cellInfo.value}    
                }   
        case "screenfield_edoptmaxlength":
                switch (type) {
                    case "nemeric":return { __html: "0"};
                    case "varchar":return { __html: cellInfo.value};
                    case "text":return { __html: cellInfo.value};
                    case "select": return{ __html: "0"};
                    case "char": return{ __html: cellInfo.value};
                    case "date": return{ __html: "0"};
                    case "timestamp(6)": return{ __html: "0"};
                    default: return { __html: cellInfo.value}    
                }   
        default: return { __html: cellInfo.value}    
    }
}

