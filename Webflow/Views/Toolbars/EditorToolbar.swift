import SwiftUI

struct EditorToolbar: View {
	@Environment(WebsiteManager.self) var websiteManger
	@State private var isHovering: Bool = false
	@State private var isDesigning: Bool = false
	@State private var showPublisher: Bool = false
	@State private var showUserStatus: Bool = false
	@State private var showSharePopover: Bool = false
	
	var body: some View {
		HStack {
			HStack {
				Menu {
					Section {
						Label("Dashboard", image: "")
						Label("Site ettings", image: "")
						Label("Editor", image: "")
					}
					
					Section {
						Label("Quick find", image: "")
						
					}
					
					Section {
						Label("Undo", image: "")
						Label("Redo", image: "")
						
					}
					
					Section {
						Label("Keyboard shortcuts", image: "")
						Label("CSS preview", image: "")
						Label("Help & feedback", image: "")
					}
					
					Section {
						Label("Export code", image: "")
					}
				} label: {
					Image(isHovering ? "MenuIcon" : "webflowLogo")
						.resizable()
						.frame(width: 24, height: 24, alignment: .leading)
						.scaledToFit()
						.listRowSeparator(.visible)
						.listRowBackground(Rectangle().fill(.clear))
						.tint(.secondary)
				}
				.onHover(perform: { hovering in
					isHovering = hovering
				})
				
				Divider()
					.frame(maxHeight: 45)
				
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
			
			Spacer()
			
			BreakpointPicker()
			
			Spacer()
			
			HStack {
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
					showSharePopover.toggle()
				} label: {
					HStack {
						Image("accountIcon")
						Text("Share")
					}
				}
				.buttonStyle(.borderedProminent)
				.tint(Color.background2)
				.popover(isPresented: $showSharePopover) {
					SharePopover(isPresented: $showSharePopover)
				}
				
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
		.padding(.horizontal)
		.frame(height: 45)
	}
}
