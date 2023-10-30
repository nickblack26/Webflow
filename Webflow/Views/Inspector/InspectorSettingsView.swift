//
//  InspectorSettingsVIew.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct InspectorSettingsView: View {
	var body: some View {
		
		TextField("ID", text: .constant(""), prompt: Text("For in-page linking"))
			.textFieldStyle(.automatic)
		
		Picker("Tag", selection: .constant(ElementSettingsModel.ElementSettingsTag.Div)) {
			ForEach(ElementSettingsModel.ElementSettingsTag.allCases, id: \.self) { tag in
				Text(tag.rawValue)
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
		
	}
}

#Preview {
	VStack {
		
	}
	.inspector(isPresented: .constant(true)) {
		Form {
			InspectorSettingsView()
				.inspectorColumnWidth(500)
		}
	}
}
