import { Controller } from "@hotwired/stimulus"
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {
  updateRoute(event) {
    event.preventDefault()

    const request = new FetchRequest(event.params.method, event.params.url, {
      body: JSON.stringify({
        new_status: event.params.newStatus
      }),
    })

    request.perform().then(() => window.location.reload())
  }
}
