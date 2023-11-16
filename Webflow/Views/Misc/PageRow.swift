//
//  PageRow.swift
//  Webflow
//
//  Created by Nick Black on 11/10/23.
//

import SwiftUI

struct PageRow: View {
	@Environment(\.modelContext) private var modelContext
	@Bindable var page: PageModel
	
	init(_ page: PageModel) {
		self.page = page
	}
	
    var body: some View {
		let isDraft = page.status == .Draft
		
		HStack(spacing: 8) {
			Image(isDraft ? "PageDraftIcon" : "PageDefaultIcon")
				.resizable()
				.frame(width: 16, height: 16)
			
			Text("\(isDraft ? "[Draft] " : "")\(page.name)")
		}
		.font(.callout)
		.listRowSeparator(.hidden)
		.listRowInsets(EdgeInsets())
		.contextMenu(ContextMenu(menuItems: {
			Button(isDraft ? "Stage for publish" : "Save as draft") {
				if isDraft {
					page.status = .Published
				} else {
					page.status = .Draft
				}
			}
			
			Button("Delete") {
				modelContext.delete(page)
			}
		}))
		.moveDisabled(page.isHome)
    }
}

#Preview {
	PageRow(.init(name: "Home", index: 1))
}
