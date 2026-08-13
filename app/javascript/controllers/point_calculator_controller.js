import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["count", "total"]
    static values = { perItem: Number }

    updateTotal() {
        const count = parseInt(this.countTarget.value, 10) || 0
        this.totalTarget.textContent = `${count * this.perItemValue}P`
    }
}
