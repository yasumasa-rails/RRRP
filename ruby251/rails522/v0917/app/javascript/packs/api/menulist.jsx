import React from 'react'
import { reduxForm } from 'redux-form';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs'
import { connect } from 'react-redux';

let MenuList  = (props) => {
  const {menulist} = props
  return( 
  <div>
  <h2>Menu  x</h2>
      <Tabs>
          <TabList>
          { menulist.map((cate,idx) => 
              <Tab  key={idx}  >
              {idx}
              </Tab>
              )
          } 
          </TabList>
          {menulist.map((cate,idx) => 
          <TabPanel  key={idx}>
          <Tabs>
          <TabList>
              {cate.map((val,index) => 
              <Tab  key={index}> 
                  {val.orgneme}
              </Tab>)}
          </TabList>
          {cate.map((val,index) => 
          <TabPanel  key={index}> 
            {val.contents}
            { xxx && <ScreenContents contents={{screen_id:val[0],name:val[1],remark:val[2],linex:idx*10+index}} />}
            }
          </TabPanel>)}
          </Tabs>
          </TabPanel> 
          )}
      </Tabs>
  </div> 
  )  
}


MenuList = reduxForm({
    form: 'menulist', //                 <------ same form name
  })(MenuList)

export default connect()(MenuList)  
