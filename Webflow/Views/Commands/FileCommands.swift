//
//  FileCommands.swift
//  Webflow
//
//  Created by Nick Black on 11/9/23.
//

import SwiftUI

struct FileCommands: Commands {
    var body: some Commands {
		CommandGroup(replacing: .newItem) {
			Button("Newest Item") {
				print("Newest Item")
			}
			.keyboardShortcut("N")
		}
    }
}
