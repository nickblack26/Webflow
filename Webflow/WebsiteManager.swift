import Foundation
import Observation

@Observable
class WebsiteManager {
	var selectedElement: ElementModel?
	var selectedPage: PageModel?
	var selectedWebsite: WebsiteModel? {
		didSet {
			guard let selectedWebsite = selectedWebsite else { return }
			selectedPage = selectedWebsite.pages.first(where: { $0.isHome })
		}
	}
	var draggingElement: ElementModel?
	var showCommandBar: Bool = false
}



let previewWebsiteManager = WebsiteManager()
