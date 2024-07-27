import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    console.log("Map connected!")
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10", // Can change using urls from Mapbox Studio
      zoom: 9
    });
    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl }))
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    console.log("Placing markers!", this.markersValue)
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement('div')
      customMarker.innerHTML = marker.marker_html
      customMarker.backgroundSize = "contain"
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker({element: customMarker})
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  // This function will fit the map to all the markers.
  // It may be better to zoom in on the User's set location
  //If we do that, this function will need to be updated or it becomes irrelevant
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 10 })
  }
}
