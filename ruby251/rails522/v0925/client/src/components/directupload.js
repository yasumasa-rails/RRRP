/*
import React from 'react'
import {connect} from 'react-redux'
import {uploadForFieldSetRequest} from '../actions'

const DirectUpload = ({ newFileName,handleUpload,screenCode,jsonURL,data}) =>{
    
    let uinput = (newFileName,data,jsonURL) =>{
            if(newFileName){
                let formData = new FormData(document.getElementById('directupload'))
                formData.append("excel", data)
                const inputElement = document.createElement('input')
                inputElement.name = 'jsonfile'
                inputElement.type = 'file'
                inputElement.accept = 'application/json' 
                //inputElement.file = fetch(jsonURL).then(r => r)
                //inputElement.value = newFileName
                //let inputfile = document.querySelector("input[type='file'][name='jsonfile']")
                inputElement.onchange = handleUpload(newFileName,formData,screenCode,jsonURL,inputElement)
                console.log('aa')
            }
    }    
    return(
        <div>
            <form  id="directupload">
                {uinput(newFileName,data,jsonURL)}
            </form>
        </div>)
}  

const mapStateToProps = (state,ownProps)  =>({  
  newFileName:state.upload.newFileName,
  jsonURL:state.upload.jsonURL,
  data:state.upload.data,
  screenCode:state.screen.params?state.screen.params.screenCode:"",
})


const mapDispatchToProps = dispatch => ({
    handleUpload: (newFileName,formData,screenCode,jsonURL,inputElement)=>{
    dispatch(uploadForFieldSetRequest(newFileName,formData,screenCode,jsonURL,inputElement))
    }, 
  })
  

export  default   connect(mapStateToProps,mapDispatchToProps)(DirectUpload)
*/