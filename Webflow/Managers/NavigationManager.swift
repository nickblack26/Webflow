//
//  NavigationManager.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import Foundation
import Observation
import SwiftUI

@Observable
class NavigationManager {
	// MARK: Styling
	var columnVisibility = NavigationSplitViewVisibility.all
	var preferredColumn = NavigationSplitViewColumn.sidebar
	
	// MARK: Navigation
	var selectedTab: SidebarTab? = .navigator
	var selectedPage: PageModel?
	var selectedWebsite: WebsiteModel? {
		didSet {
			guard let website = selectedWebsite else { return }
			selectedPage = website.pages.first { $0.isHome } ?? website.pages[0]
		}
	}
	
	var draggingElement: ElementModel? {
		didSet {
			guard let element = draggingElement else { 
				columnVisibility = .all
				return
			}
			columnVisibility = .detailOnly
		}
	}
	var showCommandBar: Bool = false
}
