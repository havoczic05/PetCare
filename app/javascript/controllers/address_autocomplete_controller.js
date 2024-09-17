import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String, search: String }
  static targets = ["address"]

  connect() {
    this.geocoder = new MapboxGeocoder({
        accessToken: this.apiKeyValue,
        types: 'country,region,place,postcode,locality,neighborhood,address'
    });
    this.geocoder.addTo(this.element);
    this.geocoder.on('result', event => this.#setInputValue(event));
    this.geocoder.on('clear', event => this.#clearInputValue());
    const searchInput = document.querySelector('input[aria-label="Search"]')
    if(this.searchValue) {
      searchInput.value = this.searchValue
    }
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result.place_name;
  }

  #clearInputValue() {
    this.addressTarget.value = '';
  }
}
