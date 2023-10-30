//
//  NavigatorListItem.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

struct NavigatorListItemView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	var element: ElementModel
	
	var body: some View {
		if !element.childElements.isEmpty {
			DisclosureGroup(
				content: {
					ForEach(element.childElements) { childElement in
						NavigatorListItemView(element: childElement)
					}
				}, label: {
					NavigationLink(value: element) {
						HStack {
							Image(systemName: "square")
							Text(element.name)
							
							Spacer()
							
							if let style = element.style, style.layout == .Hidden {
								Image(systemName: "eye.slash")
							}
						}
					}
				}
			)
		} else {
			NavigationLink(value: element) {
				HStack {
					Image(systemName: "square")
					Text(element.name)
					
					Spacer()
					
					if let style = element.style, style.layout == .Hidden {
						Image(systemName: "eye.slash")
					}
				}
			}
		}
	}
}

#Preview {
	NavigatorListItemView(element: .init(name: "Body"))
//		.modelContainer(for: Item.self, inMemory: true)
}
