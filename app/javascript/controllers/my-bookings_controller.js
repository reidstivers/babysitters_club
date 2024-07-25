import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="my-bookings"
export default class extends Controller {
  static targets = ["all", "pending", "confirmed", "declined", "completed"];

  connect() {
    console.log("My Bookings controller connected!");
    this.checkTargets();
  }

  toggle(event) {
    event.preventDefault();
    console.log("Toggle clicked!");
    this.hideAll();
    const status = event.currentTarget.dataset.status;
    console.log(`Status selected: ${status}`);
    if (status === "all") {
      this.showTarget("all");
    } else {
      this.showTarget(status);
    }
  }

  hideAll() {
    console.log("Hiding all targets!");
    this.allTarget.classList.add("d-none");
    this.pendingTarget.classList.add("d-none");
    this.confirmedTarget.classList.add("d-none");
    this.declinedTarget.classList.add("d-none");
    this.completedTarget.classList.add("d-none");
  }

  showTarget(status) {
    const target = this[`${status}Target`];
    if (target) {
      target.classList.remove("d-none");
    } else {
      console.error(`No target found for status ${status}`);
    }
  }

  checkTargets() {
    console.log("All Targets:", this.allTargets);
    console.log("Pending Targets:", this.pendingTargets);
    console.log("Confirmed Targets:", this.confirmedTargets);
    console.log("Declined Targets:", this.declinedTargets);
    console.log("Completed Targets:", this.completedTargets);
  }
}
