import React from 'react';
import ReactTooltip from 'react-tooltip'

const TooltipExampleSimple = () => (
  <div data-tip data-for='Tooltip' >
      <ReactTooltip  id='Tooltip' place='top'  className='btn btn-default'>
      <span>Show happy face</span>
      </ReactTooltip >
  </div>   
); 

export default TooltipExampleSimple;