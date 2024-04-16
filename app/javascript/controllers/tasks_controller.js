import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ["task"];

  connect(){}

  toggle() {
    this.taskTarget.classList.toggle('hide');
  }
}
