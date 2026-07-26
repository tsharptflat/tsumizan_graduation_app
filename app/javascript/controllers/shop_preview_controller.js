import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["image", "description"]

    show(event) {
        this.imageTarget.src = event.params.image
        this.descriptionTarget.textContent = event.params.description
    }
}
