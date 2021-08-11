import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["plan", "cardFields"]

  connect() {
    this.toggle()
  }

  toggle() {
    if(this.premiumPlanSelected()) {
      this.show()
    }
    else {
      this.hide()
    }
  }

  premiumPlanSelected() {
    const planSelect = this.planTarget
    const selectedOption = planSelect.options[planSelect.selectedIndex].text

    return selectedOption == 'Premium'
  }

  show() {
    const cardFields = this.cardFieldsTarget

    cardFields.classList.add("d-flex");
    cardFields.classList.remove("d-none");
  }

  hide() {
    const cardFields = this.cardFieldsTarget
    
    cardFields.classList.remove("d-flex");
    cardFields.classList.add("d-none");
  }
}
