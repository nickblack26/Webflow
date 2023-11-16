//
//  ToolbarDelegate.swift
//  Webflow
//
//  Created by Nick Black on 11/9/23.
//

import UIKit

class ToolbarDelegate: NSObject {

}

#if targetEnvironment(macCatalyst)
extension ToolbarDelegate: NSToolbarDelegate {
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		let identifiers: [NSToolbarItem.Identifier] = [
			.toggleSidebar
		]
		return identifiers
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarDefaultItemIdentifiers(toolbar)
	}
}
#endif
