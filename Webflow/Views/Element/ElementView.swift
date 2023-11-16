import SwiftUI

struct ElementView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var hovering: Bool = false
	@Bindable var element: ElementModel
	
	var body: some View {
		var isSelectedElement: Bool {
			websiteManager.selectedElement == element
		}
		
		var isEmptyElement: Bool {
			element.children == nil && element.style == nil && element.classes.isEmpty
		}
		
		if let children = element.children, !children.isEmpty {
			ForEach(children) { child in
				ElementView(element: child)
			}
		} else {
			ZStack {
				Text("Hello")
			}
			.tag(element)
			.listRowSeparator(.hidden)
			.listRowInsets(
				EdgeInsets(
					top: element.style?.spacing?.marginTop ?? 0,
					leading: element.style?.spacing?.marginLeft ?? 0,
					bottom: element.style?.spacing?.marginBottom ?? 0,
					trailing: element.style?.spacing?.marginRight ?? 0
				)
			)
			.padding(
				EdgeInsets(
					top: element.style?.spacing?.paddingTop ?? 0,
					leading: element.style?.spacing?.paddingLeft ?? 0,
					bottom: element.style?.spacing?.paddingBottom ?? 0,
					trailing: element.style?.spacing?.paddingRight ?? 0
				)
			)
			.frame(
				minWidth: element.style?.size?.minWidth,
				idealWidth: element.style?.size?.width,
				maxWidth: element.style?.size?.maxWidth ?? .infinity,
				minHeight: element.style?.size?.minHeight  ?? 75,
				idealHeight: element.style?.size?.height,
				maxHeight: element.style?.size?.maxHeight,
				alignment: element.style?.display?.alignment ?? .leading
			)
			.background {
				Rectangle()
					.fill(.clear)
					.border(.gray.opacity(0.5), width: 3)
			}
			.padding(1)
			.background {
				if isSelectedElement || hovering {
					Rectangle()
						.stroke(.accent, style: StrokeStyle(lineWidth: 1))
				} else {
					Rectangle()
						.strokeBorder(.secondary, style: StrokeStyle(dash: [5]))
				}
			}
			.contextMenu(menuItems: {
				ElementContextMenu(element: element)
			})
			.overlay(alignment: .topLeading, content: {
				if (hovering || isSelectedElement) {
					HStack {
						Button {
							
						} label: {
							Image(systemName: "square")
							if let selectedElement = websiteManager.selectedElement {
								if selectedElement.classes.isEmpty {
									Text(element.name)
										.font(.caption)
								} else {
									Text(selectedElement.classes[0].name)
										.font(.caption)
								}
							}
						}
						.buttonStyle(.borderedProminent)
						.tint(.accent)
						.frame(maxWidth: .infinity, alignment: .leading)
						
						if isSelectedElement {
							Spacer()
							
							Button {
								
							} label: {
								VStack(spacing: 3) {
									Divider()
										.frame(height: 2)
									
									Divider()
										.frame(height: 2)
									
									Divider()
										.frame(height: 2)
								}
								.frame(width: 16, height: 16)
								
								Text("Align")
									.font(.caption)
								
								Image("chevronDown")
							}
							.buttonStyle(.borderedProminent)
							.tint(.orange)
							.offset(y: -12)
						}
					}
					.offset(y: -36)
					.contentShape(Rectangle())
				}
				
			})
			.dropDestination(for: ElementModel.self) { items, location in
				let elements: [ElementModel] = items.compactMap { element in
					ElementModel(name: element.name)
				}
				element.children?.append(contentsOf: elements)
				try? modelContext.save()
				websiteManager.draggingElement = nil
				return false
			} isTargeted: { isTargeted in
				websiteManager.draggingElement = nil
				hovering = isTargeted
			}
			.onHover(perform: {
				hovering = $0
			})
			.contentShape(Rectangle())
		}
	}
	
	private func delete() {
		websiteManager.selectedElement = nil
		modelContext.delete(element)
	}
}

#Preview {
	ElementView(element: .init(name: "Section"))
		.environment(previewWebsiteManager)
}
