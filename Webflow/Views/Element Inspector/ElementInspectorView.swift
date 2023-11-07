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
		Form {
			HStack {
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
			.padding(.horizontal)
			
			Divider()
			
			TabView(selection: $selectedTab) {
				InspectorStyleView()
					.tag(InspectorTab.Style)
				
				InspectorSettingsView()
					.tag(InspectorTab.Settings)
				
				ElementInteractionsView()
					.tag(InspectorTab.Interactions)
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			
		}
		.formStyle(.columns)
	}
}

#Preview {
	NavigationSplitView(sidebar: {
		Text("Text here")
	}, detail: {
		NavigationStack {
			EmptyView()
				.inspector(isPresented: .constant(true)) {
					ElementInspectorView()
						.inspectorColumnWidth(400)
				}
		}
	})
	.environment(previewWebsiteManager)
	.modelContainer(for: ElementModel.self, inMemory: true)
	
}
