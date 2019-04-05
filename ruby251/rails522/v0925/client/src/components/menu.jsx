//https://github.com/timscott/react-devise/wiki/Accessing-Current-User-Components
//https://github.com/reactjs/react-tabs
//import axios from 'axios'
import React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Tab, Tabs, TabList, TabPanel, } from 'react-tabs'
import "react-tabs/style/react-tabs.css"


class Menu extends React.Component {
                                      
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
                    grp_name===val.grp_name&&<Tab key={index}> {val.scr_name}</Tab>)}
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
      )
    }
     return(
     <div>
      <Link to="/logout" color="primary" >Logout</Link>
    </div>)}
    return (
      <div>
        <p>
        <Link to="/signup" color="primary" >Signup</Link>
        </p>
        <p>
        <Link to="/login" color="primary" >Login</Link>
        </p>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { isAuthenticated:state.login.isAuthenticated ,
            menuListData:state.login.menuListData ,
            }
}

export default connect(mapStateToProps)(Menu)