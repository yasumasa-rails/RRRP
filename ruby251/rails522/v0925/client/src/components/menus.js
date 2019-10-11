//https://github.com/timscott/react-devise/wiki/Accessing-Current-User-Components
//https://github.com/reactjs/react-tabs
//import axios from 'axios'
import React from 'react'
import { connect } from 'react-redux'
import { Link,BrowserRouter,Route,} from 'react-router-dom'
import { Tab, Tabs, TabList, TabPanel, } from 'react-tabs'
import "react-tabs/style/react-tabs.css"
import Button from '@material-ui/core/Button'
import "./index.css"

import { Signup } from './signup'
import { Login } from './login'
import {ScreenRequest} from '../actions'
import ScreenGrid from './screengrid'

 class Menus extends React.Component {
  render() {
    const { isAuthenticated ,menuListData,token,client,uid,getScreen, 
            pageSize,page,sorted,filtered,} = this.props
    
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
            <Tabs  forceRenderTabPanel defaultIndex={0}  selectedTabClassName="react-tabs--selected_custom_head">
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
                <Tabs forceRenderTabPanel  selectedTabClassName="react-tabs--selected_custom_detail">
                <TabList>
                  {menuListData.map((val,index) => 
                    grp_name===val.grp_name&&
                    <Tab key={index} >
                      <Button   type="submit"
                      onClick ={() => getScreen(val.screen_code,pageSize?pageSize:val.page_size,
                                                page,sorted,filtered,val.scr_name,
                                                token,client,uid)}>
                      {val.scr_name}       
                      </Button>             
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
        <Login/>
        <Route path='/signup' component={Signup} />
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
//画面移動前のpageSize,・・・を持ってくるようにする。  
  pageSize:state.screen?state.screen.pageSize:null,
  page:state.screen?state.screen.page:0,
  sorted:state.screen?state.screen.sorted:[], 
  filtered:state.screen?state.screen.filtered:[], 
  
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
      getScreen : (screenCode,pageSize, page,sorted,filtered,screenName,token, client, uid) =>{
        let  params= {  page: page, pageSize : pageSize,
                        sorted:sorted,  filtered:filtered,      
                         screenCode:screenCode,uid:uid,req:"viewtablereq"} 
        dispatch(ScreenRequest(params, token, client, uid,screenName))}
          })    

export default connect(mapStateToProps,mapDispatchToProps)(Menus)