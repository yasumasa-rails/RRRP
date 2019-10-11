import React, { Component } from 'react';
import PropTypes from 'prop-types';
import DropzoneComponent from 'react-dropzone-component';
import 'react-dropzone-component/styles/filepicker';
import 'dropzone/dist/min/dropzone.min';

const djsConfig = {
  acceptedFiles: "excel",
  autoProcessQueue: false,
  uploadMultiple: false,
  addRemoveLinks: true
}

const componentConfig = {
  iconFiletypes: ['.xlsx', '.xls'],
  showFiletypeIcon: true,
  maxFiles: 1,
  postUrl: 'no-url'
}

export default class ExcelUploader extends Component {
  showPreview = excel => {
    if(excel == null) return;

    let mockFile = {
      name: excel.name,
      size: excel.byte_size,
      dataURL: excel.url,
    };

    this.myDropzone.files.push(mockFile);
    this.myDropzone.emit("addedfile", mockFile);
    this.myDropzone.createThumbnailFromUrl(
      mockFile,
      this.myDropzone.options.thumbnailWidth,
      this.myDropzone.options.thumbnailHeight,
      this.myDropzone.options.thumbnailMethod,
      true,
      thumbnail => {
        this.myDropzone.emit('thumbnail', mockFile, thumbnail);
        this.myDropzone.emit("complete", mockFile);
      }
    );
  }

  removePrevAndAddNew = excel => {
    if(this.myDropzone.files.length > 1) {
      let prevExcel = this.myDropzone.files[0];
      this.myDropzone.emit('removedfile', prevExcel);
    }

    this.props.selectExcel(excel);
  }

  render() {
    const { excel } = this.props;
    const eventHandlers = {
      init: dropzone => {
        this.myDropzone = dropzone;
        this.showPreview(excel);
      },
      addedfile: excel => this.removePrevAndAddNew(excel),
      removedfile: () => this.props.unselectExcel()
    }

    return (
      <DropzoneComponent
        config={componentConfig}
        eventHandlers={eventHandlers}
        djsConfig={djsConfig}
      />
    );
  }
}

ExcelUploader.propTypes = {
  excel: PropTypes.shape({
    name: PropTypes.string,
    byte_size: PropTypes.integer,
    url: PropTypes.string
  }),
  selectExcel: PropTypes.func.isRequired,
  unselectExcel: PropTypes.func.isRequired
};