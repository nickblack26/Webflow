import SwiftUI

struct AsyncImageGridItemView: View {
	@State private var hovering: Bool = false
	@State private var showPopover: Bool = false
	var url: URL?
	var title: String?
	var index: Int
	
    var body: some View {
		VStack {
			AsyncImage(url: url) { image in
				image
					.resizable()
					.scaledToFit()
					.frame(height: 84)
					.frame(maxWidth: .infinity)
					.background(.gray)
			} placeholder: {
				Rectangle()
					.fill(.gray)
					.frame(height: 84)
					.frame(maxWidth: .infinity)
			}
			
			Text(title ?? "ben-kolde-bs2Ba7t69mM-unsplash.jpg")
				.lineLimit(1)
		}
		.popover(isPresented: $showPopover, content: {
			AssetPopoverView(showPopover: $showPopover)
		})
		.preferredColorScheme(.dark)
		.overlay {
			if hovering || showPopover {
				VStack(alignment: .trailing) {
					Button {
						showPopover.toggle()
					} label: {
						Image("SettingsIcon")
							.buttonHoverEffect()
					}
					
					Spacer()
					
//					NavigationLink(value: index) {
						Image("checkCircleIcon")
							.frame(maxWidth: .infinity, alignment: .trailing)
							.background(
								.linearGradient(
									colors: [
										.background.opacity(0.0),
										.background
									],
									startPoint: .bottomLeading,
									endPoint: .bottomTrailing
								)
							)
//					}
				}
				.padding(3)
			} else {
				/*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
			}
		}
		.onHover(perform: { hovering = $0 })
    }
}

#Preview {
	NavigationSplitView {
		
	} content: {
		List {
			LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
//				ForEach(0..<10, id: \.self) { _ in
//
//				}
				AsyncImageGridItemView(index: 1)
			})
			.listRowSeparator(.hidden)
		}
		.listStyle(.plain)
		.scrollContentBackground(.hidden)
		.background(
			Color("Background")
				.ignoresSafeArea()
		)
	} detail: {
		
	}
}
