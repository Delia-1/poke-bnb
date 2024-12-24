import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["togglableElement", "togglableElemBis"];

  connect() {
    console.log("Hello, Stimulus! WORKS")
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");

    this.togglableElemBisTarget.classList.toggle("d-none");
    console.log("Fire on fire")
  }
}
