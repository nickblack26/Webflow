//
//  InspectorSizeSection.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct InspectorSizeSection: View {
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
				TextField("Width", value: $size.width, formatter: formatter, prompt: Text("Auto"))
				TextField("Height", value: $size.height, formatter: formatter, prompt: Text("Auto"))
				TextField("Min W", value: $size.minWidth, formatter: formatter, prompt: Text("0"))
				TextField("Min H", value: $size.minHeight, formatter: formatter, prompt: Text("0"))
				TextField("Max W", value: $size.maxWidth, formatter: formatter, prompt: Text("None"))
				TextField("Max H", value: $size.maxHeight, formatter: formatter, prompt: Text("None"))
			}
		}
    }
}

#Preview {
	InspectorSizeSection(size: .init())
		.modelContainer(for: SizeModel.self, inMemory: true)
}
