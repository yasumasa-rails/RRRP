//https://github.com/timscott/react-devise/wiki/Accessing-Current-User-Components
//https://github.com/reactjs/react-tabs
import axios from 'axios'
import React from 'react'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';

class Menu extends React.Component {
                                      
  render() {
  //  const { isAuthenticated } = this.props
    if (isAuthenticated) {
      const menuListData = ()=>{ axios.get(`/api/screen/index`).then(menuListData=>menuListData)}
      let xxx;
      return (
        <div>
          <h2>Menu</h2>
            <Tabs>
              <TabList>
                { Object.keys(menuListData.catelist).map((cate,idx) => 
                  <Tab  key={idx}  >
                    {idx}
                  </Tab>
                )
                } 
              </TabList>
              {Object.keys(menuListData.catelist).map((cate,idx) => 
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
    return (
      <div>
        <h2>Menu</h2>
        <p>Logged out</p>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { isAuthenticated:state.auth.isAuthenticated ,
            currentUser: state.currentUser}
}

export default connect(mapStateToProps)(Menu)