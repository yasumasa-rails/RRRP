// joemusacchia/ReactCarrierwaveImageUploadBlogPost.md
//Upload images with React and the carrierwave Ruby gem for Rails 5
//https://medium.com/@ebenwoodward/linking-a-react-app-to-rails-active-storage-d414afa4bc7f


import React from 'react'
import { connect } from 'react-redux'
import {UploadRequest} from '../actions'

const Upload = (uid,token,client,screenCode,screenName,readFile) => {
  return(
    <div>
       import Table {screenName}
      <input type='file' onClick={(files)=>readFile(files,uid,token,client,screenCode)}/>
    </div>
  )
}

const  mapStateToProps = (state) => ({
              uid:state.login.auth?state.login.auth.uid:"",
              token:state.login.auth?state.login.auth["access-token"]:"",
              client:state.login.auth?state.login.auth.client:"",
              screenCode:state.screen.screenCode,
              screenName:state.screen.screenName,
              
  })
     
  
  const mapDispatchToProps = (dispatch,ownProps ) => ({
      readFile: (files,uid,token,client,screenCode) =>{
                  if(files && files[0]){
                    let formPayLoad = new FormData();
                    formPayLoad.append('uploaded_image', files[0]);
                    dispatch(UploadRequest(formPayLoad,uid,token,client,screenCode))
                  }}
    })

export default  connect(mapStateToProps,mapDispatchToProps)(Upload)