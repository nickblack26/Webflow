import SwiftUI
import SwiftData

struct InspectorStyleView: View {
	@Environment(\.modelContext) var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@Query var classes: [ClassModel]
	@State private var isExpanded: Bool = true
	@State private var currentClasses: [ClassModel] = [] {
		didSet {
			guard let selectedElement = websiteManager.selectedElement else { return }
			selectedElement.classes = currentClasses
			
			do {
				try modelContext.save()
			} catch {
				print(error)
			}
		}
	}
	@State private var searchText: String = ""
	@State private var displayMode: ElementStyleModel.Display = .Block
	@State private var margin: (CGFloat?, CGFloat?, CGFloat?, CGFloat?)?
	@State private var padding: (CGFloat?, CGFloat?, CGFloat?, CGFloat?)?
	@State private var inheritingSelectors: Int = 4
	@Binding var selectedTab: InspectorTab
	
	init(selectedTab: Binding<InspectorTab>, displayMode: ElementStyleModel.Display = .Block, margin: (CGFloat?, CGFloat?, CGFloat?, CGFloat?)? = nil, padding: (CGFloat?, CGFloat?, CGFloat?, CGFloat?)? = nil, inheritingSelectors: Int = 4) {
		self._selectedTab = selectedTab
		self.displayMode = displayMode
		self.margin = margin
		self.padding = padding
		self.inheritingSelectors = inheritingSelectors
	}
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		var availableClasses: [ClassModel] = classes.filter { !currentClasses.contains($0) }
		List {
			if let selectedElement = websiteManager.selectedElement {
				@Bindable var selectedElement = selectedElement
				
				Section {
					HStack {
						Image(systemName: "square")
						
						if selectedElement.classes.isEmpty {
							Text(websiteManager.selectedElement == nil ? "None selected" : "\(websiteManager.selectedElement?.name ?? "") Styles")
						} else {
							Text(selectedElement.classes[0].name)
						}
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
				.listRowSeparator(.hidden)
				
				Section {
					CustomSearchBar(currentClasses: currentClasses, allClasses: availableClasses)
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
				.listRowSeparator(.hidden)
				
				DisclosureGroup("Layout", isExpanded: $isExpanded) {
					HStack {
						Button("Display") {
							
						}
						.buttonLabel()
												
						Picker("Display", selection: Binding<ElementStyleModel.Display>(
								get: {
									return selectedElement.style?.display ?? ElementStyleModel.Display.Block
								},
								set: { layout in
								if let style = selectedElement.style {
									style.display = layout
								} else {
									let styleElement = ElementStyleModel(display: layout)
									selectedElement.style = styleElement
								}
								try? modelContext.save()
							}
						)
						) {
							ForEach(ElementStyleModel.Display.allCases) { layout in
								Image(systemName: layout.icon)
									.tag(layout)
							}
						}
						.pickerStyle(.segmented)
					}
					.listRowSeparator(.hidden)
				}
				
				DisclosureGroup("Spacing", isExpanded: $isExpanded) {

				}
				.tint(.primary)
								
				InspectorSizeSection(element: selectedElement)
					.tint(.primary)
				
				InspectorStylePositionSection()
					.tint(.primary)
			} else {
				HStack(spacing: 5) {
					Image("AddPanelDivIcon")
						.resizable()
						.frame(width: 25, height: 25)
					
					Text("None selected")
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.font(.caption)
				.listRowBackground(EmptyView())
				.listRowSeparator(.hidden)
				
				Section {
					TextField("Style selector", text: .constant(""), prompt: Text("None"))
						.textFieldStyle(.roundedBorder)
						.selectionDisabled(true)
					
				} header: {
					Text("Style selector")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.font(.callout)
				.listRowBackground(EmptyView())
				.listRowSeparator(.hidden)
				
				EmptyListView(image: "EmptyNoSelectionIcon", title: "Make a selection", description: "Select an element on the canvas to activate this panel")
					.listRowBackground(EmptyView())
					.listRowSeparator(.hidden)
				
			}
		}
		.listStyle(.plain)
		.scrollContentBackground(.hidden)
		.background(Color("Background"))
		.searchable(
			text: $searchText,
			tokens: $currentClasses,
			suggestedTokens: .constant(classes),
			token: {
			Text($0.name)
		})
		.onSubmit(of: .search) {
			guard let selectedElement = websiteManager.selectedElement else { return }
			if searchText.isEmpty { return }
			
			let filteredClass = classes.first { $0.name.localizedCaseInsensitiveContains(searchText) }
			
			if let filteredClass {
				currentClasses.append(filteredClass)
			} else {
				let newClass = ClassModel(name: searchText)
				modelContext.insert(newClass)
				
				currentClasses.append(newClass)
				
				@Bindable var element = selectedElement
				
				element.classes.append(newClass)
			}
			
			do {
				try modelContext.save()
			} catch {
				print(error)
			}
			
			searchText = ""
		}
		.onAppear {
			if let selectedElement = websiteManager.selectedElement, let style = selectedElement.style, let elementClasses = style.classes {
				currentClasses = elementClasses
				
				displayMode = style.display ?? .Block
				
				if let spacing = style.spacing {
					margin = (spacing.marginTop, spacing.marginRight, spacing.marginLeft, spacing.marginLeft)
					padding = (spacing.paddingTop, spacing.paddingRight, spacing.paddingBottom, spacing.paddingLeft)
				}
			}
		}
		.toolbar {
			InspectorToolbarView(selectedTab: $selectedTab)
		}
		.onChange(of: websiteManager.selectedElement) { oldValue, newValue in
			currentClasses = newValue?.classes ?? []
		}
	}
}

#Preview("No Selected Element") {
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
				InspectorStyleView(selectedTab: .constant(InspectorTab.Style))
					.inspectorColumnWidth(400)
			}
			.formStyle(.columns)
		}
	}
	.environment(previewWebsiteManager)
	.modelContainer(for: ElementModel.self, inMemory: true)
}

#Preview("With Selected Element", body: {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: ClassModel.self, configurations: config)
	let classOne = ClassModel(name: "main")
	container.mainContext.insert(classOne)
	
	let style = ElementStyleModel(classes: [classOne])
	container.mainContext.insert(style)
	previewWebsiteManager.selectedElement = .init(name: "Body", style: style)
	let classTwo: ClassModel = .init(name: "loader")
	container.mainContext.insert(classTwo)
	
	return VStack(spacing: 0) {
		EditorToolbar()
		
		Divider()
		
		NavigationSplitView(sidebar: {
			
		}, content: {
			
		}, detail: {
			EmptyView()
		})
		.inspector(isPresented: .constant(true)) {
			Form {
				InspectorStyleView(selectedTab: .constant(InspectorTab.Style))
					.inspectorColumnWidth(400)
			}
			.formStyle(.columns)
		}
	}
	.environment(previewWebsiteManager)
	.modelContainer(for: ElementModel.self, inMemory: true)
})
