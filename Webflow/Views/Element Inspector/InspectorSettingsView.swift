//
//  InspectorSettingsVIew.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct InspectorSettingsView: View {
	@Environment(WebsiteManager.self) private var websiteManager

	var body: some View {
		List {
			if let selectedElement = websiteManager.selectedElement {
				Section {
					HStack {
						Image(systemName: "square")
						
						Text(websiteManager.selectedElement == nil ? "None selected" : "\(websiteManager.selectedElement?.name ?? "") Styles")
					}
					
					Button {
						
					} label: {
						HStack {
							Image("ElementSymbolIcon")
							Text("Create component")
						}
						.frame(maxWidth: .infinity)
					}
					.buttonStyle(.borderedProminent)
					.tint(.background2)
				}
//				.listRowSeparator(.hidden)
				
				Section {
					HStack {
						Text("ID")
						
						TextField("ID", text: .constant(""), prompt: Text("For in-page linking"))
							.textFieldStyle(.roundedBorder)
					}
					
					HStack {
	//					Text("Tag")
						
						Picker("Tag", selection: .constant(ElementSettingsModel.HTMLTag.Div)) {
							ForEach(ElementSettingsModel.HTMLTag.allCases, id: \.self) { tag in
								Text(tag.rawValue)
							}
						}
					}
				}
				
				Section("Visibility & User access") {
					VStack {
						Picker("Visibility", selection: .constant("visible")) {
							Text("Visible")
								.tag("visible")
							
							Text("Hidden")
								.tag("hidden")
						}
						.pickerStyle(.segmented)
						
						VStack {
							Text("None")
								.frame(maxWidth: .infinity)
						}
						.padding(.vertical, 5)
						.padding(.horizontal)
						.overlay(
							RoundedRectangle(cornerRadius: 5)
								.stroke(.gray, lineWidth: 1)
						)
					}
				}
				
				Section("Custom attributes") {
					VStack {
						HStack {
							Text("Custom Attributes")
							Spacer()
							Button {
								
							} label: {
								Image(systemName: "plus")
							}
						}
						
						VStack {
							Text("None")
								.frame(maxWidth: .infinity)
						}
						.padding(.vertical, 5)
						.padding(.horizontal)
						.overlay(
							RoundedRectangle(cornerRadius: 5)
								.stroke(.gray, lineWidth: 1)
						)
					}
				}
				
				Section("Search index settings") {
					Toggle(isOn: .constant(true), label: {
						HStack {
							Image(systemName: "minus.magnifyingglass")
							Text("Label")
						}
					})
					.toggleStyle(.automatic)
				}
			} else {
				HStack(spacing: 5) {
					Image("AddPanelDivIcon")
						.resizable()
						.frame(width: 16, height: 16)
					
					Text("None selected")
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.font(.caption)
				
				EmptyListView(image: "EmptyNoSelectionIcon", title: "Make a selection", description: "Select an element on the canvas to activate this panel")
					.listRowSeparator(.hidden)
			}
		}
		.listStyle(.plain)
		.scrollContentBackground(.hidden)
		.background(Color("Background"), ignoresSafeAreaEdges: .all)
	}
}

#Preview {
	VStack(spacing: 0) {
		EditorToolbar()
		
		Divider()
		
		NavigationSplitView(sidebar: {
			
		}, content: {
			
		}, detail: {
			EmptyView()
		})
		.inspector(isPresented: .constant(true)) {
			Form {
				InspectorSettingsView()
					.inspectorColumnWidth(400)
			}
			.formStyle(.columns)
		}
	}
	.environment(previewWebsiteManager)
}
