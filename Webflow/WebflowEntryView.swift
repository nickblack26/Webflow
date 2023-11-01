//
//  WebflowEntryView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

enum WebflowTab: String, CaseIterable {
	case AllSites = "All sites"
	case Tutorials
	
	var icon: String {
		switch self {
			case .AllSites: return "list.bullet.below.rectangle"
			case .Tutorials: return "video"
		}
	}
}

struct WebflowEntryView: View {
	@Query private var websites: [WebsiteModel]
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var newWebsite: Bool = false
	
	var body: some View {
		@Bindable var websiteManager = websiteManager
		NavigationStack {
			if websites.isEmpty {
				ContentUnavailableView(label: {
					Label("No Websites", systemImage: "lessthan")
				}, description: {
					Text("New mails you receive will appear here.")
				}, actions: {
					Button(action: {newWebsite.toggle()}) {
						Text("Add")
					}
				})
			} else {
				List(websites, selection: $websiteManager.selectedWebsite) { website in
					Button(website.name) {
						websiteManager.selectedWebsite = website
					}
				}
			}
		}
		.sheet(isPresented: $newWebsite, content: {
			NewWebsiteView()
		})
	}
	
	private func delete(_ website: WebsiteModel) {
		websiteManager.selectedWebsite = nil
		modelContext.delete(website)
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(websites[index])
			}
		}
	}
}

#Preview {
	WebflowEntryView()
		.environment(previewWebsiteManager)
}
