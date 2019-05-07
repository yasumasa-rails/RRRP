import React from 'react';
import {connect} from 'react-redux'
import Button from '@material-ui/core/Button'
import { withFormik, Form, Field, } from 'formik'
import {UploadListRequest} from '../../actions'
import Detail from './detail'


const formikForm = ({isSubmitting, values,status,handleSubmit}) => (
  <div className="columns">
  <Form {...values} onSubmit={handleSubmit}>
    {values.uploadlists&&
      values.uploadlists.map(upload =>
        <Detail
          key={upload.id}
          upload={upload}
        />
      )
    }
    <p>email:
    <Field type="email" name="email"  />
    </p>
    <p>count:
    <Field type="number" name="count" />
    </p>
    <Button type="submit" disabled={isSubmitting}>
    Submit
    </Button>
    </Form>
  </div>
)

const formikEnhancer = withFormik({
  mapPropsToValues : (props) =>({
    email:props.upload.values?props.upload.values.email:props.login.auth.uid ,
    count:props.upload.values?props.upload.values.count:10,
    uploadlists:props.upload.uploadlists?props.upload.uploadlists:[],}),
    mapPropsToStatus : (props) =>({
      uid:props.login.auth.uid ,}),
  handleSubmit : (values,{props}) =>{let auth = props.login.auth
                                      values["token"] = auth["access-token"]
                                      values["client"] = auth.client
                                      values["uid"] = auth.uid
                                      props.dispatch(UploadListRequest(values))}, 
})(formikForm)



const  mapStateToProps = (state,ownProps) =>({
  login:state.login ,
  upload:state.upload,
})

//const mapDispatchToProps = (dispatch,ownProps ) => ({
//  onSubmit:(values)=> dispatch(UploadListRequest(values))      
//    })    

 const NonEditableUpload =  connect(mapStateToProps,null)(formikEnhancer)

export default NonEditableUpload