import {BrowserRouter, Switch, Route} from 'react-router-dom';

class RaisedButtonMenuRoute extends React.Component {  
    render(){
      return(
        <BrowserRouter>
        <div >
        <Switch>
        <Route exact path={'/'} render={props => <OnClickWithRouter cates={this.props.menueList}/>}/>
        this.props.menueList.map((cate,idx) =>   //showMenuNames screens/index
                {cate.map((val,index) =>
                    <Route pass={"../screens:sid="+val[1]} render={props=><BootstrapTableinit/>}/> 
               )}      
        )     
        </Switch>
        </div>
        </BrowserRouter>
      );
    }   
  }

export default RaisedButtonMenuRoute;