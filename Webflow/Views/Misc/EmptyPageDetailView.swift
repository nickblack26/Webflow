//
//  EmptyPageDetailView.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct EmptyPageDetailView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@Environment(NavigationManager.self) private var navigation
	
	var body: some View {
		VStack {
			Spacer()
			
			HStack {
				Spacer()
				
				Button {
					
				} label: {
					Label("Add a layout", systemImage: "plus")
				}
				.buttonStyle(.bordered)
				.tint(.accent)
				
				Spacer()
			}
			
			Spacer()
		}
		.background {
			Rectangle()
				.fill(.clear)
				.border(.gray.opacity(0.5), width: 5)
		}
		.padding(2)
		.background {
			Rectangle()
				.strokeBorder(.secondary, style: StrokeStyle(dash: [5]))
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.contentShape(Rectangle())
		.dropDestination(for: ElementModel.self) { items, location in
			let elements = items.compactMap { element in
				ElementModel(name: element.name)
			}
			if let page = navigation.selectedPage {
				page.body.children?.append(contentsOf: elements)
			}
			websiteManager.draggingElement = nil
			return false
		}
	}
}

#Preview {
	EmptyPageDetailView()
		.environment(previewWebsiteManager)
}
