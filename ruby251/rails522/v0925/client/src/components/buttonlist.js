
import React from 'react'
import { connect } from 'react-redux'
import { Tab, Tabs, TabList,TabPanel , } from 'react-tabs'
import Upload from './upload'
import Download from './download'
import "react-tabs/style/react-tabs.css"
import Button from '@material-ui/core/Button'
import "../index.css"
import {ScreenRequest,ButtonFlgRequest,DownloadRequest,
        YupRequest,TblfieldRequest} from '../actions'


 const  ButtonList = ({buttonListData,setButtonFlg,buttonflg,
                        screenCode,page,sorted,params,downloadloading,disabled,
                        message,messages //  editableflg,message
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
                      disabled={disabled}
                      type={val[1]==='inlineedit'||'inlineadd'||'yup'?"submit":"button"}
                      onClick ={() =>{ setButtonFlg(val[1],  // buttonflg
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
        {downloadloading==="done"?<Download/>:downloadloading==="doing"?<p>please wait </p>:""}
        {params.req==="createTblViewScreen"&&params.messages.map((msg,index) =>{
                                                return  <p key ={index}>{msg}</p>
                                                  }
                                               )}
        <p>{message}</p>
        {messages&&messages.map((val,index) => 
                     <p key={index} > {val}</p>
                    )}
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
  message:state.button.messages,
  messages:state.button.message,
  downloadloading:state.button.downloadloading,
  disabled:state.button.disabled?true:false,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
  setButtonFlg : (buttonflg,
                  //editableflg,screenCode,uid,screenName,
                    page,sorted,params) =>{
        dispatch(ButtonFlgRequest(buttonflg,params)) // import export 画面用
        switch (buttonflg) {
          case "inlineedit":
            params= { ...params, page: page, 
            sorted:sorted,   req:"editabletablereq"}
          //editableflg = true
            return dispatch(ScreenRequest(params)) //
        
          case "inlineadd":
            params= {...params,  page: page, pages:1,req:"inlineaddreq"}
          //  editableflg = true
             return  dispatch(ScreenRequest(params)) //
          
          case "export":
              params= {...params,  req:"download"}
            //  editableflg = true
               return  dispatch(DownloadRequest(params)) //
               
          case "yup":
             params= { ...params,req:"yup"}
           //  editableflg = false
            return  dispatch(YupRequest(params)) //

            case "crt_tbl_view_screen":
               params= {req:"createTblViewScreen",screenCode:params.screenCode}
             //  editableflg = false
              return  dispatch(TblfieldRequest(params)) //
          default:
            return 
        }   
      } 
  })    

export default connect(mapStateToProps,mapDispatchToProps)(ButtonList)