//
//  NewDetailView.swift
//  Webflow
//
//  Created by Nick Black on 11/1/23.
//

import SwiftUI

struct NewDetailView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@Binding var selectedTab: SidebarTab?
	var body: some View {
		@Bindable var websiteManger = websiteManager
		List {
			Text("Hello, World!")
		}
		.listStyle(.plain)
		.overlay(alignment: .leading) {
			switch selectedTab {
				case .Add:
					if websiteManager.draggingElement == nil  {
						List {
							//					Picker("Type", selection: $selection) {
							//						Text("Elements")
							//							.tag("elements")
							//
							//						Text("Layouts")
							//							.tag("layouts")
							//					}
							//					.pickerStyle(.segmented)
							//					.listRowBackground(EmptyView())
							
							Section("Structure") {
								LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
									ForEach(DefaultStructureElement.allCases, id: \.self) { element in
										Button {
											//									addElement()
										} label: {
											PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
										}
										.buttonStyle(.plain)
									}
								}
							}
							.listRowBackground(EmptyView())
							
							Section("Basic") {
								LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
									ForEach(DefaultBasicElement.allCases, id: \.self) { element in
										Button {
											//									addElement()
										} label: {
											PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
										}
										.buttonStyle(.plain)
									}
								}
							}
							.listRowBackground(EmptyView())
							
							Section("Typography") {
								LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
									ForEach(DefaultTypographyElement.allCases, id: \.self) { element in
										Button {
											//									addElement()
										} label: {
											PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
										}
										.buttonStyle(.plain)
									}
								}
							}
							.listRowBackground(EmptyView())
							
							Section("CMS") {
								LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
									ForEach(DefaultStructureElement.allCases, id: \.self) { element in
										Button {
											//									addElement()
										} label: {
											PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
										}
										.buttonStyle(.plain)
									}
								}
							}
							.listRowBackground(EmptyView())
							
							Section("Media") {
								LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
									ForEach(DefaultStructureElement.allCases, id: \.self) { element in
										Button {
											//									addElement()
										} label: {
											PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
										}
										.buttonStyle(.plain)
									}
								}
							}
							.listRowBackground(EmptyView())
							
							Section("Forms") {
								LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
									ForEach(DefaultStructureElement.allCases, id: \.self) { element in
										Button {
											//									addElement()
										} label: {
											PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
										}
										.buttonStyle(.plain)
									}
								}
							}
							.listRowBackground(EmptyView())
							
							Section("Advanced") {
								LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
									ForEach(DefaultStructureElement.allCases, id: \.self) { element in
										Button {
											//									addElement()
										} label: {
											PanelAddButtonLabelView(icon: element.icon, name: element.rawValue, element: element.element)
										}
										.buttonStyle(.plain)
									}
								}
							}
							.listRowBackground(EmptyView())
						}
						.tint(.primary)
						.foregroundStyle(.primary)
						//			.background(.gray)
						.frame(minWidth: 100, idealWidth: 250, maxWidth: 400, alignment: .leading)
					}
				default:
					EmptyView()
			}
		}
	}
}

#Preview {
	@State var selectedTab: SidebarTab? = .Add
	return NavigationSplitView {
		List(SidebarTab.allCases, id: \.self, selection: $selectedTab) { tab in
			Label(tab.rawValue, image: tab.symbol)
		}
	} detail: {
		NewDetailView(selectedTab: $selectedTab)
	}
	.environment(previewWebsiteManager)
}
