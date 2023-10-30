//
//  ElementView.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import SwiftUI

struct ElementView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var hovering: Bool = false
	var element: ElementModel
	
	var body: some View {
		var isSelectedElement: Bool {
			websiteManager.selectedElement == element
		}
		var isEmptyElement: Bool {
			element.childElements.isEmpty && element.style == nil && element.classes.isEmpty
		}
		
		ZStack(alignment: .topLeading) {
			if !element.childElements.isEmpty {
				ForEach(element.childElements) { childElement in
					ElementView(element: childElement)
				}
			} else {
				NavigationLink(value: element) {
					Text("")
						.font(.largeTitle)
						.border(hovering ? .blue : .clear, width: 1)
				}
				.padding(.all, 1)
				.border(isSelectedElement ? Color.accentColor : .gray)
				.frame(
					minWidth: isEmptyElement ? nil : element.style?.size?.minWidth,
					maxWidth: isEmptyElement ? .infinity : element.style?.size?.maxWidth,
					minHeight: isEmptyElement ? 75 : element.style?.size?.minHeight,
					maxHeight: isEmptyElement ? nil : element.style?.size?.maxHeight
				)
			}
			
			if (hovering || isSelectedElement) {
				HStack {
					Image(systemName: "square")
					Text(element.name)
				}
				.padding(2.5)
				.background(.blue)
				.foregroundStyle(.white)
				.clipShape(UnevenRoundedRectangle(topLeadingRadius: 2.5, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 2.5, style: .continuous))
				.frame(height: 25)
				.frame(maxWidth: .infinity, alignment: .leading)
				.animation(.default, value: hovering)
				.offset(y: -25.0)
			}
		}
		.buttonStyle(.plain)
		.onHover(perform: {
			hovering = $0
		})
		.contextMenu(menuItems: {
			Label("Cut", systemImage: "scissors")
			
			Label("Copy", systemImage: "square.on.square")
			
			Label("Duplicate", systemImage: "plus.square.on.square")
			
			
		
			Button {
				
			} label: {
				Label("Delete", systemImage: "trash")
			}
		})
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
