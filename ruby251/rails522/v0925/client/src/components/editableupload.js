import React from 'react'
import {connect} from 'react-redux'
import ActiveStorageProvider from 'react-activestorage-provider'

const EditableUpload = ({token,client,uid,message,}) =>{
    return( 
    <React.Fragment>
           <div className="form-group">
            <p>excelデータの upload (titleとコメントを付加)</p>
            <ActiveStorageProvider
              endpoint={{
                          path: 'http://localhost:3001/api/uploads',
                          model: 'Upload',
                          attribute: 'excel',
                          method: 'POST',
                          host: 'localhost',
                          port: '9292',
                          }}
              headers={{"access-token":token,client:client,uid:uid}}     
              render={({ uploads, ready,handleUpload }) => (
                <div>
                  <input
                    type="file"
                    disabled={!ready}
                    onChange={ev =>handleUpload(ev.currentTarget.files)}
                  />

                {uploads.map(file => {
                  switch (file.state) {
                    case 'waiting':
                      return <p key={file.id}>Waiting to upload {file.file.name}</p>
                    case 'uploading':
                      return ( <p key={file.id}>
                                Uploading {file.file.name}: {file.progress}%
                              </p>
                      )
                    case 'error':
                      return (
                        <p key={file.id}>
                          Error uploading {file.file.name}: {file.error}
                        </p>
                      )   
                    case 'finished':
                      return (
                        <p key={file.id}>Finished uploading {file.file.name}</p>
                      )
                    default:
                      return (<p>.....</p>)    
                  }     
                })}
                </div>  
              )}
            />
          </div>  
          {message}
       
      </React.Fragment>
    )};

    

const mapStateToProps = (state,ownProps)  =>({  
  login:state.login ,
  isAuthenticated:state.login.isAuthenticated ,
  token:(state.login.auth?state.login.auth["access-token"]:"") ,
  client:(state.login.auth?state.login.auth.client:""),
  uid:(state.login.auth?state.login.auth.uid:"") ,
  upload:state.upload,
})

export  default   connect(mapStateToProps,null)(EditableUpload)