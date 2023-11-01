//
//  NavigationDetailPageView.swift
//  Webflow
//
//  Created by Nick on 10/30/23.
//

import SwiftUI

struct NavigationDetailPageView: View {
	@Binding var selectedTab: SidebarTab?
	@Binding var selectedPage: PageModel?
	
    var body: some View {
		if let selectedPage {
			PageDetailView(selectedTab: $selectedTab, page: selectedPage)
			
		} else {
			EmptyPageDetailView()
		}
    }
}

#Preview {
	NavigationDetailPageView(selectedTab: .constant(.Add), selectedPage: .constant(.init(name: "Hello")))
}
