//
//  ElementContextMenu.swift
//  Webflow
//
//  Created by Nick Black on 11/1/23.
//

import SwiftUI
import UniformTypeIdentifiers

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
		let hasGrandparent = element.parent != nil && element.parent?.parent != nil
		
		Section {
			Menu("Select Parent Element") {
				ForEach(element.getAllParents()) { element in
					Button {
						websiteManager.selectedElement = element
					} label: {
						Text(element.name)
							.badge(Text("\(Image(element.settings?.tag.icon ?? "ElementDivIcon"))"))
					}
				}
			}
		}
		
		Section {
			Menu("Wrap in") {
				Button {
					if let parent = element.parent {
						let newElement = ElementModel(name: "Div Block", tag: .Div, children: [element])
						modelContext.insert(newElement)
						parent.children?.append(newElement)
					}
					
				} label: {
					Text("Div Block")
				}
				
				Button {
					if let parent = element.parent {
						let newElement = ElementModel(name: "Link Block", tag: .A, children: [element])
						modelContext.insert(newElement)
						parent.children?.append(newElement)
					}
					
				} label: {
					Text("Link Block")
				}
				
				Button {
					if let parent = element.parent {
						let newElement = ElementModel(name: "V Flex", tag: .Div, style: .init(display: .Flex), children: [element])
						
						modelContext.insert(newElement)
						parent.children?.append(newElement)
					}
				} label: {
					Text("V Flex")
				}
				
				Button {
					if let parent = element.parent {
						let newElement = ElementModel(name: "H Flex", tag: .Div, style: .init(display: .Flex), children: [element])
						
						modelContext.insert(newElement)
						parent.children?.append(newElement)
					}
				} label: {
					Text("H Flex")
				}
			}
			
			Button {
				element.unWrapElement()
				modelContext.delete(element)
			} label: {
				Text("Unwrap")
			}
		}
		
		Section {
			Button {
				element.tag = .A
			} label: {
				Text("Convert to Link Block")
			}
		}
		
		Section {
			Button {
				UIPasteboard.general.setValue(element, forPasteboardType: UTType.data.identifier)
			} label: {
				Text("Cut")
			}
			
			Button {
				UIPasteboard.general.setValue(element, forPasteboardType: UTType.data.identifier)
			} label: {
				Text("Copy")
			}
			
			Button {
				let duplicateElement = ElementModel(backingData: element.persistentBackingData)
				modelContext.insert(duplicateElement)
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
				element.classes.remove(at: 0)
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
				ForEach(InteractionTrigger.allCases, id: \.self) { trigger in
					Button(trigger.rawValue) {
						
					}
				}
			}
		}
		
		Section {
			Button {
				element.moveToParent()
				try? modelContext.save()
			} label: {
				Text("Move to parent")
			}
			.disabled(!hasGrandparent)
		}
		
		Section {
			Button {
				
			} label: {
				Text("Create component")
			}
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
