//
//  NavigationListItemView.swift
//  Webflow
//
//  Created by Nick Black on 11/7/23.
//

import SwiftUI

enum NavigationListItemStyle {
	case iconOnly
	case titleAndIcon
	case titleOnly
}

struct NavigationListItemView: View {
	@State private var isHovering: Bool = false
	var style: NavigationListItemStyle = .titleAndIcon
	var element: ElementModel
	var selectedElement: ElementModel?
	
	var body: some View {
		let isCurrent = element.id == selectedElement?.id
		
		HStack {
			Image(element.settings?.tag.icon ?? "ElementDivIcon")
				.resizable()
				.frame(width: 16, height: 16)
			Text(element.name)
		}
		.contextMenu(menuItems: {
			ElementContextMenu(element: element)
		})
		.tag(element)
		.listItemTint(.accent)
		.foregroundStyle(.accent)
		.listRowBackground(
			Rectangle()
				.fill(isCurrent ? .accent.opacity(0.2) : .clear)
		)
		.listRowSeparator(.hidden)
	}
}

#Preview {
	NavigationSplitView {
		List {
			ForEach(0..<50, id: \.self) { _ in
				NavigationListItemView(element: .init(name: "page-wrapper"), selectedElement: .init(name: "Body"))
			}
		}
		.listStyle(.plain)
	} detail: {
		
	}
	.preferredColorScheme(.dark)
	.scrollContentBackground(.hidden)
	.background(Color("Background").ignoresSafeArea())
}

#Preview {
	@State var selection: ElementModel?
	
	return NavigationSplitView {
		List(selection: $selection) {
			ForEach(0..<50, id: \.self) { _ in
				NavigationListItemView(element: .init(name: "page-wrapper"), selectedElement: selection)
			}
		}
		.listStyle(.plain)
	} detail: {
		
	}
	.preferredColorScheme(.dark)
	.scrollContentBackground(.hidden)
	.background(Color("Background").ignoresSafeArea())
}
