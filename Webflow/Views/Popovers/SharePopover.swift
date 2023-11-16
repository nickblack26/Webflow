import SwiftUI

struct SharePopover: View {
	@Environment(NavigationManager.self) private var navigation
	@Binding var isPresented: Bool
	
    var body: some View {
		VStack(alignment: .leading) {
			Text("Share site")
			
			Divider()
			
			Toggle(isOn: .constant(false)) {
				VStack(alignment: .leading) {
					Text("Share read-only link")
					Text("Anyone with the link can view the site in the Designer, but won't be able to edit it.")
				}
			}
			
			HStack {
				Button("Close") {
					isPresented.toggle()
				}
				.buttonStyle(.borderedProminent)
				.tint(.background2)
				
				Button("Share") {
					if let website = navigation.selectedWebsite {
						Task {
							do {
								let _ = try await website.activate()
							} catch {
								print(error)
							}
						}
					}
				}
				.buttonStyle(.borderedProminent)
				.tint(.accent)
			}
			.frame(maxWidth: .infinity, alignment: .trailing)
		}
    }
}

#Preview {
	SharePopover(isPresented: .constant(false))
}
