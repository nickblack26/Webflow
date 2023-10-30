import SwiftUI

struct PanelAddButtonLabelView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var isHovering: Bool = false
	var icon: String
	var name: String
	var element: ElementModel

    var body: some View {
		VStack {
			Image(icon)
			
			Text(name)
				.font(.caption)
				.foregroundStyle(.secondary)
		}
		.frame(maxWidth: .infinity)
		.background(isHovering ? .background3 : .clear)
		.draggable(element.id.uuidString) {
			VStack {
				Image(icon)
				
				Text(name)
					.font(.caption)
					.foregroundStyle(.secondary)
			}
			.background(Color("Background"))
			.onAppear(perform: {
				websiteManager.draggingElement = element
			})
		}
		.onHover(perform: {
			isHovering = $0
			DispatchQueue.main.async {
				if (self.isHovering) {
					NSCursor.pointingHand.push()
				} else {
					NSCursor.pop()
				}
			}
		})
    }
}

#Preview {
	PanelAddButtonLabelView(icon: "AddPanelSectionIcon", name: "Section", element: .init(name: "Section"))
		.environment(previewWebsiteManager)
		.previewLayout(.sizeThatFits)
}
