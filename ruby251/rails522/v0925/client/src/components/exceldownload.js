import React from "react";
import ReactExport from "react-data-export";

const ExcelFile = ReactExport.ExcelFile;
const ExcelSheet = ReactExport.ExcelFile.ExcelSheet;
const ExcelColumn = ReactExport.ExcelFile.ExcelColumn;


export const  ExcelDownload = ({results,filename,})=>{
    let dataSet = []
    let fields = {}
    results.map((rec,idx)=>{
        if(idx===0){fields = rec
                        return fields}
        else{dataSet.push(rec)
              return dataSet}
    }
    )
    return (
        <ExcelFile filename={filename}>
            <ExcelSheet data={dataSet} name="result">
                {Object.keys(fields).map((field,idx)=>{
                   return <ExcelColumn label={fields[field]} value={field} key={idx}/>}
                 )}
            </ExcelSheet>
        </ExcelFile>
        );
}
