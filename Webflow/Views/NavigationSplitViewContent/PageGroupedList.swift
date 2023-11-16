import SwiftUI
import SwiftData

struct PageGroupedList: View {
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \PageModel.index) private var pages: [PageModel]
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
						PageRow(page)
					}
					.onMove { indices, newOffset in
//						 Make a copy of the current list of items
						var updatedPages = pages
						
						updatedPages.move(fromOffsets: indices, toOffset: newOffset)
						
						for (index, updatedPage) in updatedPages.enumerated() {
							var page = pages[index]
							print(updatedPage.name, "'s ", "current index", page.index, "\nNew Index", index)
							page.index = index
						}

						try? modelContext.save()
						move(&pages, from: indices, to: newOffset)
					}
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
		
		for index in data.indices {
			var page = pages[index]
			page.index = index
			
			print(modelContext.hasChanges)
			
			do {
				try modelContext.save()
				print("Saved")
			} catch {
				print(error)
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
