// // app/javascript/controllers/dropzone_controller.js
import { Controller } from "@hotwired/stimulus"
import Dropzone from "dropzone";

export default class extends Controller {
  connect() {
    const dropzoneConfig = {
      url: this.url,
      paramName: "file",
      maxFilesize: 10,
      addRemoveLinks: true,
      acceptedFiles: ".pdf",
      dictDefaultMessage: "Drop file here to upload",
      maxFiles: 1,
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content
      },
    };

    this.dropzone = new Dropzone(this.element, dropzoneConfig);
  }

  get fileType() {
    return this.element.getAttribute("data-file-type")
  }

  get url() {
    return `upload_file?file_type=${(this.fileType)}`
  }
}