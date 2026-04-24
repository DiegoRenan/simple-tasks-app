import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["lightIcon", "darkIcon"]

  connect() {
    if (localStorage.getItem("theme") === "dark") {
      this.element.classList.add("dark")
      this.#applyDarkUI()
    }
  }

  toggle() {
    const isDark = this.element.classList.toggle("dark")
    localStorage.setItem("theme", isDark ? "dark" : "light")
    isDark ? this.#applyDarkUI() : this.#applyLightUI()
  }

  #applyDarkUI() {
    this.lightIconTargets.forEach(el => el.classList.add("hidden"))
    this.darkIconTargets.forEach(el => el.classList.remove("hidden"))
  }

  #applyLightUI() {
    this.lightIconTargets.forEach(el => el.classList.remove("hidden"))
    this.darkIconTargets.forEach(el => el.classList.add("hidden"))
  }
}
