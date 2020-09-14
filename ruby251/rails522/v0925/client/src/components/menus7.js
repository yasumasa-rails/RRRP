//https://github.com/reactjs/react-tabs
//import axios from 'axios'
import React from 'react'
import { connect } from 'react-redux'
import { Tab, Tabs, TabList, TabPanel, } from 'react-tabs'
import "react-tabs/style/react-tabs.css"
import {Button} from '../styles/button'
import "../index.css"
//import { Helmet } from 'react-helmet'

import  SignUp  from './signup'
import  Login  from './login'
import {ScreenRequest} from '../actions'
import ScreenGrid7 from './screengrid7'
import ButtonList from './buttonlist'

const titleNameSet = (screenName) =>{ return (
  document.title = `${screenName}`
)
}

class Menus7 extends React.Component {
  render() {
    const { isAuthenticated ,menuListData,uid,getScreen, params,screenCode,
            pageSize,page,sortBy,filtered,isSignUp,hostError } = this.props
    
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
                                                page,sortBy,filtered,val.scr_name,uid,params
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
                  {screenCode?screenCode==="" ? "" :
                              <div> <ScreenGrid7/></div>:hostError }
                  {screenCode?screenCode==="" ? "" :
                              <div> <ButtonList/></div>:""}
           </div>    
      )
    }
     return(
     <div>
      <p> please wait </p>
    </div>)}
    else{
      if(isSignUp){
        return (
          <SignUp/>
        )
      }else{  
        return (
          <Login/>
        )
        }  
    }  
  }
}

const  mapStateToProps = (state,ownProps) =>({
  isSignUp:state.auth.isSignUp ,
  isAuthenticated:state.auth.isAuthenticated ,
  menuListData:state.menu.menuListData ,
  uid:state.auth.uid ,
//画面移動前のpageSize,・・・を持ってくるようにする。  
  pageSize:state.screen?state.screen.pageSize:null,
  page:state.screen?state.screen.page:0,
  data:state.screen?state.screen.data:[],
  sortBy:state.screen?state.screen.sortBy:{}, 
  filtered:state.screen?state.screen.filtered:{}, 
  params:state.screen.params,
  originalreq:state.screen.originalreq,
  message:state.menu.message,
  screenCode:state.screen.params?state.screen.params.screenCode:"",
  hostError: state.screen.hostError,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
      getScreen : (screenCode,pageSize, page,sortBy,filtered,screenName, uid,params) =>{
        titleNameSet(screenName)
        if(params){}else{params={}}
        params= { ...params, page: page, pageSize : pageSize,
                        sortBy:sortBy, screenName:  screenName,
                         screenCode:screenCode,uid:uid,req:"viewtablereq7",filtered:filtered} 
        dispatch(ScreenRequest(params,null))}   //data:null
          })    
export default connect(mapStateToProps,mapDispatchToProps)(Menus7)