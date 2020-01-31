import React from 'react'
import {connect} from 'react-redux'
import ActiveStorageProvider from 'react-activestorage-provider'
import {SetResultsRequest} from '../actions'

const EditableUpload = ({setResults,token,client,uid,message,}) =>{
//const body = JSON.stringify({ POST: { title:screenCode}})
  let filename 
    return( 
    <React.Fragment>
           <div className="form-group">
            <ActiveStorageProvider
              endpoint={{
                          path: 'http://localhost:3001/api/uploads',
                          model: 'Upload',
                          attribute: 'excel',
                          method: 'post',
                          host: 'localhost',
                          port: '9292',
                          }}
              headers={{"access-token":token,client:client,uid:uid}}
              onSubmit={e =>setResults(e)}
              render={({ uploads, ready,handleUpload }) => (
                <div>
                <input
                        type="file" id="inputJson" 
                        /* disabled={!ready} */
                        placeholder="Json File"  disabled={ready?false:true}
                        onChange={ev => {filename =  ev.currentTarget.files[0].name
                          if(filename.search(/\.json$|\.JSON$/)>1)
                              {handleUpload(ev.currentTarget.files)
                              }
                          else{alert("please input JSON File")
                              }
                        }}
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
  screenCode:state.screen.params?state.screen.params.screenCode:"",
})


const mapDispatchToProps = dispatch => ({
   setResults: (e)=>{
    dispatch(SetResultsRequest(e))
    }, 
  })
  

export  default   connect(mapStateToProps,mapDispatchToProps)(EditableUpload)