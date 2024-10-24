import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkRoutes", "extraFields"]

  connect() {
    this.toggleCheckSection()
  }

  toggleCheckSection() {
    this.extraFieldsTargets.forEach(el => {
      el.disabled = !this.checkRoutesTarget.checked

      if (el.disabled) {
        el.value = null
      }
    });
  }
}
