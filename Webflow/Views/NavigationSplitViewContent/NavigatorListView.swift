//
//  NavigatorListView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct NavigatorListView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	var selectedPage: PageModel?
	
    var body: some View {
		@Bindable var websiteManager = websiteManager
		if let selectedPage = selectedPage {
			List(selection: $websiteManager.selectedElement) {
				NavigatorListItemView(element: selectedPage.body)
			}
			.navigationTitle("Navigator")
		} else {
			ContentUnavailableView("Select A Page", image: "PageDefaultIcon")
				.navigationTitle("Navigator")
		}
    }
}
