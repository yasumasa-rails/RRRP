
import React from 'react'
import { connect } from 'react-redux'
import { Tab, Tabs, TabList,TabPanel , } from 'react-tabs'
import Upload from './upload'
import Download from './download'
import "react-tabs/style/react-tabs.css"
import Button from '@material-ui/core/Button'
import "../index.css"
import {ScreenRequest,ButtonFlgRequest} from '../actions'


 const  ButtonList = ({buttonListData,setButtonFlg,buttonflg,
                        screenCode,uid,screenName,
                        page,sorted,params,
                      //  editableflg,message
                      }) =>{
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
            <Tabs   forceRenderTabPanel defaultIndex={0}  selectedTabClassName="react-tabs--selected_custom_footer">
              
                <TabList>
                  {tmpbuttonlist[screenCode].map((val,index) => 
                    <Tab key={index} >
                      <Button  
                      type={val[1]==='inlineedit'||'inlineadd'||'yup'?"submit":"button"}
                      onClick ={() =>{ setButtonFlg(val[1],  // buttonCode
                                                    //screenCode,uid,screenName,
                                                    page,sorted,params
                                                    //editableflg,
                                                    )
                                      }
                                     }>
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
        <React.Fragment> </React.Fragment>
        </div>    
      )
    }

const  mapStateToProps = (state,ownProps) =>({
  buttonListData:state.button.buttonListData ,  
  buttonflg:state.button.buttonflg ,  
  params:state.screen.params ,  
  screenCode:state.screen.params.screenCode ,  
  screenName:state.screen.params.screenName ,  
  uid:state.login.auth?state.login.auth.uid:"" ,
  page:state.screen?state.screen.page:0,
  sorted:state.screen?state.screen.sorted:[], 
  //editableflg:state.screen.editableflg,
  message:state.screen.message
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
  setButtonFlg : (buttonCode,
                  //editableflg,screenCode,uid,screenName,
                    page,sorted,params) =>{
        let buttonflg = buttonCode;
        dispatch(ButtonFlgRequest(buttonflg)) // import export 画面用
        if(buttonCode==="inlineedit")
          { params= { ...params, page: page, 
            sorted:sorted,   req:"editabletablereq"}
          //editableflg = true
              dispatch(ScreenRequest(params)) //menu
         }
         if(buttonCode==="inlineadd")
           { params= {...params,  page: page, pages:1,req:"inlineaddreq"}
          //  editableflg = true
              dispatch(ScreenRequest(params)) //menu
          }
          if(buttonCode==="yup")
            { params= { ...params,req:"yup"}
           //  editableflg = false
                dispatch(ScreenRequest(params)) //menu
           }
      } 
  })    

export default connect(mapStateToProps,mapDispatchToProps)(ButtonList)