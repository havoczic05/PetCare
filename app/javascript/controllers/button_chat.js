import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["content", "submit"];

  connect() {
    this.toggleSubmitButton();
  }

  toggleSubmitButton() {
    this.submitTarget.disabled = this.contentTarget.value.trim() === "";
  }

  handleInput() {
    this.toggleSubmitButton();
  }
}
