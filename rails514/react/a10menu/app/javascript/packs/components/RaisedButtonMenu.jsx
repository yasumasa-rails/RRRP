import React from 'react';
import RaisedButton from 'material-ui/RaisedButton';
import ReactTooltip from 'react-tooltip'

const style = {
  margin: 12,
};

const RaisedButtonExampleSimple = () => (
  <div>
    <a data-tip data-for='Tooltip1' >
    <RaisedButton label={addStatement()} style={style} /></a>
    <a data-tip data-for='Tooltip2' >
    <RaisedButton label="Primary" primary={true} style={style}  /></a>
    <RaisedButton label="Secondary" secondary={true} style={style}  />
    <RaisedButton label="Disabled" disabled={true} style={style}    />
    <br />
    <br />
    <RaisedButton label="Full width" fullWidth={true} />
    <div >
        <ReactTooltip id="Tooltip1" place="bottom" type="dark" effect="float" >
        <span>Show happy face</span>
        </ReactTooltip >
        <ReactTooltip id="Tooltip2" place="bottom" type="dark" effect="float" >
        <span>うれしいな</span>
        </ReactTooltip >
    </div>   
  </div>
);

export default RaisedButtonExampleSimple;