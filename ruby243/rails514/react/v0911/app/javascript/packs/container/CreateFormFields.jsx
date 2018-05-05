import React from 'react';
import ReactDOM from 'react-dom';
import { Form } from 'react-bootstrap';
class SameRowField extends React.Component {
  constructor(props) {
    super(props);
    const id = this.props.id;
    const label = this.props.label;
    const text = this.props.text;
    const value = this.props.value;
    const placeholer = this.props.placeholder;
    const width = this.props.width;
  }  
  render() {    
    return (
      <FormGroup controlId={id} >
        <ControlLabel>{label}</ControlLabel>
        <FormControl type={text}    value={value}   placeholder={placeholder}
                     onChange={this.handleChange} width={width}
          />
      </FormGroup>
    );
  }  
}  
class MapsFormFields extends React.Component {
  constructor(props) {
    super(props);
    this.state = {newField:"",rowIndex:0} ;
    this.handleChange = this.handleChange.bind(this);   
    this.tmpField = this.tmpField.bind(this);  
    this.createfields = this.createfields.bind(this);  
  }
  handleChange(e) {}
  tmpField = (field) => ( <SameRowField label ={field["pobject_code_sfd"]} 
                              type={field["sceenfield_type"]}    value={field["pobject_code_sfd"]} 
                              placeholder={field["screenfield_contents"]}  
                              onChange={this.handleChange} width={50}
                              />
                          );
  createfields(newField,rowIndex,fields){
                                        for(let i = rowIndex;i < fields.length;i++){
                                            do{ this.setState(() =>( {newField: this.state.newField + tmpField(fields[i])}));
                                                this.setState(() =>( {rowIndex:i+1}));
                                              }while(fields[rowIndex]["screenfield_rowpos"]== fields[i]["screenfield_rowpos"]);
                                        }
                                      }      
  render() {    
    const fields = this.props.fields;
    let rowFields = (newField,rowIndex,fields) =>{fields.length > rowIndex && <Form inline>{createfields(newField,rowIndex,fields)}</Form>};
    return(<div class='form'>
        {felds.map((field,index)=> rowFields(this.state.newField,this.state.rowIndex,fields))}
    </div>
    ) 
  }  
}
export default MapsFormFields;