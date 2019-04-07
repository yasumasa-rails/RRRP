//https://github.com/timscott/react-devise/wiki/Accessing-Current-User-Components
//https://github.com/reactjs/react-tabs
//import axios from 'axios'
import React from 'react'
import { connect } from 'react-redux'
import { Link,BrowserRouter,Route, } from 'react-router-dom'
import { Tab, Tabs, TabList, TabPanel, } from 'react-tabs'
import "react-tabs/style/react-tabs.css"

import { Signup } from './signup'
import { Login } from './login'
import  {ScreenGrid}  from './screengrid'
import {ScreenRequest} from '../actions'

class Menus extends React.Component {
  
  componentDidUpdate(prevProps,token,client,uid) {
    // id が変更されたら
    if (this.props.location.search !== prevProps.location.search
       && this.props.location.pathname === '/menus') {
      this.props.dispatch(ScreenRequest(this.props.location.search,token,client,uid) )
    }
  }
  render() {
    const { isAuthenticated ,menuListData,} = this.props
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
                    <Tab key={index}><Link to={"/menus?id="+val.scr_name} color="primary" >{val.scr_name}</Link> 
                        <Route path={"/menus?id="+val.scr_name}  component={ScreenGrid} />
                    
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
            </div>        
      )
    }
     return(
     <div>
      <Link to="/logout" color="primary" >Logout</Link>
    </div>)}
    return (
      <BrowserRouter>
      <div>
        <Route path='/signup' component={Signup} />
        <Route path='/login' component={Login} />
        <p>
        <Link to="/login" color="primary" >Login</Link>
        </p>
        <p>
        <Link to="/signup" color="primary" >Signup</Link>
        </p>
      </div>
      </BrowserRouter>
    )
  }
}

function mapStateToProps(state) {
  return { isAuthenticated:state.login.isAuthenticated ,
            menuListData:state.login.menuListData ,
            token:(state.login.auth?state.login.auth["access-token"]:"") ,
            client:(state.login.auth?state.login.auth.client:""),
            uid:(state.login.auth?state.login.auth.uid:"") ,
            }
}

export default connect(mapStateToProps)(Menus)