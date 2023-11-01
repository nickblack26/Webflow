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
			Form {
				switch selectedTab {
					case .Style: InspectorStyleView()
					case .Settings: InspectorSettingsView()
					case .Interactions: InspectorSettingsView()
				}
			}
		}
//		.toolbar {
//			ToolbarItemGroup {
//				HStack {
//					ForEach(InspectorTab.allCases, id: \.self) { tab in
//						Button {
//							selectedTab = tab
//						} label: {
//							Text(tab.rawValue.capitalized)
//						}
//						.buttonStyle(.plain)
//						.opacity(selectedTab == tab ? 1 : 0.75)
//						.underline(selectedTab == tab)
//					}
//				}
//			}
//		}
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
