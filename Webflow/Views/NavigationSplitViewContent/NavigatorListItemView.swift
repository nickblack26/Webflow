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
		let isCurrent: Bool = element.id == websiteManager.selectedElement?.id
		
		if let children = element.children, !children.isEmpty {
			DisclosureGroup(
				content: {
					ForEach(children) { childElement in
						NavigatorListItemView(element: childElement)
					}
				}, 
				label: {
					HStack {
						Image(element.settings?.tag.icon ?? "ElementDivIcon")
							.resizable()
							.frame(width: 16, height: 16)
						
						if element.classes.isEmpty {
							Text(element.name)
								.lineLimit(1)
						} else {
							Text(element.classes[0].name)
								.lineLimit(1)
						}
					}
					.contextMenu(menuItems: {
						ElementContextMenu(element: element)
					})
					.listItemTint(isCurrent ? .accentColorForeground : .primary)
					.foregroundStyle(isCurrent ? .accentColorForeground : .primary)
					.listRowBackground(
						Rectangle()
							.fill(isCurrent ? .chartDataSeriesD2BlueA20 : .clear)
					)
					.listRowSeparator(.hidden)
				}
			)
			.tag(element)
			.listItemTint(isCurrent ? .accentColorForeground : .primary)
			.foregroundStyle(isCurrent ? .accentColorForeground : .primary)
			.listRowBackground(
				Rectangle()
					.fill(isCurrent ? .chartDataSeriesD2BlueA20 : .clear)
			)
			.listRowSeparator(.hidden)
			
		} else {
			HStack {
				Image(element.settings?.tag.icon ?? "ElementDivIcon")
					.resizable()
					.frame(width: 16, height: 16)
				
				if element.classes.isEmpty {
					Text(element.name)
						.lineLimit(1)
				} else {
					Text(element.classes[0].name)
						.lineLimit(1)
				}
			}
			.contextMenu(menuItems: {
				ElementContextMenu(element: element)
			})
			.tag(element)
			.listItemTint(isCurrent ? .accentColorForeground : .primary)
			.foregroundStyle(isCurrent ? .accentColorForeground : .primary)
			.listRowBackground(
				Rectangle()
					.fill(isCurrent ? .chartDataSeriesD2BlueA20 : .clear)
			)
			.listRowSeparator(.hidden)
		}
	}
}

#Preview {
	NavigatorListItemView(element: .init(name: "Body"))
}
