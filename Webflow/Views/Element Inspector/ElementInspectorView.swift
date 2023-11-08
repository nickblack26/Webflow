//
//  ElementInspectorView.swift
//  Webflow
//
//  Created by Nick on 10/7/23.
//

import SwiftUI

enum InspectorTab: String, CaseIterable {
	case Style
	case Settings
	case Interactions
}

struct ElementInspectorView: View {
	@State private var selectedTab: InspectorTab = .Style
	
	var body: some View {
		NavigationStack {
			TabView(selection: $selectedTab) {
				InspectorStyleView(selectedTab: $selectedTab)
					.tag(InspectorTab.Style)
				
				InspectorSettingsView()
					.tag(InspectorTab.Settings)
				
				ElementInteractionsView()
					.tag(InspectorTab.Interactions)
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			
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
			ElementInspectorView()
				.inspectorColumnWidth(400)
			
		}
	}
	.environment(previewWebsiteManager)
	.modelContainer(for: ElementModel.self, inMemory: true)
	
}
