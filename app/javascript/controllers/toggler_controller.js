import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggler"
export default class extends Controller {
  static targets = ["comments", "button"];

  connect() {
    console.log("Hello, toggler!");
  }

  fire() {
    console.log("Firing toggler!");
    this.commentsTarget.classList.toggle("d-none");
    this.buttonTarget.classList.toggle("d-none");
  }
}
