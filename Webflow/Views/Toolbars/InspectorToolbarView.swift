//
//  InspectorToolbarView.swift
//  Webflow
//
//  Created by Nick Black on 11/8/23.
//

import SwiftUI

struct InspectorToolbarView: ToolbarContent {
	@Binding var selectedTab: InspectorTab
	
    var body: some ToolbarContent {
		ToolbarItemGroup(placement: .topBarLeading) {
			ForEach(InspectorTab.allCases, id: \.self) { tab in
				Button {
					selectedTab = tab
				} label: {
					Text(tab.rawValue)
				}
				.buttonStyle(.plain)
				.opacity(selectedTab == tab ? 1 : 0.75)
			}
		}
    }
}

#Preview {
	VStack(spacing: 0) {
		EditorToolbar()
		
		Divider()
		
		NavigationSplitView(sidebar: {
			Text("Text here")
		}, detail: {
			NavigationStack {
				EmptyView()
			}
		})
		.inspector(isPresented: .constant(true)) {
			VStack {
				
			}
			.toolbar {
				InspectorToolbarView(selectedTab: .constant(InspectorTab.Style))
			}
		}
	}
	.environment(previewWebsiteManager)
	.modelContainer(for: ElementModel.self, inMemory: true)
}
