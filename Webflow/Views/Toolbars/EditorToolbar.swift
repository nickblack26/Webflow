import SwiftUI

struct EditorToolbar: ToolbarContent {
	@Environment(WebsiteManager.self) var websiteManger
	@State private var isDesigning: Bool = false
	@State private var showPublisher: Bool = false
	@State private var showUserStatus: Bool = false
	
	var body: some ToolbarContent {
		ToolbarItemGroup(placement: .topBarLeading) {
			HStack {
				Image("webflowLogo")
				
				Divider()
				
				Button {
					
				} label: {
					HStack {
						Image("PageDefaultIcon")
						Text(websiteManger.selectedPage?.name ?? "")
					}
				}
				.buttonStyle(.borderedProminent)
				.tint(Color.background2)
			}
		}
		
		ToolbarItemGroup(placement: .principal) {
			BreakpointPicker()
		}
		
		ToolbarItemGroup {
			Button {
				showUserStatus.toggle()
//				Button {
//					isDesigning.toggle()
//				} label: {
//					VStack(alignment: .leading) {
//						Text("Designing")
//						Text("Style elements and build layouts")
//					}
//					.padding()
//				}
//				.buttonStyle(.plain)
//				
//				Button {
//					isDesigning.toggle()
//				} label: {
//					VStack(alignment: .leading) {
//						Text("Editing")
//						Text("Edit static and dynamic content")
//					}
//					.padding()
//				}
//				.buttonStyle(.plain)
			} label: {
				HStack {
					Image("paintBrush")
					Text("Designing")
					Image("chevronDown")
				}
			}
			.buttonStyle(.borderedProminent)
			.tint(Color.background2)
			
			Image("checkCircleIcon")
				.foregroundStyle(.green)
			
			Image("codeIcon")
				.buttonHoverEffect()

			Image("commentIcon")
				.buttonHoverEffect()
			
			Image("previewIcon")
				.buttonHoverEffect()
	
			Button {
				
			} label: {
				HStack {
					Image("accountIcon")
					Text("Share")
				}
			}
			.buttonStyle(.borderedProminent)
			.tint(Color.background2)
			
			Button {
				showPublisher.toggle()
			} label: {
				HStack {
					Image("rocket")
					Text("Publish")
					Image("chevronDown")
				}
			}
			.buttonStyle(.borderedProminent)
			.tint(Color.background2)
			.popover(isPresented: $showPublisher, content: {
				PublishingPopoverView(isPresented: $showPublisher)
			})
		}
	}
}
