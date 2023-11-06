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
	
	var body: some View {
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
			ToolbarItemGroup(placement: .topBarLeading) {
				VStack(alignment: .leading, spacing: 5, content: {
					Text("Assets")
						.fontWeight(.medium)
					Menu {
						Text("Images")
						Text("Documents")
						Text("Lottie")
					} label: {
						HStack {
							Text("All Assets")
							Image("chevronDown")
						}
					}
				})
			}
			ToolbarItemGroup(placement: .topBarTrailing) {
				VStack(alignment: .trailing, content: {
					HStack {
						if(selection.count > 0) {
							Text("^[\(selection.count) select](inflect: true)")
						}
						Image("SidebarExpandIcon")
					}
					
					HStack {
						Image("FolderAddIcon")
						Button {
							
						} label: {
							Image("UploadIcon")
								.buttonLabel()
						}
					}
				})
			}
		}
		.navigationSplitViewColumnWidth(min: 500, ideal: 900, max: 1800)
	}
}

#Preview {
	NavigationSplitView {
		
	} content: {
		AssetsListView()
	} detail: {
		
	}
}
