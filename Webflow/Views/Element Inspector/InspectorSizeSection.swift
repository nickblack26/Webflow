//
//  InspectorSizeSection.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct InspectorSizeSection: View {
	@State private var ratio: ElementStyleModel.Ratio = .Auto
	@State private var overflow: ElementStyleModel.Overflow = .Visible
	@State private var isExpanded: Bool = true
	@Bindable var size: SizeModel
	
	let formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter
	}()
	
	var body: some View {
		DisclosureGroup("Size", isExpanded: $isExpanded) {
			LazyVGrid(columns: [GridItem(), GridItem()]) {
				HStack {
					Text("Width")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField("Width", value: $size.width, formatter: formatter, prompt: Text("Auto"))
						.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Height")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField("Height", value: $size.height, formatter: formatter, prompt: Text("Auto"))
						.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Min W")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField("Min W", value: $size.minWidth, formatter: formatter, prompt: Text("0"))
						.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Min H")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField("Min H", value: $size.minHeight, formatter: formatter, prompt: Text("0"))
						.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Max W")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField("Max W", value: $size.maxWidth, formatter: formatter, prompt: Text("None"))
						.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Max H")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField("Max H", value: $size.maxHeight, formatter: formatter, prompt: Text("None"))
						.textFieldStyle(.roundedBorder)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			Divider()
			
			HStack {
				Text("Ratio")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(minWidth: 50, alignment: .leading)

				
				Picker(selection: $ratio) {
					ForEach(ElementStyleModel.Ratio.allCases, id: \.self) { ratio in
						Text(ratio.rawValue)
					}
				} label: {
					HStack {
						Text(ratio.rawValue)
						
						Spacer()
						
						Image("chevronDown")
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				.pickerStyle(.menu)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			HStack {
				Text("Overflow")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(minWidth: 50, alignment: .leading)

				
				Picker("Overflow", selection: $overflow) {
					ForEach(ElementStyleModel.Overflow.allCases, id: \.self) { overflow in
						if(overflow.icon.isEmpty) {
							Text("Auto")
								.tag(overflow)
						} else {
							Image(overflow.icon)
								.tag(overflow)
						}
					}
				}
				.pickerStyle(.segmented)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			HStack {
				Text("Fit")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(minWidth: 50, alignment: .leading)

				
				Picker("Fit", selection: $overflow) {
					ForEach(ElementStyleModel.Fit.allCases, id: \.self) { overflow in
						Text(overflow.rawValue)
					}
				}
				.pickerStyle(.menu)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
		
    }
	
}

#Preview {
	InspectorSizeSection(size: .init())
		.modelContainer(for: SizeModel.self, inMemory: true)
}
