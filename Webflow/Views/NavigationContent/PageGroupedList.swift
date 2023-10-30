//
//  PageGroupedList.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI
import SwiftData

struct PageGroupedList: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var isExpanded: Bool = true
	@Query private var pages: [PageModel]
	var pageType: PageModel.PageType
	
	init(pageType: PageModel.PageType) {
		self.pageType = pageType
//		let id = websiteManager.selectedWebsite?.id ?? UUID()
		self._pages = Query(filter: #Predicate<PageModel> {
			$0.type == pageType
		})
	}
	
    var body: some View {
		Section("\(pageType.rawValue) pages", isExpanded: $isExpanded) {
			if pages.isEmpty {
				EmptyListView(item: pageType.emptyView)
			} else {
				ForEach(pages, id: \.self) { page in
					NavigationLink(value: page) {
						Label(page.name, image: "PageDefaultIcon")
					}
				}
			}
		}
		.tint(.primary)
		.foregroundStyle(.primary)
    }
}

#Preview {
	NavigationSplitView {
		List {
			PageGroupedList(pageType: .generic)
			PageGroupedList(pageType: .utility)
			PageGroupedList(pageType: .cms)
			PageGroupedList(pageType: .ecommerce)
			PageGroupedList(pageType: .user)
		}
		.modelContainer(for: PageModel.self, inMemory: true)
		.environment(previewWebsiteManager)
	} detail: {
	
	}
}
