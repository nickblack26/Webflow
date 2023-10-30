//
//  WebflowEntryView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

enum WebflowTab: String, CaseIterable {
	case allSites = "All sites"
	case tutorials = "Tutorials"
	
	var icon: String {
		switch self {
			case .allSites: return "list.bullet.below.rectangle"
			case .tutorials: return "video"
		}
	}
}

struct WebflowEntryView: View {
	@Query private var websites: [WebsiteModel]
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var newWebsite: Bool = false
	
	var body: some View {
		NavigationSplitView {
			List(WebflowTab.allCases, id: \.self) { tab in
				Label(tab.rawValue, systemImage: tab.icon)
			}
		} detail: {
			List {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
					ForEach(websites) { website in
						WebsiteListItemView(website: website)
					}
					.onDelete(perform: deleteItems)
				})
				.listRowSeparator(.hidden)
			}
			.listStyle(.inset)
			.navigationTitle("My Workspace")
//			.toolbar {
//				ToolbarItem {
//					Button {
//						newWebsite.toggle()
//					} label: {
//						Image(systemName: "plus")
//					}
//				}
//			}
		}
		.sheet(isPresented: $newWebsite, content: {
			NewWebsiteView()
		})
	}
	
	private func delete(_ website: WebsiteModel) {
		websiteManager.selectedWebsite = nil
		modelContext.delete(website)
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(websites[index])
			}
		}
	}
}

#Preview {
	WebflowEntryView()
		.environment(previewWebsiteManager)
}
