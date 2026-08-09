import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame"]
  static values = { url: String, clearOnEmpty: { type: Boolean, default: true } }

  connect() {
    this.closeOnOutsideClick = this.closeOnOutsideClick.bind(this)
    document.addEventListener("click", this.closeOnOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnOutsideClick)
  }

  search(event) {
    clearTimeout(this.timeout)

    const value = event.target.value.trim()
    if (value === "" && this.clearOnEmptyValue) {
      this.frameTarget.innerHTML = ""
      this.frameTarget.removeAttribute("src")
      return
    }

    this.timeout = setTimeout(() => {
        if (value === "") {
          this.frameTarget.src = this.urlValue
          return
        }
        const separator = this.urlValue.includes("?") ? "&" : "?"
        this.frameTarget.src = `${this.urlValue}${separator}q=${encodeURIComponent(value)}`
    }, 300)
  }

  closeOnOutsideClick(event) {
    if (!this.clearOnEmptyValue) return
    if (!this.element.contains(event.target)) {
      this.frameTarget.innerHTML = ""
      this.frameTarget.removeAttribute("src")
    }
  }
}