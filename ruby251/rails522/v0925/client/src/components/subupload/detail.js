import React from 'react';
import { connect } from 'react-redux'
import PropTypes from 'prop-types';
import Button from '@material-ui/core/Button'
import {ChangeUploadTitleRequest} from '../../actions'



const Detail = ({ upload,changeUploadTitle }) => {
  let excelSrc = upload.excel !== null ?
    upload.excel.url : "https://bulma.io/images/placeholders/1280x960.png";

  return (
    <React.Fragment>
      <div className="card-image">
        <figure className="image is-5by4">
          <img src={excelSrc} alt="Upload excel" />
        </figure>
      </div>
      <div className="card-content">{upload.id}
        <p className="title is-4">{upload.title}</p>
        <div className="content">
          <p>{upload.contents}</p>
          <p>{upload.remark}</p>
          <time>{upload.updated_at.toLocaleString()}</time> 
          <Button  
            type="button"
            onClick ={() => changeUploadTitle(upload)}>
          </Button>     
        </div>
      </div>
    </React.Fragment>
  )
}

Detail.propTypes = {
  upload: PropTypes.shape({
    id: PropTypes.integer,
    excel: PropTypes.shape({url: PropTypes.string}),
    title: PropTypes.string,
    contents: PropTypes.string,
    remark: PropTypes.string,
    updated_at: PropTypes.string
  }).isRequired
};


const  mapStateToProps = (state,ownProps) =>({
  token:(state.login.auth?state.login.auth["access-token"]:"") ,
  client:(state.login.auth?state.login.auth.client:""),
  uid:(state.login.auth?state.login.auth.uid:"") ,
  upload:state.upload.upload,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
        changeUploadTitle : (upload) =>{
                    dispatch(ChangeUploadTitleRequest(upload))}    
    })    

 

export default connect(mapStateToProps,mapDispatchToProps)(Detail)