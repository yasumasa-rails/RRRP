import React from 'react';
import { connect } from 'react-redux'
import ReactTable from 'react-table'
import "react-table/react-table.css"
import {ScreenRequest,ScreenParamsSet} from '../actions'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.


class ScreenGrid extends React.Component {

  render() {
  
    const {screenCode,pageSize,columns,data,pages,view,page,sorted,filtered,
          uid,token,client,} = this.props
    
    let  params= {  page: page?page:0,  
            pageSize :pageSize?pageSize:20,
            sorted: sorted,  filtered: filtered,      
            screenCode:screenCode,uid:uid}         
   
    return(
      <div>
      {screenCode?  
      <ReactTable
      columns={columns?columns:[]} 
      pages={pages?pages:-1}  //kick onFetchData
      data={data?data:[]} // should default to [] / 
        manual // informs React Table that you'll be handling sorting and pagination server-side
        onFetchData={( subparams,instance) => {                      
                       this.props.dispatch(ScreenParamsSet(subparams))   
                        view&&this.props.dispatch(ScreenRequest(params,
                                         token,client,uid,) )                            
        }}
      className="-striped -highlight" //-striped  奇数行、偶数行色分け　 -highlight：マウスがヒットした時の色の強調
       style={{
       height: "800px" // This will force the table body to overflow and scroll, since there is not enough room
       }}

      filterable={true}

       >

{(state, makeTable, instance) => {
    return (
      <div
        style={{
          borderRadius: "5px",
          overflow: "hidden",
          padding: "5px"
        }}
      >
        {makeTable()}
      </div>
    );
  }}
        </ReactTable>
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
            columns:state.screen.columns,
            data:state.screen.data,
            pages:state.screen.pages,
            page:state.screen.page,
            pageSize:state.screen.pageSize,
            view:state.screen.view,
            sorted:state.screen.sorted,
            filtered:state.screen.filtered
            }
}

export default connect(mapStateToProps)(ScreenGrid)
