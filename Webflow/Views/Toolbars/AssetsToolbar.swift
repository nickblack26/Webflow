//
//  AssetsToolbar.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import SwiftUI

struct AssetsToolbar: ToolbarContent {
	@State private var assetType: String = "All Assets"
	@State private var assetSort: String = "Newest First"
	@Binding var selection: Set<Int>
	@Binding var expand: Bool
	
	var body: some ToolbarContent {
		ToolbarItemGroup(placement: .topBarLeading) {
			VStack(alignment: .leading, spacing: 5, content: {
				Text("Assets")
					.fontWeight(.medium)
				
				if !expand {
					Picker(selection: $assetType) {
						Text("All Assets").tag("All Assets")
						Text("Images").tag("Images")
						Text("Documents").tag("Documents")
						Text("Lottie").tag("Lottie")
					} label: {
						HStack {
							Text("All Assets")
							Image("chevronDown")
						}
					}
					.labelsHidden()
				} else {
					
				}
			})
		}
		
		if !expand {
			ToolbarItemGroup(placement: .topBarTrailing) {
				VStack(alignment: .trailing, content: {
					Button {
						withAnimation {
							expand.toggle()
						}
					} label: {
						Image("SidebarExpandIcon")
							.buttonHoverEffect()
					}
					.buttonStyle(.plain)
					
					HStack {
						Button {} label: {
							Image("FolderAddIcon")
								.buttonHoverEffect()
						}
						.buttonStyle(.plain)
						
						Button {
							
						} label: {
							Image("UploadIcon")
								
						}
						.buttonStyle(.borderedProminent)
						.tint(.background2)
					}
				})
			}
			
			ToolbarItemGroup(placement: .bottomBar) {
				HStack {
					Picker(selection: $assetSort) {
						Text("Newest First")
							.tag("Newest First")
						Text("Oldest First")
							.tag("Oldest First")
						Text("Alphabetical (A-Z)")
							.tag("Alphabetical (A-Z)")
						Text("Alphabetical (Z-A)")
							.tag("Alphabetical (Z-A)")
					} label: {
						HStack {
							Text("Newest First")
							Image("chevronDown")
						}
					}
					
					Spacer()
					
					if(selection.count > 0) {
						Text("Selected ^[\(selection.count) file](inflect: true)")
					}
					
					Spacer()
					
				}
			}
		}
	}
}

#Preview {
	NavigationSplitView(sidebar: {
		
	}, content: {
		HStack {
			
		}
		.toolbar {
			AssetsToolbar(selection: .constant(.init(arrayLiteral: 1, 2, 3)), expand: .constant(true))
		}
	}, detail: {
		
	})
}
