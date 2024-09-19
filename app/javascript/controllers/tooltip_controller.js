import { Controller } from "@hotwired/stimulus"
import "bootstrap";

export default class extends Controller {
  connect() {
    this.initializeTooltip();
  }

  initializeTooltip() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
  }
}
