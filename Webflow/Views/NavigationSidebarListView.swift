//
//  SidebarListView.swift
//  Webflow
//
//  Created by Nick on 10/30/23.
//

import SwiftUI

struct NavigationSidebarListView: View {
	@Binding var selectedTab: SidebarTab?
	
    var body: some View {
		List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
			Label(tab.rawValue, image: tab.symbol)
				.keyboardShortcut(tab.keyBoardShortcut.0 ?? " ", modifiers: tab.keyBoardShortcut.1 ?? [.command])
		}
    }
}

#Preview {
	NavigationSidebarListView(selectedTab: .constant(.add))
}
