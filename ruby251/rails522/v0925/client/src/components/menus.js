//https://github.com/timscott/react-devise/wiki/Accessing-Current-User-Components
//https://github.com/reactjs/react-tabs
//import axios from 'axios'
import React from 'react'
import { connect } from 'react-redux'
import { Link,BrowserRouter,Route,} from 'react-router-dom'
import { Tab, Tabs, TabList, TabPanel, } from 'react-tabs'
import "react-tabs/style/react-tabs.css"
import {Button} from '../styles/button'
import "../index.css"

import { Signup } from './signup'
import { Login } from './login'
import {ScreenRequest} from '../actions'
import ScreenGrid from './screengrid'

 class Menus extends React.Component {
  render() {
    const { isAuthenticated ,menuListData,uid,getScreen, params,
            pageSize,page,sorted,sizePerPageList} = this.props
    
    if (isAuthenticated) {
      if(menuListData){
      let tmpgrpscr =[]   //グルーブ化されたメニュー
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
                                                page,sorted,val.scr_name,uid,sizePerPageList,params
                                                )}>
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
      <p> please wait </p>
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
  uid:(state.login.auth?state.login.auth.uid:"") ,
//画面移動前のpageSize,・・・を持ってくるようにする。  
  pageSize:state.screen?state.screen.pageSize:null,
  page:state.screen?state.screen.page:0,
  data:state.screen?state.screen.data:[],
  sorted:state.screen?state.screen.sorted:null, 
  sizePerPageList:state.screen.sizePerPageList?state.screen.sizePerPageList:[25],
  params:state.screen.params,
  originalreq:state.screen.originalreq,
  message:state.menu.message,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
      getScreen : (screenCode,pageSize, page,sorted,screenName, uid,sizePerPageList,params) =>{
        if(params){}else{params={}}
        params["filtered"]=[] 
        if(params["dropdownselect"]){}else{params["dropdownselect"]={}}
        Object.keys(params["dropdownselect"]).map((sel)=>{
              params["filtered"].push({id:sel,value:params["dropdownselect"][sel]})
              return params["filtered"] }
             ) 
        params= { ...params, page: page, pageSize : pageSize,sizePerPageList:sizePerPageList,
                        sorted:sorted,   screenName:  screenName,
                         screenCode:screenCode,uid:uid,req:"viewtablereq",filtered:params?params.filtered:[]} 
        dispatch(ScreenRequest(params))}
          })    

export default connect(mapStateToProps,mapDispatchToProps)(Menus)