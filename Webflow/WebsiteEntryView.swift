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
	@Environment(NavigationManager.self) var navigation
	
	@State private var columnVisibility = NavigationSplitViewVisibility.all
	@State private var preferredColumn = NavigationSplitViewColumn.sidebar
	@State private var selectedTab: SidebarTab? = .navigator
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
		@Bindable var navigation = navigation
		
		NavigationSplitView(
			columnVisibility: $columnVisibility,
			preferredCompactColumn: $preferredColumn
		) {
			SidebarListView()
				.frame(width: 48, alignment: .center)
				.navigationSplitViewColumnWidth(48)
		} content: {
			if let selectedTab = navigation.selectedTab {
				switch selectedTab {
					case .pages:
						PageListView(selectedPage: $navigation.selectedPage)
							.toolbar(removing: .sidebarToggle)
					case .Add:
						AddElementsView(selectedPage: $navigation.selectedPage)
							.toolbar(removing: .sidebarToggle)
					case .navigator:
						NavigatorListView(selectedPage: navigation.selectedPage)
							.toolbar(removing: .sidebarToggle)
							.navigationSplitViewColumnWidth(min: 225, ideal: 275, max: 325)
					case .components:
						ComponentsListView()
							.toolbar(removing: .sidebarToggle)
					case .assets:
						AssetsListView()
							.toolbar(removing: .sidebarToggle)
					case .find: EmptyView().toolbar(removing: .sidebarToggle)
						
					default:
						AddElementsView(selectedPage: $navigation.selectedPage)
							.toolbar(removing: .sidebarToggle)
				}
			} else {
				Text("Please select a tab")
			}
		} detail: {
			ZStack {
				if let selectedPage = selectedPage {
					PageDetailView(selectedTab: $selectedTab, page: selectedPage)
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
						.toolbar(.hidden)
				} else {
					EmptyPageDetailView()
						.toolbar(.hidden)
				}
			}
		}
		.inspector(isPresented: .constant(true)) {
			ElementInspectorView()
		}
		.toolbar(.hidden)
	}
}

#Preview {
	WebsiteEntryView(website: .init(name: "Test"))
		.modelContainer(for: WebsiteModel.self, inMemory: true)
		.modelContainer(for: ElementModel.self, inMemory: true)
		.environment(previewWebsiteManager)
}

struct SidebarListView: View {
	@Environment(NavigationManager.self) var navigation
	
	var body: some View {
		@Bindable var navigation = navigation
		List(SidebarTab.allCases, id: \.self, selection: $navigation.selectedTab) { tab in
			Image(tab.symbol)
				.resizable()
				.frame(width: 24, height: 24, alignment: .center)
				.scaledToFit()
				.listItemTint(.white)
				.listRowSeparator(.hidden)
				.listRowBackground(Rectangle().fill(navigation.selectedTab == tab ? .background2 : .clear))
				.tag(tab)
		}
		.scrollContentBackground(.hidden)
		.background(Color("Background"), ignoresSafeAreaEdges: .all)
		.toolbar(removing: .sidebarToggle)
		.listStyle(.plain)
	}
}
