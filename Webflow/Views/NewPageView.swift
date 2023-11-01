//
//  NewPageView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct NewPageView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@Environment(\.dismiss) private var dismiss
	@State private var siteName: String = ""
	@State private var category: PageModel.Category = .Static
	
    var body: some View {
		Form {
			TextField("Page name", text: $siteName)
			Picker("Type", selection: $category) {
				ForEach(PageModel.Category.allCases, id: \.self) {
					Text($0.rawValue)
				}
			}
			Button("Create") {
				createPage()
			}
			.disabled(siteName.isEmpty)
		}
    }
	
	private func createPage() {
		withAnimation {
			let count = websiteManager.selectedWebsite?.pages.filter { $0.category == category }.count
			let page = PageModel(name: siteName, typeId: category.rawValue, type: category, index: count ?? 0)
			websiteManager.selectedWebsite?.pages.append(page)
			dismiss()
		}
	}
}

#Preview {
    NewPageView()
		.environment(previewWebsiteManager)
		.modelContainer(for: WebsiteModel.self)
}
