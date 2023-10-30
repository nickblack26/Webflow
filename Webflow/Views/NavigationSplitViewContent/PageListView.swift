//
//  PageListView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI
import SwiftData

struct PageListView: View {
	@State private var seachText: String = ""
	@State private var createNewPage: Bool = false
	@Binding var selectedPage: PageModel?
	var pages: [PageModel]
	
    var body: some View {
		List(selection: $selectedPage) {
			ForEach(PageModel.PageType.allCases, id: \.self) { type in
				PageGroupedList(pageType: type)
			}
		}
		.searchable(text: $seachText, prompt: "Search pages")
		.toolbar {
			ToolbarItemGroup(placement: .topBarLeading) {
				Text("Pages")
			}
			
			ToolbarItemGroup {
				Button {
					createNewPage.toggle()
				} label: {
					Image("FolderAddIcon")
				}
				.buttonStyle(.plain)
				
				Button {
					createNewPage.toggle()
				} label: {
					Image("PageAddIcon")
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
		PageListView(selectedPage: .constant(.init(name: "Home", elementStatus: .Public, website: .init(name: "Test"))), pages: .init())
			.modelContainer(for: PageModel.self, inMemory: true)
			.environment(previewWebsiteManager)
	} detail: {
		
	}
}
