import styled from 'styled-components'

export const TableGridStyles = styled.div`
padding: 1rem;
${'' /* These styles are suggested for the table fill all available space in its containing element */}
display: block;
${'' /* These styles are required for a horizontaly scrollable table overflow */}

.table {
  border-spacing: 0;
  border: 1px solid black;
  height:auto; 

  .thead {
    ${'' /* These styles are required for a scrollable body to align with the header properly */}
    width:${props => props.screenwidth}px 
  }

  .tbody {
    ${'' /* These styles are required for a scrollable table body */}
    width:${props => props.screenwidth + 25}px
    overflow-y: hidden;
    overflow-x: scroll;
    .tr{ height: 35px;
        white-space: nowrap;
      }
  }

  .tr {
    :last-child {
      .td {
        border-bottom: 0;
      }
    }
    border-bottom: 1px solid black;
  }

  .th ,
  .td {
    margin: 0;
    padding: 0.5rem;
    border-right: 1px solid black;
    font-size: 1em;

    ${'' /* In this example we use an absolutely position resizer,
     so this is required. */}
    position: relative;

    :last-child {
      border-right: 0;
    }

    .resizer {
      right: 0;
      background: steelblue;
      width: 5px;
      height: 65px;
      position: absolute;
      top: 0;
      z-index: 1;
      ${'' /* prevents from scrolling while dragging on touch devices */}
      touch-action :none;

      &.isResizing {
        background: red;
      }
    }
  }
  .pagination {
    padding: 0.5rem;
  }
 input { width:100%;
        border: 0.1px;}
}
`