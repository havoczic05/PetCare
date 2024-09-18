import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form-chat"
export default class extends Controller {
  reset() {
    this.element.reset()
  }

}
