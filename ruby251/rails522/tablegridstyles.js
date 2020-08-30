import styled from 'styled-components'

export const TableGridStyles = styled.div`
  padding: 1rem;
  ${'' /* These styles are suggested for the table fill all available space in its containing element */}
  display: block;
  ${'' /* These styles are required for a horizontaly scrollable table overflow */}
  overflow: auto;
  table {
    border-spacing: 0;
    border: 1px solid black; 
    height:${props => props.height};
    tr {
      :last-child {
        td {
          border-bottom: 0;
        }
      }
    }
    
    thead {
      width:${props => props.screenwidth}px
    }
    tbody {
      width:${props => props.screenwidth + 25}px
    }
    th,
    td {
      margin: 0;
      padding: 0.5rem;
      border-bottom: 1px solid black;
      border-right: 1px solid black;

      
      ${'' /* In this example we use an absolutely position resizer,
       so this is required. */}
      position: relative;
      
      :last-child {
        border-right: 0;
      }
      input {
        font-size: 1rem;
        padding: 0;
        margin: 0;
        border: 0;
        .EditableNumeric {
          background: rgb(120, 160, 247);
          type:number;
          align:right;
        }
        .NonEditableNumeric {
          type:number;
          align:right;
        }
      }
    }
  .resizer {  /* */
    display: inline-block;
    background: gray;
    width: 1px;
    height:73%;  /* 縦の移動線  */
    position: absolute;   /* これがないと形がずれる  */
    right: 0;
    top: 0;
    transform: translateX(50%);
    z-index: 1;
      margin: 0;
      padding: 0.5rem;
      border-bottom: 1px solid black;
      border-right: 1px solid black;
    ${'' /* prevents from scrolling while dragging on touch devices */}
    touch-action:none;
    &.isResizing {
      background: red;
    }
  }
  .pagination {
    padding: 0.5rem;
  }
  
}
`