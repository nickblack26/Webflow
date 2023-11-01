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
    }
}

#Preview {
	NavigationSidebarListView(selectedTab: .constant(.Add))
}
