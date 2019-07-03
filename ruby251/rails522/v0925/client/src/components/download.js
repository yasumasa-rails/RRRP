// joemusacchia/ReactCarrierwaveImageUploadBlogPost.md

import React from 'react'
import { connect } from 'react-redux'
import {DownloadRequest} from '../actions'

const Download = ({uid,token,client,screenCode,screenName,readFile}) => (
    <div>
       export Table {screenName}
      <input type='file' onClick={(files)=>readFile(files,uid,token,client,screenCode)}/>
    </div>
  )


const  mapStateToProps = (state) => ({
              uid:state.login.auth?state.login.auth.uid:"",
              token:state.login.auth?state.login.auth["access-token"]:"",
              client:state.login.auth?state.login.auth.client:"",
              screenCode:state.screen.params.screenCode,
              screenName:state.screen.params.screenName,
    
  })
       
  const mapDispatchToProps = (dispatch,ownProps ) => ({
      readFile: (files,uid,token,client,screenCode) =>{
                if(files && files[0]){
                    let formPayLoad = new FormData();
                    formPayLoad.append('downloaded_image', files[0]);
                    dispatch(DownloadRequest(formPayLoad,uid,token,client,screenCode))
                  }}
    } )

export default  connect(mapStateToProps,mapDispatchToProps)(Download)