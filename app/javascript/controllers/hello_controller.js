import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["startDate", "endDate", "output", "petSelect", "price", "totalPrice"];
  connect() {
    console.log("Hello, Stimulus!")
    console.log(this.petSelectTarget.options[this.petSelectTarget.selectedIndex].text)
  }

  calculateDays() {
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);



    if (startDate && endDate && !isNaN(startDate) && !isNaN(endDate)) {
      const timeDiff = endDate - startDate;
      const dayDiff = Math.ceil(timeDiff / (1000 * 60 * 60 * 24));

      this.outputTarget.textContent = dayDiff >= 0 ? dayDiff : 0;

      const price = this.priceTarget.textContent;
      const totalPrice = dayDiff * price;

      this.totalPriceTarget.textContent = totalPrice;
    }
  }

  updatePetName(event) {

    const selectedPet = this.petSelectTarget.options[this.petSelectTarget.selectedIndex];
    const selectedPetName = selectedPet.text;
    const petPhotoURL = selectedPet.dataset.photo;
    const petNameDisplay = document.getElementById("petNameDisplay");
    const petPhotoDisplay = document.getElementById("petPhoto");

    if (selectedPetName === "Select a pet") {
      petNameDisplay.textContent = "";
    } else {
      petNameDisplay.textContent = selectedPetName;
    }

    if (petPhotoURL) { petPhotoDisplay.src = petPhotoURL; } else { petPhotoDisplay.src = "";  }
  }
}
