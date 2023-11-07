import Foundation
import Observation

@Observable
class WebsiteManager {
	var selectedElement: ElementModel?
	var selectedPage: PageModel?
	var selectedWebsite: WebsiteModel? {
		didSet {
			guard let website = selectedWebsite else { return }
			print("setting page")
			selectedPage = website.pages[0]
		}
	}
	var draggingElement: ElementModel?
	var showCommandBar: Bool = false
}



let previewWebsiteManager = WebsiteManager()
