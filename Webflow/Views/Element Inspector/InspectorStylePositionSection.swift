//
//  InspectorStylePositionSection.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import SwiftUI

struct InspectorStylePositionSection: View {
	@State private var isExpanded: Bool = true
	@State private var position: ElementStyleModel.Position = .Static
	@State private var float: ElementStyleModel.Float = .None
	@State private var clear: ElementStyleModel.Clear = .None
	
    var body: some View {
		DisclosureGroup("Position", isExpanded: $isExpanded) {
			HStack {
				Text("Position")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(minWidth: 40, alignment: .leading)

				
				Picker("Position", selection: $position) {
					ForEach(ElementStyleModel.Position.allCases, id: \.self) {
						Text($0.rawValue)
							.tag($0)
					}
				}
			}
			
			DisclosureGroup(
				isExpanded: .constant(true),
				content: {
					HStack {
						Text("Float")
							.font(.caption)
							.foregroundStyle(.secondary)
							.frame(minWidth: 40, alignment: .leading)

						
						Picker("Float", selection: $clear) {
							ForEach(ElementStyleModel.Float.allCases, id: \.self) {
								Text($0.rawValue)
									.tag($0)
							}
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					
					HStack {
						Text("Clear")
							.font(.caption)
							.foregroundStyle(.secondary)
							.frame(minWidth: 40, alignment: .leading)

						
						Picker("Clear", selection: $clear) {
							ForEach(ElementStyleModel.Float.allCases, id: \.self) {
								Text($0.rawValue)
									.tag($0)
							}
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				},
				label: {
					Button {
						
					} label: {
						Text("Float and clear")
					}
				}
			)
		}
    }
}

#Preview {
    InspectorStylePositionSection()
}
