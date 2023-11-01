//
//  ContentView.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import SwiftUI
import SwiftData

struct WebsiteEntryView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	
	@State private var columnVisibility = NavigationSplitViewVisibility.detailOnly
	@State private var selectedTab: SidebarTab? = .Add
	@State private var selectedPage: PageModel?
	
	var website: WebsiteModel
	
	init(website: WebsiteModel) {
		self.website = website
		if(!website.pages.isEmpty) {
			self._selectedPage = State(initialValue: website.pages[0])
		}
	}
	
	var body: some View {
		NavigationSplitView(columnVisibility: $columnVisibility) {
			List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
				if(tab.keyBoardShortcut.0 != nil && tab.keyBoardShortcut.1 != nil) {
					Label(tab.rawValue, image: tab.symbol)
						.keyboardShortcut(tab.keyBoardShortcut.0!, modifiers: tab.keyBoardShortcut.1!)
					
				} else if tab.keyBoardShortcut.0 != nil && tab.keyBoardShortcut.1 == nil {
					Label(tab.rawValue, image: tab.symbol)
						.keyboardShortcut(tab.keyBoardShortcut.0!)
				} else {
					Label(tab.rawValue, image: tab.symbol)
				}
			}
		} content: {
			ZStack {
				if let selectedTab {
					switch selectedTab {
						case .pages:
							PageListView(selectedPage: $selectedPage)
						case .Add:
							AddElementsView(selectedPage: $selectedPage)
						case .navigator:
							NavigatorListView(selectedPage: selectedPage)
						case .components:
							ComponentsListView()
						case .assets:
							AssetsListView()
						case .find: EmptyView()
							
						default:
							AddElementsView(selectedPage: $selectedPage)
					}
				} else {
					Text("Please select a tab")
				}
			}
		} detail: {
			if let selectedPage {
				PageDetailView(selectedTab: $selectedTab, page: selectedPage)
					.toolbar {
						EditorToolbar()
					}
			} else {
				EmptyPageDetailView()
					.toolbar {
						EditorToolbar()
					}
			}
		}
		.onChange(of: websiteManager.draggingElement) {
			columnVisibility = .detailOnly
			selectedTab = .Add
		}
	}
}

#Preview {
	WebsiteEntryView(website: .init(name: "Test"))
		.modelContainer(for: WebsiteModel.self, inMemory: true)
		.modelContainer(for: ElementModel.self, inMemory: true)
		.environment(previewWebsiteManager)
}
