import React from 'react'
import { connect } from 'react-redux'
import { Tab, Tabs, TabList,TabPanel , } from 'react-tabs'
import Upload from './upload.js'
import Download from './download'
import GanttChart from './ganttchart'
import "react-tabs/style/react-tabs.css"
import {Button} from '../styles/button'
import "../index.css"
import {ScreenRequest,DownloadRequest,GanttChartRequest,GanttReset,
        ScreenInitRequest,//ButtonFlgRequest,
        YupRequest,TblfieldRequest,ResetRequest,} from '../actions'


 const  ButtonList = ({buttonListData,setButtonFlg,buttonflg,
                        screenCode,page,params,downloadloading,disabled,
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
                      type={val[1]==='inlineedit7'||'inlineadd7'||'yup'||'ganttchart'?"submit":"button"}
                      onClick ={() =>{
                                      setButtonFlg(val[1],page,params)} // buttonflg
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
        
        {buttonflg==="ganttchart"&&<GanttChart/>}
        {buttonflg==='import'&&<Upload/>}
        {buttonflg==="export"&&downloadloading==="done"?<Download/>:downloadloading==="doing"?<p>please wait </p>:""}
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
  uid:state.auth.uid,
  page:state.screen?state.screen.page:0,
  message:state.button.message,
  messages:state.button.messages,
  downloadloading:state.download.downloadloading,
  disabled:state.button.disabled?true:false,
 // originalreq:state.screen.originalreq,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
  setButtonFlg : (buttonflg,    //editableflg,screenCode,uid,screenName,search
                    page,params) =>{
       // dispatch(ButtonFlgRequest(buttonflg,params)) // import export 画面用
        switch (buttonflg) {  //buttonflg ==button_code
          case "reset":
            params= { ...params, page: page,req:"reset"}
          //editableflg = true
            return dispatch(ResetRequest(params)) //

          case "search":
              params= { ...params, page: page,req:"viewtablereq7"}
            //editableflg = true
              return dispatch(ScreenRequest(params,null)) //data=null　再度もとめ直し
        
          case "inlineedit7":
              params= { ...params, page: page,req:"inlineedit7"}
              //editableflg = true
                return dispatch(ScreenInitRequest(params,null)) //data=null　再度もとめ直し
          
          case "inlineadd7":
            params= {...params,  page: page, pages:1,req:"inlineadd7"}
          //  editableflg = true
             return  dispatch(ScreenInitRequest(params,null)) //data=null　空白を表示
          
          case "export":
              params= {...params,  req:"download7"}
            //  editableflg = true
               return  dispatch(DownloadRequest(params)) //
               
          case "yup":
             params= { ...params,req:"yup"}
           //  editableflg = false
            return  dispatch(YupRequest(params)) //

          case "ganttchart":
            if(params["clickIndex"]){
               params= { ...params,req:"ganttchart"}
             //  editableflg = false
              return  dispatch(GanttChartRequest(params)) }//
            else{dispatch(GanttReset())}  
            break

          case "crt_tbl_view_screen":
               params= {req:"createTblViewScreen",screenCode:params.screenCode}
             //  editableflg = false
              return  dispatch(TblfieldRequest(params)) //

          case "unique_index":
                    params= {req:"createUniqueIndex",screenCode:params.screenCode}
                     //  editableflg = false
                    return  dispatch(TblfieldRequest(params)) 
          default:
            return 
        }   
      } 
  })    

export default connect(mapStateToProps,mapDispatchToProps)(ButtonList)