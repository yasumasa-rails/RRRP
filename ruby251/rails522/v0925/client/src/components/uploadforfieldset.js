import React from 'react'
import {connect} from 'react-redux'
import {uploadForFieldSetRequest} from '../actions'

const UploadForFieldSet = ({ handleUpload,screenCode}) =>{
    return(
        <div>
            <form id='UploadForm' name='UploadForm'>
            <input
                type="file" id="excel" name="excel" 
                /* disabled={!ready} */
                placeholder="json file input"
                onChange={ev =>{let jsonfilename =  ev.currentTarget.files[0]
                                if(jsonfilename.name.search(/\.json$/)>1)
                                    {   let uploadForm = document.getElementById('UploadForm')
                                        let formData = new FormData()
                                        formData.append("upload", {uploadForm})
                                        handleUpload(formData,screenCode)}
                                else{alert("please input Json File")
                                    }
                              }}
         />
        </form> 
        </div>)
}  

const mapStateToProps = (state,ownProps)  =>({  
  screenCode:state.screen.params?state.screen.params.screenCode:"",
})


const mapDispatchToProps = dispatch => ({
    handleUpload: (formData,screenCode)=>{
    dispatch(uploadForFieldSetRequest(formData,screenCode))
    }, 
  })
  

export  default   connect(mapStateToProps,mapDispatchToProps)(UploadForFieldSet)