//https://reacttraining.com/react-router/web/example/modal-gallery
//https://github.com/ReactTraining/react-router/blob/master/packages/react-router/docs/api/location.md
//https://qiita.com/gcyagyu/items/834041c5bd5b45691d32
import React from 'react';
import { Switch, Route, Router } from "react-router-dom";
import BootstrapTableinit from './BootstrapTableinit';
import ScreenContents from './ScreenContents';
import createBrowserHistory from 'history/createBrowserHistory'
class ModalSwitch extends React.Component {
    constructor(props) {
        super(props);
    }
    render() {
        let newHistory;
        if (typeof document !== 'undefined') {
            const createBrowserHistory = require('history/createBrowserHistory').default
              newHistory = createBrowserHistory();
            }else{
              newHistory = createBrowserHistory();
            }
        const cates = this.props.cates;
        const  location  = newHistory.location;
        const isModal = !!(
             location.state &&
            location.state.modal &&
            this.previousLocation !== location
        ); // not initial render
        return (
            <Router history={newHistory} >
            <div>
            <Switch location={isModal ? this.previousLocation : location}>}/>
            <Route  exact  path={'/'}  render={props => <Modal cates={cates} />}/>
            <Route  path={'/screens/index'}  render={props => <Modal cates={cates} />}/>
            </Switch>
        {isModal ? <Route path="/screens/show?sid=:id"  render={props => <OneScreen  />}  /> : null}
            </div>
            </Router>
        );
     }
}

class Modal extends React.Component {    
    render(){
    const  cates=this.props.cates;  
    return(
        cates.map((cate,idx) => 
            <div  key={idx}  >
                {cate.map((val,index) => 
                <span  key={index}   > 
                    <ScreenContents contents={{screen_id:val[0],name:val[1],remark:val[2],linex:idx*10+index}} />
                </span>)}
            </div>          
        )  
    )
    }
}        
      
class OneScreen extends React.Component {
    render() {
          const params = this.props.match;
          const id = params.id;
        return (
            <BootstrapTableinit sid={id} page={1} sizePerPage={10}
                     sizePerPageList={[]} totalCnt={0}
                     screenName={id}
                     datashowfields={[]}
                     from={""} to={""} datashowrecords={[]}  />
          )
        }
}

export default ModalSwitch;
