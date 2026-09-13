import { Application } from "@hotwired/stimulus"
import { NestedFormController } from "stimulus-library"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Load Stimulus Library controllers
application.register("nested-form", NestedFormController);


export { application }
