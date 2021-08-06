import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["plan", "cardFields"]

  connect() {
    this.toggleCardFields()
  }

  toggleCardFields() {
    if(this.premiumPlanSelected()) {
      this.showCardFields()
    }
    else {
      this.hideCardFields()
    }
  }

  premiumPlanSelected() {
    const planSelect = this.planTarget
    const selectedOption = planSelect.options[planSelect.selectedIndex].text

    return selectedOption == 'Premium'
  }

  showCardFields() {
    const cardFields = this.cardFieldsTarget

    cardFields.classList.add("d-flex");
    cardFields.classList.remove("d-none");
  }

  hideCardFields() {
    const cardFields = this.cardFieldsTarget
    
    cardFields.classList.remove("d-flex");
    cardFields.classList.add("d-none");
  }
}
