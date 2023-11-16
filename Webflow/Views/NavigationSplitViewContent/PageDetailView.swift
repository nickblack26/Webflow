import SwiftUI
import SwiftData

struct PageDetailView: View {
	@Query var sizes: [SizeModel]
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var showPopover: Bool = true
	@Binding var selectedTab: SidebarTab?
	var page: PageModel
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		let children = page.body.children
		
		if let children, !children.isEmpty {
			List(selection: $websiteManager.selectedElement) {
				ForEach(children) { element in
					ElementView(element: element)
				}
			}
			.listStyle(.plain)
			.listRowSeparator(.hidden)
		} else {
			EmptyPageDetailView()
		}
	}
}

#Preview {
	NavigationSplitView {
		
	} detail: {
		PageDetailView(selectedTab: .constant(.Add), page: .init(name: "Test", index: 0))
			.environment(previewWebsiteManager)
			.modelContainer(for: WebsiteModel.self, inMemory: true)
	}
}
