//
//  NavigatorListItem.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

struct NavigatorListItemView: View {
	@Environment(\.modelContext) var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	var element: ElementModel
	
	var body: some View {
		if let children = element.children, !children.isEmpty {
			DisclosureGroup(
				content: {
					ForEach(children) { childElement in
						NavigatorListItemView(element: childElement)
					}
				}, label: {
					HStack {
						Image(systemName: "square")
						Text(element.name)
						
						Spacer()
						
						if let style = element.style, style.layout == .Hidden {
							Image(systemName: "eye.slash")
						}
					}
					.contextMenu(ContextMenu(menuItems: {
						ElementContextMenu(element: element)
					}))
				}
			)
		} else {
			HStack {
				Image(systemName: "square")
				Text(element.name)
				
				Spacer()
				
				if let style = element.style, style.layout == .Hidden {
					Image(systemName: "eye.slash")
				}
			}
			.contextMenu(ContextMenu(menuItems: {
				ElementContextMenu(element: element)
			}))
		}
	}
}

#Preview {
	NavigatorListItemView(element: .init(name: "Body"))
	//		.modelContainer(for: Item.self, inMemory: true)
}
