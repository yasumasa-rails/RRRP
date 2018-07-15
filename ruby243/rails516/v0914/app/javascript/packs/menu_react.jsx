import React from 'react';
import ReactDOM from 'react-dom';
import {BrowserRouter, Switch, Route} from 'react-router-dom';
import ScreenGroup from './components/ScreenGroup';
import BootstrapTableinit from '../components/BootstrapTableinit';

const cates = showMenuNames();
const constRoute = (url)=>(<Route pass={url} render={props=><BootstrapTableinit/>}/> );
const Menu = () => (
    <BrowserRouter>
    <div >
    <Switch>
      <Route exact path={'/'} render={props => <OnClickWithRouter cates={cates}/>}/>
      {cates.map((cate,idx) =>  
            cate.map((val,index) =>
               constRoute("../screens:sid="+val[1])
            )      
          )}     
    </Switch>
    </div>
    </BrowserRouter>
);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Menu/>,
    document.getElementById('menu')
  )
});
