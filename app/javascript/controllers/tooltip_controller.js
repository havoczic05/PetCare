import { Controller } from "@hotwired/stimulus"
import "bootstrap";
export default class extends Controller {
  static targets = ["tooltip"]

  connect() {
    this.initializeTooltip();
  }

  initializeTooltip() {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    return [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
  }

  hiddenTooltip() {
    this.tooltipTargets.forEach((tooltip) => {
      const tooltipInstance = bootstrap.Tooltip.getInstance(tooltip);
      if (tooltipInstance) {
        tooltipInstance.hide()
      }
    })
  }
}
