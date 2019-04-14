//https://github.com/timscott/react-devise/wiki/Accessing-Current-User-Components
//https://github.com/reactjs/react-tabs
//import axios from 'axios'
import React from 'react'
import { connect } from 'react-redux'
import { Link,BrowserRouter,Route,withRouter , } from 'react-router-dom'
import { Tab, Tabs, TabList, TabPanel, } from 'react-tabs'
import "react-tabs/style/react-tabs.css"

import { Signup } from './signup'
import { Login } from './login'
import {ScreenRequest} from '../actions'
import ScreenGrid from './screengrid'


 
class Menus extends React.Component {
 
  render() {
    const { isAuthenticated ,menuListData,token,client,uid,getScreen} = this.props
    
    if (isAuthenticated) {
      if(menuListData){
      let tmpgrpscr =[]   
      let ii = 0
      menuListData.map((cate) => {
            if(tmpgrpscr[ii-1]!==cate.grp_name){tmpgrpscr[ii]=cate.grp_name;ii=ii+1}    
          return tmpgrpscr
          })  
      return (
        <div>
            <Tabs  forceRenderTabPanel defaultIndex={0}>
              <TabList>
                { tmpgrpscr.map((grp_name,idx) => 
                  <Tab key={idx} >
                    {grp_name} 
                  </Tab>
                )
                } 
              </TabList>
              {tmpgrpscr.map((grp_name,idx) => 
                <TabPanel key={idx}  >
                <Tabs forceRenderTabPanel>
                <TabList>
                  {menuListData.map((val,index) => 
                    grp_name===val.grp_name&&
                    <Tab key={index}>
                      <Link color="primary"  to={`/menus/${val.scr_name}`} > 
                      {val.scr_name}       
                      </Link>             
                    </Tab>)}
                </TabList>
                  {menuListData.map((val,index) => 
                    grp_name===val.grp_name&&
                    <TabPanel  key={index}> 
                      {val.contents?val.contents:" "}
                    </TabPanel>)}
                </Tabs>
                </TabPanel> 
              )}
            </Tabs>
            <ScreenGrid/>
            </div>    
      )
    }
     return(
     <div>
      <p>seq error </p>
    </div>)}
    return (
      <BrowserRouter>
      <div>
        <Route path='/signup' component={Signup} />
        <Login/>
        <Link to="/signup" color="primary" >Signup</Link>
      </div>
      </BrowserRouter>
    )
  }
}

const  mapStateToProps = (state,ownProps) =>({
  isAuthenticated:state.login.isAuthenticated ,
  menuListData:state.menu.menuListData ,
  token:(state.login.auth?state.login.auth["access-token"]:"") ,
  client:(state.login.auth?state.login.auth.client:""),
  uid:(state.login.auth?state.login.auth.uid:"") ,
  
})


const mapDispatchToProps = (dispatch,ownProps ) => ({
      getScreen : () =>{
        const params = {id:ownProps.scr_name}
        const {token, client, uid} = ownProps
       dispatch(ScreenRequest(params, token, client, uid))}
          })    

export default withRouter(connect(mapStateToProps,mapDispatchToProps)(Menus))