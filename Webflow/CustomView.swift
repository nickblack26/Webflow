//
//  CustomView.swift
//  Webflow
//
//  Created by Nick Black on 11/8/23.
//

import SwiftUI

struct CustomView: View {
	@State private var columnVisibility = NavigationSplitViewVisibility.all
	@State private var preferredColumn = NavigationSplitViewColumn.sidebar
	@State private var selectedTab: SidebarTab? = .navigator
	@State private var selectedPage: PageModel?
	@State private var searchText: String = ""
	var website: WebsiteModel
	
    var body: some View {
		VStack {
			HStack {
				GeometryReader {
					let size = $0.size
					
					List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
						Image(tab.symbol)
							.resizable()
							.scaledToFit()
							.frame(width: 24, height: 24, alignment: .center)
							.listRowSeparator(.hidden)
//							.listItemTint(.white)
//							.listRowSpacing(0)
//							.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
					}
					.frame(width: 48, alignment: .center)
					.toolbar(removing: .sidebarToggle)
					.listStyle(.plain)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
	CustomView(website: .init(name: "Webflow"))
}
