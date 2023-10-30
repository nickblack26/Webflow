//
//  ElementInspectorView.swift
//  Webflow
//
//  Created by Nick on 10/7/23.
//

import SwiftUI

enum InspectorTab: String, CaseIterable {
	case style
	case settings
	case interactions
}

struct ElementInspectorView: View {
	@State private var selectedTab: InspectorTab = .style
	
	var body: some View {
		Form {
			switch selectedTab {
				case .style: InspectorStyleView()
				case .settings: InspectorSettingsView()
				case .interactions: InspectorSettingsView()
			}
		}
		.toolbar {
			ToolbarItemGroup {
				HStack {
					ForEach(InspectorTab.allCases, id: \.self) { tab in
						Button {
							selectedTab = tab
						} label: {
							Text(tab.rawValue.capitalized)
						}
						.buttonStyle(.plain)
						.opacity(selectedTab == tab ? 1 : 0.75)
						.underline(selectedTab == tab)
					}
				}
			}
		}
	}
}

#Preview {
	NavigationSplitView(sidebar: {
		Text("Text here")
	}, detail: {
		EmptyView()
			.inspector(isPresented: .constant(true)) {
				ElementInspectorView()
					.inspectorColumnWidth(400)
			}
			.toolbar {
				ToolbarItem {
					Text("Hello")
				}
			}
	})
	.environment(previewWebsiteManager)
	.modelContainer(for: ElementModel.self, inMemory: true)
	
}
