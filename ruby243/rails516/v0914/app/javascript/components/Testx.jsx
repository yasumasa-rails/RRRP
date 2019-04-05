import React  from 'react';
import { BrowserRouter as Router, Route } from "react-router-dom";
import ModalSwitch from './ModalSwitch';


class Testx extends React.Component {
    constructor(props, context) {
        super(props, context);
        this.state = {cates: this.props.cates,
        }
       }
     render() {
        return(  <ModalSwitch cates={this.state.cates} />
        )
     }
}     

export default Testx;