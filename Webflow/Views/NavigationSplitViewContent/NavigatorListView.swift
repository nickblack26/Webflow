import SwiftUI
import SwiftData

struct NavigatorListView: View {
	@Query private var elements: [ElementModel]
	@Environment(WebsiteManager.self) private var websiteManager
	var selectedPage: PageModel?
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		if let selectedPage {
			List(selection: $websiteManager.selectedElement) {
				NavigatorListItemView(element: selectedPage.body)
			}
			.listStyle(.plain)
			.listRowSpacing(0)
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Text("Navigator")
				}
				
				ToolbarItemGroup {
					Image("CollapseIcon")
						.resizable()
						.frame(width: 16, height: 16)
						.buttonHoverEffect()
					
					Image("PinFilledIcon")
						.resizable()
						.frame(width: 16, height: 16)
						.buttonHoverEffect()
				}
			}
		} else {
			ContentUnavailableView("Select A Page", image: "PageDefaultIcon")
				.navigationTitle("Navigator")
		}
	}
}

#Preview {
	NavigatorListView()
}
