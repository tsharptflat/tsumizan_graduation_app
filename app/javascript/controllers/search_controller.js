import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame"]

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
    if (value === "") {
      this.frameTarget.innerHTML = ""
      this.frameTarget.removeAttribute("src")
      return
    }

    this.timeout = setTimeout(() => {
        this.frameTarget.src = `/games/search_suggestions?q=${encodeURIComponent(value)}`
    }, 300)
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.frameTarget.innerHTML = ""
      this.frameTarget.removeAttribute("src")
    }
  }
}