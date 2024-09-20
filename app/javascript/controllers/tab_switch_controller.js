import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["tab"];

  connect() {
    document.addEventListener("turbo:submit-end", (event) => {
      this.changeTab(event)
    })
  }

  changeTab(event) {
    const target = event.target.action.includes("accept")
        ? 'nav-confirmed-tab'
        : 'nav-rejected-tab';

    document.getElementById(target).click();
  }
}
