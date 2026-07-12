import * as bootstrap from "bootstrap"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    close() {
        bootstrap.Modal.getInstance(this.element).hide()
    }
}