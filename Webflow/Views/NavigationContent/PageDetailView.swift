//
//  PageDetailView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct PageDetailView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var showPopover: Bool = true
	@Binding var selectedTab: SidebarTab?
	var page: PageModel
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		let childElements = page.body.childElements
		List {
			if childElements.isEmpty {
				ElementView(element: page.body)
					.frame(minWidth: 50, minHeight: 50)
			} else {
				ForEach(childElements, id: \.self) { element in
					ElementView(element: element)
						.frame(minWidth: 50, minHeight: 50)
				}
			}
		}
		.listStyle(.plain)
		.inspector(isPresented: .constant(true)) {
			ElementInspectorView()
		}
		.toolbar {
			EditorToolbar()
		}
	}
}

#Preview {
	NavigationSplitView {
		
	} content: {
		
	} detail: {
		PageDetailView(selectedTab: .constant(.add), page: .init(name: "Test"))
	}
	.environment(previewWebsiteManager)
}
