import SwiftUI



struct InspectorStyleView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var displayMode: ElementStyleModel.DisplayLayout = .Block
	@State private var margin: (CGFloat?, CGFloat?, CGFloat?, CGFloat?) = (nil, nil, nil, nil)
	@State private var padding: (CGFloat?, CGFloat?, CGFloat?, CGFloat?) = (nil, nil, nil, nil)
	@State private var inheritingSelectors: Int = 4
	
	var body: some View {
		Section {
			HStack {
				Image(systemName: "square")
				
				Text(websiteManager.selectedElement?.name ?? "None selected")
				
				Spacer()
				
				Button {
					
				} label: {
					Image(systemName: "ellipsis")
				}
			}
			if websiteManager.selectedElement != nil {
				Button("Create component", systemImage: "cube") {
					
				}
				.padding(.vertical, 5)
				.padding(.horizontal)
				.frame(maxWidth: .infinity)
				.background(.thickMaterial)
				.foregroundStyle(.white)
				.clipShape(RoundedRectangle(cornerRadius: 5))
			}
		}
		
		Section {
			TextField("Style selector", text: .constant(""), prompt: Text("None"))
				.textFieldStyle(.roundedBorder)
		} header: {
			HStack {
				Text("Style selector")
				
				Spacer()
				
				Text("Inheriting \(Text("^[\(inheritingSelectors) selector](inflect: true)").foregroundStyle(.orange))")
					.lineLimit(1)
					.font(.caption2)
					
			}
		}
		
		if websiteManager.selectedElement != nil {
			@Bindable var websiteManager = websiteManager
			DisclosureGroup("Layout") {
				Picker("Display", selection: $displayMode) {
					ForEach(ElementStyleModel.DisplayLayout.allCases) { layout in
						Image(systemName: layout.icon)
							.tag(layout)
					}
				}
				.pickerStyle(.segmented)
			}
			
			if let selectedElement = websiteManager.selectedElement, let style = selectedElement.style, let size = style.size {
				InspectorSizeSection(size: size)
			}
			
			DisclosureGroup("Spacing") {
				Picker("Spacing", selection: .constant(ElementStyleModel.DisplayLayout.Block)) {
					ForEach(ElementStyleModel.DisplayLayout.allCases) { layout in
						Image(systemName: layout.icon)
							.tag(layout)
					}
				}
				.pickerStyle(.segmented)
			}
			.onAppear {
				if let selectedElement = websiteManager.selectedElement, let style = selectedElement.style {
					displayMode = style.layout
					
					if let spacing = style.spacing {
						margin = (spacing.marginCenter, spacing.marginRight, spacing.marginLeft, spacing.marginLeft)
						padding = (spacing.paddingCenter, spacing.paddingRight, spacing.paddingBottom, spacing.paddingLeft)
					}
				}
			}
		} else {
			VStack {
				Image("emptyNoSelectionIcon")
				
				Text("Make a selection")
				Text("Select an element on the canvas to activate this panel")
					.foregroundStyle(.secondary)
					.multilineTextAlignment(.center)
			}
			.frame(maxWidth: .infinity)
		}
	}
}

#Preview {
	VStack {
		
	}
	.inspector(isPresented: .constant(true)) {
		Form {
			InspectorStyleView()
				.inspectorColumnWidth(400)
				.environment(previewWebsiteManager)
				.modelContainer(for: ElementModel.self, inMemory: true)
		}
	}
	.toolbar(.hidden)
}
