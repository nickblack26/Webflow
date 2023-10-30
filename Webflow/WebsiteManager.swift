import Foundation
import Observation

@Observable
class WebsiteManager {
	var selectedElement: ElementModel?
	var selectedWebsite: WebsiteModel?
	var draggingElement: ElementModel?
}

let previewWebsiteManager = WebsiteManager()
