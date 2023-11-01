import SwiftUI
import SwiftData

enum CommandBarTab: String, CaseIterable {
	case All
	case Elements
	case Components
	case Cayouts
	case Pages
	case Collections
	case Flows
}

struct ControlPanelView: View {
	@Query(filter: #Predicate<ElementModel>{ element in
		element.icon != nil
	}) var elements: [ElementModel]
	@Query var pages: [ElementModel]
	@State private var commandBarTab: CommandBarTab = .All
	@State private var searchText: String = ""
	@Binding var isPresented: Bool
	
	var body: some View {
		Form {
			TextField("Search", text: $searchText, prompt: Text("Find anything..."))
			
			Section {
				
			} header: {
				HStack {
					ForEach(CommandBarTab.allCases, id: \.self) { tab in
						Button(tab.rawValue.capitalized) {
							commandBarTab = tab
						}
						.buttonStyle(.plain)
						.foregroundStyle(commandBarTab == tab ? .primary : .secondary)
						.underline(commandBarTab == tab)
						.padding(.bottom, 1)
					}
				}
			}
			
			Section {
				ForEach(elements) { element in
					Button(element.name) {
						
					}
				}
			}
		}
		.frame(maxWidth: 1800, alignment: .topLeading)
		.foregroundStyle(.primary)
		.tint(.primary)
		.background {
			RoundedRectangle(cornerRadius: 4)
				.fill(.background3)
		}
	}
	
	func filteredElements() -> [ElementModel] {
		if searchText.isEmpty {
			return elements
		} else {
			return elements.filter { $0.name.contains(searchText) }
		}
	}
}

#Preview {
	@State var isPresented: Bool = false
	
	return ControlPanelView(isPresented: $isPresented)
}
