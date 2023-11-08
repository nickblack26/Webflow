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
				Text("")
			}
			.listRowSeparator(.hidden)
			.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
			.tag(element)
//			.padding(.leading, element.style?.spacing?.paddingLeft ?? 0)
//			.padding(.top, element.style?.spacing?.paddingTop ?? 0)
//			.padding(.trailing, element.style?.spacing?.paddingRight ?? 0)
//			.padding(.bottom, element.style?.spacing?.paddingBottom ?? 0)
//			.frame(
//				minWidth: element.style?.size?.minWidth  ?? nil,
//				maxWidth: element.style?.size?.maxWidth ?? .infinity,
//				minHeight: element.style?.size?.minHeight  ?? 75,
//				maxHeight: element.style?.size?.maxHeight  ?? nil
//			)
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
							Text(element.name)
								.font(.caption)
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
							.buttonStyle(.bordered)
							.tint(.orange)
						}
					}
					.offset(y: -26.0)
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
