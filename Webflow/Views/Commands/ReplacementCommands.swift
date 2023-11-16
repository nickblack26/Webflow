import SwiftUI

struct ReplacementCommands: Commands {
	var body: some Commands {
		CommandGroup(replacing: .sidebar) {
			Button("Show Sidebar") {
				print("Showing Sidebar")
			}
			.keyboardShortcut("s")
		}
		
		CommandGroup(replacing: .newItem) {
			Button("New") {
				print("New")
			}
		}
		
		CommandGroup(replacing: .saveItem) {
			Button("Save") {
				print("Save")
			}
		}
	}
}
