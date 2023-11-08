//
//  ElementContextMenu.swift
//  Webflow
//
//  Created by Nick Black on 11/1/23.
//

import SwiftUI

enum InteractionTrigger: String, CaseIterable {
	case MouseClick
	case MouseHover
	case MouseOver
	case ScrollIntoView
	case WhileScrollingInView
	case NavbarOpens
	case DropdownOpens
	case TabChange
	case SliderChange
	
	var conditions: [ElementSettingsModel.HTMLTag] {
		switch self {
			case .MouseClick:
				[.Div]
			case .MouseHover:
				[.Div]
			case .MouseOver:
				[.Div]
			case .ScrollIntoView:
				[.Div]
			case .WhileScrollingInView:
				[.Div]
			case .NavbarOpens:
				[.Div]
			case .DropdownOpens:
				[.Div]
			case .TabChange:
				[.Div]
			case .SliderChange:
				[.Div]
		}
	}
}

struct ElementContextMenu: View {
	@Environment(\.modelContext) var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var parents: [ElementModel] = []
	var element: ElementModel
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		let hasClass = !element.classes.isEmpty
		let hasParent = element.parent != nil
		
		Section {
			Menu("Select Parent Element") {
				List(parents, selection: $websiteManager.selectedElement) { element in
					Text(element.name)
				}
			}
		}
		
		Section {
			Menu("Wrap in") {
				Button {
					
				} label: {
					Text("Div Block")
				}
				
				Button {
					
				} label: {
					Text("Link Block")
				}
				
				Button {
					
				} label: {
					Text("V Flex")
				}
				
				Button {
					
				} label: {
					Text("H Flex")
				}
			}
			
			Button {
				
			} label: {
				Text("Unwrap")
			}
		}
		
		Section {
			Button {
				
			} label: {
				Text("Convert to Link Block")
			}
		}
		
		Section {
			Button {
				
			} label: {
				Text("Cut")
			}
	
			
			Button {
				
			} label: {
				Text("Copy")
			}
			
			Button {
				
			} label: {
				Text("Duplicate")
			}
			
			Button {
				modelContext.delete(element)
			} label: {
				Text("Delete")
			}
		}
		
		Section {
			Button {
				
			} label: {
				Text("Add Class...")
			}
			
			Button {
				
			} label: {
				Text("Duplicate Class")
			}
			.disabled(!hasClass)
			
			Button {
				
			} label: {
				Text("Remove Class")
			}
			.disabled(!hasClass)
			
			Button {
				
			} label: {
				Text("Rename Class")
			}
			.disabled(!hasClass)
		}
		
		Section {
			Menu("Add Interaction Trigger") {
				Button {
					
				} label: {
					Text("Add Class...")
				}
			}
		}
		
		Section {
			Button {
				
			} label: {
				Text("Move to parent")
			}
			.disabled(hasParent)
		}
		
		Section {
			Button {
				
			} label: {
				Text("Create component")
			}
		}
		.onAppear {
			getParents(element: element)
		}
	}
	
	func getParents(element: ElementModel) {
		print(element.parent.debugDescription)
		if let parent = element.parent {
			print(parent)
			self.parents.append(parent)
			getParents(element: parent)
		}
	}
}

#Preview {
	@State var selection: Int?
	
	return List(selection: $selection) {
		ForEach(0..<10, id: \.self) { item in
			NavigationLink(value: item) {
				Text("Test")
			}
			.contextMenu(menuItems: {
				ElementContextMenu(element: .init(name: "Test"))
			})
		}
	}
	.listStyle(.sidebar)
	.environment(previewWebsiteManager)
}
