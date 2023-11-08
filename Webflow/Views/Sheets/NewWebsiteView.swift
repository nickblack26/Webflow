//
//  NewWebsiteView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct NewWebsiteView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	@State private var siteName: String = ""

    var body: some View {
		NavigationStack {
			Form {
				TextField("Site name", text: $siteName)
				
				HStack {
					Spacer()
					
					Button("Cancel") {
						dismiss()
					}
					.padding(.vertical, 5)
					.padding(.horizontal)
					.background(Color.white)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					
					Button(action: addWebsite, label: {
						Text("Create site")
					})
					.padding(.vertical, 5)
					.padding(.horizontal)
					.background(Color.accentColor)
					.foregroundStyle(.white)
					.clipShape(RoundedRectangle(cornerRadius: 10))
				}
				.listRowBackground(EmptyView())
				.listRowSeparator(.hidden)
			}
			.onSubmit {
				addWebsite()
			}
			.navigationTitle("Name your site")
		}
    }
	
	private func addWebsite() {
		withAnimation {
			let newWebsite = WebsiteModel(
				name: siteName,
				pages: [
					.init(name: "Home", isHome: true, index: 0),
					.init(name: "404", typeId: PageModel.Category.Utility.rawValue, type: .Utility, index: 0),
					.init(name: "Password", typeId: PageModel.Category.Utility.rawValue, type: .Utility, index: 1)
				]
			)
			modelContext.insert(newWebsite)
		}
		dismiss()
	}

//	private func deleteItems(offsets: IndexSet) {
//		withAnimation {
//			for index in offsets {
//				modelContext.delete(items[index])
//			}
//		}
//	}
}

#Preview {
    NewWebsiteView()
}
