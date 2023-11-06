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
	var body: some View {
		List {
			LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
				ForEach(0..<100, id: \.self) { image in
					VStack {
						AsyncImage(url: URL(string: url)) { image in
							image
								.resizable()
								.scaledToFit()
								.frame(height: 84)
								.frame(maxWidth: .infinity)
								.background(.gray)
						} placeholder: {
							Rectangle()
								.fill(.gray)
								.frame(height: 84)
								.frame(maxWidth: .infinity)
						}
						
						Text("ben-kolde-bs2Ba7t69mM-unsplash.jpg")
							.lineLimit(1)
					}
				}
			})
		}
		.searchable(text: $searchText, prompt: "Search assets")
//		.toolbar {
//			ToolbarItemGroup(placement: .topBarLeading) {
//				VStack(alignment: .leading, spacing: 5, content: {
//					Text("Assets")
//						.fontWeight(.medium)
//					Menu {
//						Text("Images")
//						Text("Documents")
//						Text("Lottie")
//					} label: {
//						HStack {
//							Text("All Assets")
//							Image("chevronDown")
//						}
//					}
//				})
//			}
//			ToolbarItemGroup(placement: .topBarTrailing) {
//				VStack(alignment: .trailing, content: {
//					Image("SidebarExpandIcon")
//					
//					HStack {
//						Image("FolderAddIcon")
//						Button {
//							
//						} label: {
//							Image("UploadIcon")
//								.buttonLabel()
//						}
//					}
//				})
//			}
//		}
		.navigationSplitViewColumnWidth(min: 500, ideal: 900, max: 1800)
	}
}

#Preview {
    AssetsListView()
}
