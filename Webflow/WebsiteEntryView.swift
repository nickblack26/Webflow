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
	@State private var columnVisibility = NavigationSplitViewVisibility.all
	@State private var selectedTab: SidebarTab? = .add
	@State private var selectedPage: PageModel?
	
	var website: WebsiteModel
	
	init(website: WebsiteModel) {
		self.website = website
		if(!website.pages.isEmpty) {
			self._selectedPage = State(initialValue: website.pages[0])
		}
	}
	
	var body: some View {
		NavigationSplitView(columnVisibility: .constant(.all)) {
			List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
				Image(tab.symbol)
					.toolbar(removing: .sidebarToggle)
					.keyboardShortcut(tab.keyBoardShortcut.0 ?? " ", modifiers: tab.keyBoardShortcut.1 ?? [.command])
			}
			.navigationSplitViewColumnWidth(70)
		} content: {
			ZStack {
				if let selectedTab {
					switch selectedTab {
						case .pages:
							PageListView(selectedPage: $selectedPage, pages: website.pages)
						case .add:
							AddElementsView(selectedPage: $selectedPage)
						case .navigator:
							NavigatorListView(selectedPage: selectedPage)
						default:
							AddElementsView(selectedPage: $selectedPage)
							
					}
				} else {
					Text("Please select a tab")
				}
			}
			.navigationSplitViewColumnWidth(900)
		} detail: {
			if let selectedPage {
				PageDetailView(selectedTab: $selectedTab, page: selectedPage)
			} else {
				EmptyPageDetailView()
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
