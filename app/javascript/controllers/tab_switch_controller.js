import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab-switch"
export default class extends Controller {
  static targets = ["tab"];
  connect() {
  }

  changeTab(event) {
    const action = event.detail.success ? "accept_booking" : "reject_booking";

    if (action.includes("accept_booking")) {
      this.activateTab('confirmed');
    }
    if (action.includes("reject_booking")) {
      this.activateTab('rejected');
    }
  }

  activateTab(tabSlug) {
    const tabId = `nav-${tabSlug}-tab`;
    const tabElement = document.getElementById(tabId);

    if (tabElement) {
      tabElement.click();
    }
  }
}
