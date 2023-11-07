import SwiftUI
import SwiftData

struct PageGroupedList: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var pages: [PageModel]
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var isExpanded: Bool = true
	var pageType: PageModel.Category
	@Binding var searchText: String
	
	init(pageType: PageModel.Category, searchText: Binding<String>) {
		self.pageType = pageType
		self._searchText = searchText
		self._pages = Query(filter: #Predicate<PageModel> {
			$0.categoryId == pageType.rawValue
		}, sort: \.createdAt)
	}
	
    var body: some View {
		var pages = pages
		if searchText.isEmpty || (!searchText.isEmpty && !filteredPages().isEmpty) {
			DisclosureGroup("\(pageType.rawValue) pages", isExpanded: $isExpanded) {
				if filteredPages().isEmpty {
					EmptyListView(image: pageType.emptyView.image, title: pageType.emptyView.title, description: pageType.emptyView.description)
				} else {
					ForEach(pages, id: \.self) { page in
						Label(page.name, image: "PageDefaultIcon")
							.listRowSeparator(.hidden)
							.listRowInsets(EdgeInsets())
							.contextMenu(ContextMenu(menuItems: {
								Button("Delete") {
									modelContext.delete(page)
								}
							}))
							.moveDisabled(page.isHome)		
					}
					.onMove(perform: { indices, newOffset in
						move(&pages, from: indices, to: newOffset)
					})
				}
			}
			.tint(.primary)
			.foregroundStyle(.primary)
		}
    }
	
	
	private func filteredPages() -> [PageModel] {
		if searchText.isEmpty {
			return pages
		} else {
			return pages.filter {$0.name.lowercased().contains(searchText.lowercased())}
		}
	}
	
	func move(_ data: inout [PageModel], from source: IndexSet, to destination: Int) {
		data.move(fromOffsets: source, toOffset: destination)
		
		if(destination == 0) {
			for index in source {
				pages[index].index = 0
				pages.forEach { page in
					if page.index != index {
						page.index += 1
					}
				}
				print(index, destination)
			}
		} else {
			for index in source {
				pages[index].index = destination
				print(index, destination)
			}
		}
	}
}

#Preview {
	@State var searchText: String = ""
	
	 return NavigationSplitView {
		
	} content: {
		List {
			PageGroupedList(pageType: .Static, searchText: $searchText)
			PageGroupedList(pageType: .Utility, searchText: $searchText)
			PageGroupedList(pageType: .CMS, searchText: $searchText)
			PageGroupedList(pageType: .Ecommerce, searchText: $searchText)
			PageGroupedList(pageType: .User, searchText: $searchText)
		}
		
	} detail: {
	
	}
	.modelContainer(for: PageModel.self, inMemory: true)
	.environment(previewWebsiteManager)
}
