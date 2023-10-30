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
	
    var body: some View {
		Form {
			TextField("Page name", text: $siteName)
			Button("Create") {
				createPage()
			}
			.disabled(siteName.isEmpty)
		}
    }
	
	private func createPage() {
		withAnimation {
			let page = PageModel(name: siteName, website: .init(name: "Test"))
			page.website = websiteManager.selectedWebsite!
			dismiss()
		}
	}
}

#Preview {
    NewPageView()
		.environment(previewWebsiteManager)
		.modelContainer(for: WebsiteModel.self)
}
