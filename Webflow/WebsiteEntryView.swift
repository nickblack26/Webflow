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
	@Environment(WebsiteManager.self) var websiteManager
	
	@State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
	@State private var selectedTab: SidebarTab? = .Add
	
	var website: WebsiteModel
	
	init(website: WebsiteModel) {
		self.website = website
	}
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		
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
							PageListView()
						case .Add:
							AddElementsView()
						case .navigator:
							NavigatorListView()
						case .components:
							ComponentsListView()
						case .assets:
							AssetsListView()
						case .find: EmptyView()
							
						default:
							AddElementsView()
					}
				} else {
					Text("Please select a tab")
				}
			}
		} detail: {
			ZStack {
				if let selectedPage = websiteManager.selectedPage {
					PageDetailView(selectedTab: $selectedTab, page: selectedPage)
				} else {
					EmptyPageDetailView()
				}
			}
			.toolbar {
				EditorToolbar()
			}
		}
		.onChange(of: websiteManager.draggingElement) {
			if(websiteManager.draggingElement == nil) {
				columnVisibility = .doubleColumn
			} else {
				columnVisibility = .detailOnly
			}
		}
	}
}

#Preview {
	WebsiteEntryView(website: .init(name: "Test"))
		.modelContainer(for: WebsiteModel.self, inMemory: true)
		.modelContainer(for: ElementModel.self, inMemory: true)
		.environment(previewWebsiteManager)
}
