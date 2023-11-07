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
	@State private var selectedPage: PageModel?
	@State private var searchText: String = ""
	var website: WebsiteModel
	
	init(website: WebsiteModel) {
		self.website = website
		let primaryPage = website.pages.first { $0.isHome }
		if(selectedPage == nil) {
			self._selectedPage = .init(initialValue: primaryPage)
		}
	}
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		
		NavigationSplitView(columnVisibility: $columnVisibility) {
			List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
				if(tab.keyBoardShortcut.0 != nil && tab.keyBoardShortcut.1 != nil) {
					Label(tab.rawValue, image: tab.symbol)
						.keyboardShortcut(tab.keyBoardShortcut.0!, modifiers: tab.keyBoardShortcut.1!)
						.listItemTint(.white)
					
				} else if tab.keyBoardShortcut.0 != nil && tab.keyBoardShortcut.1 == nil {
					Label(tab.rawValue, image: tab.symbol)
						.keyboardShortcut(tab.keyBoardShortcut.0!)
						.listItemTint(.white)
					
				} else {
					Label(tab.rawValue, image: tab.symbol)
						.listItemTint(.white)
				}
			}
		} content: {
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
		} detail: {
			ZStack {
				if let selectedPage = selectedPage {
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
			.inspector(isPresented: .constant(true)) {
				ElementInspectorView()
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
