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
    this.updateCounter(target)
    this.updateCounter("nav-pending-tab", "reduce")
  }

  updateCounter(target, action = "increment") {
    console.log(action);
    const counter = document.querySelector(`#${target} .counter`)
    counter.innerHTML = this.validateNum(counter.innerHTML, action)
  }

  validateNum(num, action) {
    const conditional = action === "reduce" ? Number(num) - 1 : Number(num) + 1
    return conditional <= 0 ? 0 : conditional
  }
}
