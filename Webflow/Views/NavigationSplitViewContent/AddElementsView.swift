//
//  AddElementsView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct AddElementsView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@Environment(NavigationManager.self) private var navigation
	@State private var searchText: String = ""
	@State private var selection: String = "elements"
	@Binding var selectedPage: PageModel?
	
    var body: some View {
		@Bindable var navigation = navigation
		
		List {
			Picker("Type", selection: $selection) {
				Text("Elements")
					.tag("elements")
				
				Text("Layouts")
					.tag("layouts")
			}
			.pickerStyle(.segmented)
			.listRowBackground(EmptyView())
			
			Section("Structure") {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
					ForEach(DefaultStructureElement.allCases, id: \.self) { element in
						Button {
							addElement()
						} label: {
							PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
						}
						.buttonStyle(.plain)
					}
				}
			}
			.listRowBackground(EmptyView())
			
			Section("Basic") {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
					ForEach(DefaultBasicElement.allCases, id: \.self) { element in
						Button {
							addElement()
						} label: {
							PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
						}
						.buttonStyle(.plain)
					}
				}
			}
			.listRowBackground(EmptyView())
			
			Section("Typography") {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
					ForEach(DefaultTypographyElement.allCases, id: \.self) { element in
						Button {
							addElement()
						} label: {
							PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
						}
						.buttonStyle(.plain)
					}
				}
			}
			.listRowBackground(EmptyView())
			
			Section("CMS") {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
					ForEach(DefaultStructureElement.allCases, id: \.self) { element in
						Button {
							addElement()
						} label: {
							PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
						}
						.buttonStyle(.plain)
					}
				}
			}
			.listRowBackground(EmptyView())
			
			Section("Media") {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
					ForEach(DefaultStructureElement.allCases, id: \.self) { element in
						Button {
							addElement()
						} label: {
							PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
						}
						.buttonStyle(.plain)
					}
				}
			}
			.listRowBackground(EmptyView())
			
			Section("Forms") {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
					ForEach(DefaultStructureElement.allCases, id: \.self) { element in
						Button {
							addElement()
						} label: {
							PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
						}
						.buttonStyle(.plain)
					}
				}
			}
			.listRowBackground(EmptyView())
			
			Section("Advanced") {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
					ForEach(DefaultStructureElement.allCases, id: \.self) { element in
						Button {
							addElement()
						} label: {
							PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
						}
						.buttonStyle(.plain)
					}
				}
			}
			.listRowBackground(EmptyView())
		}
		.scrollContentBackground(.hidden)
		.background(Color("Background"), ignoresSafeAreaEdges: .all)
		.listStyle(.plain)
		.searchable(text: $searchText, prompt: "Search pages")
		.foregroundStyle(.primary)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				Text("Add")
			}
		}
    }
	
	private func addElement() {
		let element = ElementModel(name: "Div Block")
		
		if let selectedElement = websiteManager.selectedElement {
			selectedElement.children?.append(element)
		} else {
			if let selectedPage = navigation.selectedPage {
				selectedPage.body.children?.append(element)
			}
		}
	}
}

#Preview {
	NavigationSplitView {
	} content: {
		AddElementsView(selectedPage: .constant(.init(name: "Test", index: 1)))
			.environment(previewWebsiteManager)		
	} detail: {
		
	}
}
