import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["image"]

    show(event) {
        this.imageTarget.src = event.params.image
    }
}
