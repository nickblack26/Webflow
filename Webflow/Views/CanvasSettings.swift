//
//  CanvasSettings.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct CanvasSettings: View {
	var body: some View {
		Form {
			Text("Canvas settings")
				.font(.title3)
			
			Section {
				HStack {
					TextField("Width", value: .constant(992), format: .number)

					TextField("Scale", value: .constant(90.6), format: .number)
						
					Button {
						
					} label: {
						Image(systemName: "arrow.up.backward.and.arrow.down.forward.square")
					}
				}
			}
			
			Section {
				Toggle(isOn: .constant(true), label: {
					HStack {
						Text("Show element edges")
						Spacer()
						Text("⌘↑E")
					}
				})
//				.toggleStyle(.checkbox)
				
				Toggle(isOn: .constant(true), label: {
					HStack {
						Text("Show empty elements")
						Spacer()
						Text("⌘↑M")
					}
				})
//				.toggleStyle(.checkbox)
				
				Toggle(isOn: .constant(true), label: {
					HStack {
						Text("X-ray mode")
						Spacer()
						Text("⌘↑X")
					}
				})
//				.toggleStyle(.checkbox)
				
				Picker("Guide", selection: .constant("No guide")) {
					Text("No guide")
						.tag("No guide")

					Text("Line guide (960px)")
						.tag("Line guide")
					
					Text("Filled guide (960px)")
						.tag("Filled guide")
				}
				.pickerStyle(.menu)
			}
			
			Section("Vision preview") {
				
			}
		}
		.formStyle(.grouped)
	}
}

#Preview {
	CanvasSettings()
}
