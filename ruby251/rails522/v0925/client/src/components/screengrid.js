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
  
    const {screenCode,pageSize,uid,token,client,state} = this.props
    return(
      <div>
      {screenCode?  
      <ReactTable
      columns={state.columns?state.columns:[]} 
      data={state.data?state.data:[]} // should default to [] / 
      pages={state.pages?state.pages:0}
      pageSize={state.pageSize}
      
        manual // informs React Table that you'll be handling sorting and pagination server-side
        onFetchData={(state, instance) => {
          let  params= {  page: state.page,  
                        pageSize :state.pageSize?state.pageSize:pageSize,
                        sorted: state.sorted,  filtered: state.filtered,      
                        screenCode:screenCode,uid:uid}   
                        this.props.dispatch(ScreenRequest(params,
                             token,client,uid,) )                  
        }}
      className="-striped -highlight" 
       style={{
        height: "800px" // This will force the table body to overflow and scroll, since there is not enough room
      }}
       /> 
        :"please select"}
        </div>
       )
    }
  }
function mapStateToProps(state) {
  return {  uid:state.login.auth?state.login.auth.uid:"",
            token:state.login.auth?state.login.auth["access-token"]:"",
            client:state.login.auth?state.login.auth.client:"",
            screenCode:state.screen.screenCode,
            pageSize:state.screen.pageSize,
            state:state.screen
            }
}

export default connect(mapStateToProps)(ScreenGrid)
