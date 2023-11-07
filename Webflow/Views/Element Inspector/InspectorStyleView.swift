import SwiftUI
import SwiftData

struct InspectorStyleView: View {
	@Environment(\.modelContext) var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@Query var classes: [ClassModel]
	@State private var isExpanded: Bool = true
	@State private var currentClasses: [ClassModel] = []
	@State private var searchText: String = ""
	@State private var displayMode: ElementStyleModel.Layout = .Block
	@State private var margin: (CGFloat?, CGFloat?, CGFloat?, CGFloat?) = (nil, nil, nil, nil)
	@State private var padding: (CGFloat?, CGFloat?, CGFloat?, CGFloat?) = (nil, nil, nil, nil)
	@State private var inheritingSelectors: Int = 4
	
	
	init(displayMode: ElementStyleModel.Layout = .Block, margin: (CGFloat?, CGFloat?, CGFloat?, CGFloat?) = (nil, nil, nil, nil), padding: (CGFloat?, CGFloat?, CGFloat?, CGFloat?) = (nil, nil, nil, nil), inheritingSelectors: Int = 4) {
		self.displayMode = displayMode
		self.margin = margin
		self.padding = padding
		self.inheritingSelectors = inheritingSelectors
	}
	
	var body: some View {
		ScrollView {
			if let selectedElement = websiteManager.selectedElement {
				@Bindable var selectedElement = selectedElement
				
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
				.padding(.horizontal)
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Divider()
				
				Section {
					CustomSearchBar()
						.padding(.horizontal, -8.0)
						
				} header: {
					HStack {
						Text("Style selector")
						
						Spacer()
						
						if(inheritingSelectors > 0) {
							Text("Inheriting \(Text("^[\(inheritingSelectors) selector](inflect: true)").foregroundStyle(.orange))")
								.lineLimit(1)
								.font(.caption2)
						}
					}
				} footer: {
					Text("1 on this page, 1 on other pages.")
						.font(.caption)
						.foregroundStyle(.secondary)
				}
				.padding(.horizontal)
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Divider()
				
				DisclosureGroup("Layout", isExpanded: $isExpanded) {
					HStack {
						Button("Display") {
							
						}
						.buttonLabel()
						
						Picker("Display", selection: $displayMode) {
							ForEach(ElementStyleModel.Layout.allCases) { layout in
								Image(systemName: layout.icon)
									.tag(layout)
							}
						}
						.pickerStyle(.segmented)
					}
				}
				.padding(.horizontal)
				.tint(.primary)
				
				Divider()
				
				DisclosureGroup("Spacing", isExpanded: $isExpanded) {
					Picker("Spacing", selection: .constant(ElementStyleModel.Layout.Block)) {
						ForEach(ElementStyleModel.Layout.allCases) { layout in
							Image(systemName: layout.icon)
								.tag(layout)
						}
					}
					.pickerStyle(.segmented)
				}
				.padding(.horizontal)
				.tint(.primary)
				
				Divider()
				
				InspectorSizeSection(size: selectedElement.style?.size ?? .init())
					.padding(.horizontal)
					.tint(.primary)
				
				Divider()
				
				InspectorStylePositionSection()
					.padding(.horizontal)
					.tint(.primary)
				
			} else {
				HStack(spacing: 5) {
					Image("AddPanelDivIcon")
						.resizable()
						.frame(width: 25, height: 25)
					
					Text("None selected")
				}
				.padding(.horizontal)
				.frame(maxWidth: .infinity, alignment: .leading)
				.font(.caption)
								
				Divider()
				
				Section {
					TextField("Style selector", text: .constant(""), prompt: Text("None"))
						.textFieldStyle(.roundedBorder)
						.selectionDisabled(true)
					
				} header: {
					Text("Style selector")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				.padding(.horizontal)
				.frame(maxWidth: .infinity, alignment: .leading)
				.font(.callout)

				Divider()
				
				EmptyListView(image: "EmptyNoSelectionIcon", title: "Make a selection", description: "Select an element on the canvas to activate this panel")
					.padding(.horizontal)
			}
		}
		.onAppear {
			if let selectedElement = websiteManager.selectedElement, let style = selectedElement.style, let elementClass = style.elementClass {
				currentClasses = [elementClass]
				
				displayMode = style.layout
				
				if let spacing = style.spacing {
					margin = (spacing.marginTop, spacing.marginRight, spacing.marginLeft, spacing.marginLeft)
					padding = (spacing.paddingTop, spacing.paddingRight, spacing.paddingBottom, spacing.paddingLeft)
				}
			}
		}
		.searchable(
			text: $searchText,
			tokens: $currentClasses,
			placement: .toolbar,
			prompt: Text("Select a class or tag")
		) {
			Text($0.name)
		}
		.onSubmit(of: .search) {
			if searchText.isEmpty { return }
			let newClass = ClassModel(name: searchText)
			
			modelContext.insert(newClass)
		}
	}
}

#Preview("No Selected Element") {
	NavigationSplitView(sidebar: {
		
	}, content: {
		
	}, detail: {
		EmptyView()
			.inspector(isPresented: .constant(true)) {
				Form {
					InspectorStyleView()
						.inspectorColumnWidth(400)
						.environment(previewWebsiteManager)
						.modelContainer(for: ElementModel.self, inMemory: true)
				}
				.formStyle(.columns)
			}
	})
}

#Preview("With Selected Element", body: {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: ClassModel.self, configurations: config)
	let classOne = ClassModel(name: "main")
	container.mainContext.insert(classOne)
	let style = ElementStyleModel(elementClass: classOne)
	container.mainContext.insert(style)
	previewWebsiteManager.selectedElement = .init(name: "Body", style: style)
	let classTwo: ClassModel = .init(name: "loader")
	container.mainContext.insert(classTwo)
	
	return NavigationSplitView(sidebar: {
		
	}, content: {
		
	}, detail: {
		EmptyView()
			.inspector(isPresented: .constant(true)) {
				Form {
					InspectorStyleView()
						.inspectorColumnWidth(400)
						.environment(previewWebsiteManager)
						.modelContainer(container)
				}
				.formStyle(.columns)
			}
	})
})
