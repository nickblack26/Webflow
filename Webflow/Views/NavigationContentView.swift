//
//  NavigationContentView.swift
//  Webflow
//
//  Created by Nick on 10/30/23.
//

import SwiftUI

struct NavigationContentView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@Binding var selectedTab: SidebarTab?
	@Binding var selectedPage: PageModel?
	var pages: [PageModel]
	var websiteId: UUID
	
    var body: some View {
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
//		.navigationSplitViewColumnWidth(900)
    }
}

#Preview {
	NavigationContentView(selectedTab: .constant(.Add), selectedPage: .constant(.init(name: "Hello")), pages: [], websiteId: UUID())
}
