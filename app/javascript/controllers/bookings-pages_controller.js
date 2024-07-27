import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bookings-pages"
export default class extends Controller {
  static targets = ["bookings", "myBookings"];

  connect() {
    console.log("Bookings Pages controller connected!");
    console.log("bookingsTarget:", this.bookingsTarget);
    console.log("myBookingsTarget:", this.myBookingsTarget);
  }

  toggle(event) {
    console.log("Toggle clicked!");
    this.hideAll();
    const target = event.currentTarget.dataset.target;
    console.log(`Target selected: ${target}`);
    this.showTarget(target);
  }

  hideAll() {
    console.log("Hiding all targets!");
    this.bookingsTarget.classList.add("d-none");
    this.myBookingsTarget.classList.add("d-none");
  }

  showTarget(target) {
    const targetElement = this.targets.find(target)
    if (targetElement) {
      targetElement.classList.remove("d-none");
    } else {
      console.error(`No target found for ${target}`);
    }
  }
}
