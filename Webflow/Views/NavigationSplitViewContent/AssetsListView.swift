//
//  AssetsListView.swift
//  Webflow
//
//  Created by Nick on 10/30/23.
//

import SwiftUI

struct AssetsListView: View {
	let url = "https://uploads-ssl.webflow.com/64be9ae522eb4b9359d95694/64d26fa734805f036d461a29_ben-kolde-bs2Ba7t69mM-unsplash.jpg"
	@State private var searchText: String = ""
	@State private var selection = Set<Int>()
	@State private var isExpanded: Bool = false
	@State private var groupSelection: String? = "All Assets"
	
	var body: some View {
		if isExpanded {
			List(selection: $groupSelection) {
				Section("Files") {
					Label("All Assets", image: "DuplicateOutlineIcon")
						.tag("All Assets")
					Label("Images", image: "FieldImageSetIcon")
						.tag("Images")
					Label("Documents", image: "PageDefaultIcon")
						.tag("Documents")
					Label("Lottie", image: "ElementAnimationIcon")
						.tag("Lottie")
				}
				.listRowSeparator(.hidden)
				.listItemTint(.monochrome)
				
				Section("Folders") {
					
				}
			}
			.listStyle(.plain)
			.scrollContentBackground(.hidden)
			.background(
				Color("Background")
					.ignoresSafeArea()
			)
		} else {
			List(selection: $selection) {
				LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
					ForEach((0..<100).indices, id: \.self) { index in
						ImageGridItemView(url: URL(string: url), title: "ben-kolde-bs2Ba7t69mM-unsplash.jpg", index: index)
					}
					.listRowInsets(.none)
				})
			}
			.listStyle(.plain)
			.scrollContentBackground(.hidden)
			.background(
				Color("Background")
					.ignoresSafeArea()
			)
			.environment(\.editMode, .constant(.active))
			.searchable(text: $searchText, prompt: "Search assets")
			.toolbar {
				AssetsToolbar(selection: $selection, expand: $isExpanded)
			}
			.navigationSplitViewColumnWidth(min: 500, ideal: 900, max: 1800)
		}
	}
}

#Preview {
	NavigationSplitView {
		
	} content: {
		AssetsListView()
	} detail: {
		
	}
}
