//
//  ViewCommands.swift
//  Webflow
//
//  Created by Nick Black on 11/9/23.
//

import SwiftUI

struct ViewCommands: Commands {
	@Environment(NavigationManager.self) private var navigation
	
    var body: some Commands {
		CommandMenu("Sidebar") {
			Button("Add Elements") {
				navigation.selectedTab = .Add
			}
			.keyboardShortcut("a")
			
			Button("Pages") {
				navigation.selectedTab = .pages
			}
			.keyboardShortcut("p")
			
			Button("Navigator") {
				navigation.selectedTab = .navigator
			}
			
			Divider()
					
			Button("Components") {
				navigation.selectedTab = .components
			}
			.keyboardShortcut("a", modifiers: .shift)
			
			Button("Variables") {
				navigation.selectedTab = .variables
			}
		
			Button("Style Selectors") {
				navigation.selectedTab = .styleSelectors
			}
		
			Button("Assets") {
				navigation.selectedTab = .assets
			}
			
			Divider()
			
			Button("CMS") {
				navigation.selectedTab = .cms
			}
			
			Button("Logic") {
				navigation.selectedTab = .logic
			}
			
			Button("Users") {
				navigation.selectedTab = .users
			}
			
			Button("Ecommerce") {
				navigation.selectedTab = .ecommerce
			}
			
			Button("Apps") {
				navigation.selectedTab = .apps
			}
			
			Divider()
			
			Button("Settings") {
				print("Hello")
			}
			
			Button("Help") {
				print("Hello")
			}
			
			Button("Audits") {
				print("Hello")
			}
			
			Button("Find Anything") {
				print("Hello")
			}
			
			Button("Video Tutorials") {
				print("Hello")
			}
		}
    }
}
