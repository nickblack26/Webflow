//
//  CustomSidebar.swift
//  Webflow
//
//  Created by Nick Black on 11/9/23.
//

import SwiftUI

struct CustomSidebar: View {
	var body: some View {
		List {
			HStack(alignment: .top, spacing: 5) {
				VStack {
					ForEach(SidebarTab.allCases, id: \.self) { tab in
						Button {} label: {
							Image(tab.symbol)
								.resizable()
								.frame(width: 16, height: 16)
								.contentShape(RoundedRectangle(cornerRadius: 5))
						}
					}
				}
				
				Divider()
				
				VStack {
					AssetsListView()
				}
			}
		}
		.frame(maxHeight: .infinity, alignment: .top)
		.listStyle(.plain)
		.toolbar {
			ToolbarItemGroup(placement: .bottomBar) {
				ForEach(SidebarTab.allCases, id: \.self) { tab in
					Button {} label: {
						Image(tab.symbol)
							.resizable()
							.frame(width: 16, height: 16)
							.contentShape(RoundedRectangle(cornerRadius: 5))
					}
				}
			}
		}
	}
}

#Preview {
	NavigationSplitView {
		CustomSidebar()
	} detail: {
		
	}
}
