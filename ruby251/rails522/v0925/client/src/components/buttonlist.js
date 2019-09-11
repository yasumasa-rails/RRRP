
import React from 'react'
import { connect } from 'react-redux'
import { Tab, Tabs, TabList,TabPanel , } from 'react-tabs'
import Upload from './upload'
import Download from './download'
import GanttChart from './ganttchart'
import "react-tabs/style/react-tabs.css"
import {Button} from '../styles/button'
import "../index.css"
import {ScreenRequest,ButtonFlgRequest,DownloadRequest,GanttChartRequest,GanttReset,
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
                      type={val[1]==='inlineedit'||'inlineadd'||'yup'||'ganttchart'?"submit":"button"}
                      onClick ={() =>{ setButtonFlg(val[1],  // buttonflg
                                                    page,sorted,params
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
        
        {buttonflg==="ganttchart"?params["onClickSelect"]?params["onClickSelect"]["index"]?<GanttChart/>:" select item":"select item":""}
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
  uid:state.login.auth?state.login.auth.uid:"" ,
  page:state.screen?state.screen.page:0,
  sorted:state.screen?state.screen.sorted:[], 
  message:state.button.message,
  messages:state.button.messages,
  downloadloading:state.button.downloadloading,
  disabled:state.button.disabled?true:false,
  originalreq:state.screen.originalreq,
})

const mapDispatchToProps = (dispatch,ownProps ) => ({
  setButtonFlg : (buttonflg,
                  //editableflg,screenCode,uid,screenName,
                    page,sorted,params) =>{
        dispatch(ButtonFlgRequest(buttonflg,params)) // import export 画面用
        switch (buttonflg) {
          case "inlineedit":
            params= { ...params, page: page,sorted:sorted,   req:"editabletablereq"}
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

          case "ganttchart":
            if(params["onClickSelect"]["index"]){
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