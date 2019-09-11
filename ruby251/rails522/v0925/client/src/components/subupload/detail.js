import React from 'react';
import { connect } from 'react-redux'
import PropTypes from 'prop-types';
import {Button} from '../../styles/button'
import {ChangeUploadTitleRequest} from '../../actions'

const Detail = ( {upload,changeUploadTitle} ) => {
  let excelSrc = (upload[0].excel !== null ?
    upload[0].excel.url : "https://bulma.io/images/placeholders/128x96.png");

  return (
    <React.Fragment>
      <div className="card-image">
        <figure className="image is-5by4">
          <img src={excelSrc} alt="Upload excel" />
        </figure>
      </div>
      <table>
      <tr>
        <td>id</td><td>fiel name</td><td>title</td><td>contents</td><td>result</td><td>updated</td>
      </tr>
      {upload.map((up ,key)=>
      <tr key={key} >
        <td className="card-content">{up.id}</td>
        <td > {up.excel&&up.excel.name}</td>
        <td className="title is-4"> {up.title}</td>
          <td> {up.contents}</td>
          <td> {up.result}</td>
          <td><time>{up.updated_at.toLocaleString()}</time></td> 
         <td><Button  
            type="button"
            onClick ={() => changeUploadTitle(up)}>
              update
          </Button>  </td> 
      </tr>    
      )}
     </table>
    </React.Fragment>
  )
}

Detail.propTypes = PropTypes.array[{
  upload: PropTypes.shape({
    id: PropTypes.integer,
    excel: PropTypes.shape({url: PropTypes.string}),
    title: PropTypes.string,
    contents: PropTypes.string,
    remark: PropTypes.string,
    updated_at: PropTypes.string
  }).isRequired
}];


const  mapStateToProps = (state,ownProps) =>({
  token:(state.login.auth?state.login.auth["access-token"]:"") ,
  client:(state.login.auth?state.login.auth.client:""),
  uid:(state.login.auth?state.login.auth.uid:"") ,
  upload:state.upload.uploadlists,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
        changeUploadTitle : (upload) =>{
                    dispatch(ChangeUploadTitleRequest(upload))}    
    })    

 

export default connect(mapStateToProps,mapDispatchToProps)(Detail)