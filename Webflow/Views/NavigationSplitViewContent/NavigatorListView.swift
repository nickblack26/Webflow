//
//  NavigatorListView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

struct NavigatorListView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@Query private var elements: [ElementModel]
	
    var body: some View {
		@Bindable var websiteManager = websiteManager
		if let selectedPage = websiteManager.selectedPage {
			List(selection: $websiteManager.selectedPage) {
				NavigatorListItemView(element: selectedPage.body)
			}
			.navigationTitle("Navigator")
		} else {
			ContentUnavailableView("Select A Page", image: "PageDefaultIcon")
				.navigationTitle("Navigator")
		}
    }
}
