import React from 'react';
import { connect } from 'react-redux'
import ReactTable from 'react-table'
import "react-table/react-table.css"
import {ScreenRequest} from '../actions'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.

class ScreenGrid extends React.Component {

  render() {
    const {match,columns,uid,token,client,state} = this.props
    const id = match?match.params.id:null
    return(
      <div>
      <ReactTable
        columns={columns?columns:[]} 
        data={state.data?state.data:[]} // should default to []
        pages={state.pages?state.pageInfo.pages:-1} // should default to -1 (which means we don't know how many pages we have)
        manual // informs React Table that you'll be handling sorting and pagination server-side
        onFetchData={(state, instance) => {
          let  params= {  page: state.page,  pageSize: state.pageSize,
                        sorted: state.sorted,  filtered: state.filtered,      
                        id:id}   
                        this.props.dispatch(ScreenRequest(params,
                             token,client,uid,) ) 
        }}
       />
        </div>
       )
    }
  }
function mapStateToProps(state) {
  return {  columns:state.screen.columns,
            uid:state.login.auth?state.login.auth.uid:"",
            token:state.login.auth?state.login.auth["access-token"]:"",
            client:state.login.auth?state.login.auth.client:"",
            state:state.screen,
            match:state.match
            }
}


export default connect(mapStateToProps)(ScreenGrid)
