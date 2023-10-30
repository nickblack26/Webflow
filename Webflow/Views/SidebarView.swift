import SwiftUI

struct SidebarView: View {
	@Binding var selectedTab: SidebarTab?
	
	var body: some View {
		NavigationSplitView {
			
		} content: {
			
		} detail: {
			
		}

//		HStack {
			//				VStack {
			//					ForEach(SidebarTab.allCases, id: \.self) { tab in
			//						Image(tab.symbol)
			//							.padding(.vertical, 2.5)
			//					}
			//				}
			//				.frame(maxHeight: .infinity, alignment: .topLeading)
			//				.frame(width: 35)
			//				.overlay(alignment: .topLeading) {
			//					if(selectedTab != nil) {
			//						VStack(alignment: .leading) {
			//							ForEach(SidebarTab.allCases, id: \.self) { tab in
			//								Image(tab.symbol)
			//									.tag(tab)
			//							}
			//						}
			//						.frame(width: 250, alignment: .leading)
			//						.frame(maxHeight: .infinity, alignment: .top)
			//						.offset(x: 35)
			//					}
			//				}
			
			//			PageDetailView(selectedTab: .constant(.addElements), page: .init(name: "Body"))
			
//		}
		.toolbar {
			EditorToolbar()
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.preferredColorScheme(.dark)
		.background(Color("PanelColor"))
	}
}

#Preview {
	NavigationStack {
		SidebarView(selectedTab: .constant(.add))
	}
	.background(Color("PanelColor"))
	.modelContainer(for: WebsiteModel.self, inMemory: true)
	.modelContainer(for: ElementModel.self, inMemory: true)
	.environment(previewWebsiteManager)
	
}
