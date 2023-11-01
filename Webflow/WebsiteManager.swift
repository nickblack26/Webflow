import Foundation
import Observation

@Observable
class WebsiteManager {
	var selectedElement: ElementModel?
	var selectedWebsite: WebsiteModel?
	var draggingElement: ElementModel?
	var showCommandBar: Bool = false
}



let previewWebsiteManager = WebsiteManager()
