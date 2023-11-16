//
//  NewPageView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

struct NewPageView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@Environment(NavigationManager.self) private var navigation
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
			let count = navigation.selectedWebsite?.pages.filter { $0.category == category }.count
			let page = PageModel(name: siteName, typeId: category.rawValue, type: category, index: count ?? 0)
			navigation.selectedWebsite?.pages.append(page)
			dismiss()
		}
	}
}

#Preview {
    NewPageView()
		.environment(previewWebsiteManager)
		.modelContainer(for: WebsiteModel.self)
}
