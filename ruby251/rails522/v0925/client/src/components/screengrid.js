import React from 'react';
import { connect } from 'react-redux'
import ReactTable from 'react-table'
import "react-table/react-table.css"
import {ScreenParamsSet} from '../actions'
import ButtonList from './buttonlist'

// LOGIN FORM
// @NOTE For forms that can be reused for both create/update you would move this form to its own
// file and import it with different initialValues depending on the use-case. An over-optimization
// for this simple login form however.


class ScreenGrid extends React.Component {

  render() {
  
    const {screenCode, pageSize,
      //screenName,view,token,client,uid,
      //      page,sorted,filtered,
            handleScreenParamsSet,columns,data,pages,
            } = this.props
    
    //let  params= {  page: page?page:0,  
    //        pageSize :pageSize?pageSize:20,
    //        sorted: sorted,  filtered: filtered,      
    //        screenCode:screenCode,uid:uid}         
   
    return(
      <div>
      {screenCode?  
      <ReactTable
      columns={columns?columns:[]} 
      pages={pages?pages:0}  //
      pageSize={pageSize?pageSize:0}  //
      data={data?data:[]} // should default to [] / 
        manual // informs React Table that you'll be handling sorting and pagination server-side
        onFetchData={( subparams,instance) => {                      
                            handleScreenParamsSet(subparams)  
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
          borderRadius: "5px",  overflow: "hidden", padding: "5px"
        }}
      >
        {makeTable()}
        <ButtonList/>
      </div>
    );
  }}
        </ReactTable>
        :"please select"}
        </div>
       )
    }
  }
const  mapStateToProps = (state) => {
  return {  uid:state.login.auth?state.login.auth.uid:"",
            token:state.login.auth?state.login.auth["access-token"]:"",
            client:state.login.auth?state.login.auth.client:"",
            screenCode:state.screen.screenCode,
            screenName:state.screen.screenName,
            columns:state.screen.columns,
            data:state.screen.data,
            pages:state.screen.pages,
            page:state.screen.page,
            pageSize:state.screen.pageSize,
            sorted:state.screen.sorted,
            filtered:state.screen.filtered
            }
}
   

const mapDispatchToProps = (dispatch,ownProps ) => ({
    handleScreenParamsSet:  (subparams) =>{dispatch(ScreenParamsSet(subparams))},
  })   
export default connect(mapStateToProps,mapDispatchToProps)(ScreenGrid)
