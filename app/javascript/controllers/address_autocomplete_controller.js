import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["location"]

  connect() {
    console.log("Connected!")
    console.log(this.apiKeyValue)
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    })
    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  // disconnect() {
  //   this.geocoder.onRemove()
  // }

  #setInputValue(event) {
    console.log(event.result)
    const selectedPlace = event.result.place_name
    this.locationTarget.value = selectedPlace
  }

  #clearInputValue() {
    this.locationTarget.value = ""
  }
}
