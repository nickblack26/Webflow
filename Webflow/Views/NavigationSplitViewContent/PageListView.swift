//
//  PageListView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

struct PageListView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@Environment(NavigationManager.self) private var navigation
	@State var isEditMode: EditMode = .active
	@State private var searchText: String = ""
	@State private var createNewPage: Bool = false
	@Binding var selectedPage: PageModel?
	
	var body: some View {
		@Bindable var navigation = navigation
		List(selection: $navigation.selectedPage) {
			ForEach(PageModel.Category.allCases, id: \.self) { type in
				PageGroupedList(pageType: type, searchText: $searchText)
			}
		}
		.scrollContentBackground(.hidden)
		.background(Color("Background"), ignoresSafeAreaEdges: .all)
		.listStyle(.plain)
		.searchable(text: $searchText, prompt: "Search pages")
		.toolbar {
			ToolbarItemGroup(placement: .topBarLeading) {
				Text("Pages")
			}
						
			ToolbarItemGroup {
				Button {
					createNewPage.toggle()
				} label: {
					Image("FolderAddIcon")
						.resizable()
						.buttonHoverEffect()
				}
				.buttonStyle(.plain)
				
				Button {
					createNewPage.toggle()
				} label: {
					Image("PageAddIcon")
						.resizable()
						.buttonHoverEffect()
				}
				.buttonStyle(.plain)
			}
		}
		.sheet(isPresented: $createNewPage) {
			NewPageView()
		}
	}
}

#Preview {
	NavigationSplitView {

	} content: {
//		PageListView(selectedPage: .constant(.init(name: "1", index: 0)))
//			.modelContainer(for: PageModel.self, inMemory: true)
//			.environment(previewWebsiteManager)
	} detail: {

	}
}
