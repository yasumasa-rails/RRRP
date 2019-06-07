
import React from 'react'
import { connect } from 'react-redux'
import { Tab, Tabs, TabList,TabPanel , } from 'react-tabs'
import Upload from './upload'
import Download from './download'
import "react-tabs/style/react-tabs.css"
import Button from '@material-ui/core/Button'
import "./index.css"
import {ButtonFlgRequest,ScreenRequest} from '../actions'


 const  ButtonList = ({buttonListData,setButtonFlg,buttonflg,
                        screenCode,token,client,uid,screenName,
                        pageSize,page,sorted,filtered,editableflg}) =>{
      let tmpbuttonlist = {}
      if(buttonListData){
         buttonListData.map((cate) => {
            if(tmpbuttonlist[cate.screen_code]){tmpbuttonlist[cate.screen_code].push([cate.button_title,cate.button_code])}
            else{tmpbuttonlist[cate.screen_code]=[];
                 tmpbuttonlist[cate.screen_code].push([cate.button_title,cate.button_code])}   
             return tmpbuttonlist
          })  
        } 
      return (
        <div>
        {tmpbuttonlist[screenCode]&&   //画面のボタンが用意されてないときはskip
            <Tabs   forceRenderTabPanel defaultIndex={0}  selectedTabClassName="react-tabs--selected_custom_head">
              
                <TabList>
                  {tmpbuttonlist[screenCode].map((val,index) => 
                    <Tab key={index} >
                      <Button  
                      type={val[1]==='inlineedit'||'inlineadd'||'edit'||'copy and add'?"submit":"button"}
                      onClick ={() => setButtonFlg(val[1],screenCode,token,client,uid,screenName,
                                                    pageSize,page,sorted,filtered,editableflg)}>
                      {val[0]}       
                      </Button>             
                    </Tab>
                    )} 
                </TabList>
                  {tmpbuttonlist[screenCode].map((val,index) => 
                     <TabPanel key={index} >
                      {val[2]}
                    </TabPanel>
                    )} 
            </Tabs>
        }
        {buttonflg==='import'&&<Upload/>}
        {buttonflg==='export'&&<Download/>}
        </div>    
      )
    }

const  mapStateToProps = (state,ownProps) =>({
  buttonListData:state.button.buttonListData ,  
  buttonflg:state.button.buttonflg ,  
  screenCode:state.screen.screenCode ,  
  screenName:state.screen.screenName ,  
  token:(state.login.auth?state.login.auth["access-token"]:"") ,
  client:(state.login.auth?state.login.auth.client:""),
  uid:(state.login.auth?state.login.auth.uid:"") ,
  pageSize:state.screen?state.screen.pageSize:null,
  page:state.screen?state.screen.page:0,
  sorted:state.screen?state.screen.sorted:[], 
  filtered:state.screen?state.screen.filtered:[], 
  editableflg:state.screen.editableflg,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
  setButtonFlg : (buttonCode,screenCode,token,client,uid,screenName,
                        pageSize,page,sorted,filtered,editableflg) =>{
        let  buttonflg = "";
        buttonflg = buttonCode;
        dispatch(ButtonFlgRequest(buttonflg));
        if(buttonCode==="inlineedit")
          { let  params= {  page: page, pageSize : pageSize,
            sorted:sorted,  filtered:filtered,      
             screenCode:screenCode,uid:uid,req:"editabletablereq"}
          editableflg = true
          dispatch(ScreenRequest(params,token,client,uid,screenName,editableflg)) //menu
         }
         if(buttonCode==="inlineadd")
           { let  params= {  page: page, pageSize : pageSize,pages:1,
              screenCode:screenCode,uid:uid,req:"inlineaddreq"}
            editableflg = true
            dispatch(ScreenRequest(params,token,client,uid,screenName,editableflg)) //menu
          }
      } 
  })    

export default connect(mapStateToProps,mapDispatchToProps)(ButtonList)