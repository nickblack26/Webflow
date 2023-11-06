//
//  ContentView.swift
//  Webflow
//
//  Created by Nick Black on 11/1/23.
//

import SwiftUI

struct ContentView: View {
	@Environment(WebsiteManager.self) private var websiteManager
	@State private var currentTab: SidebarTab? = .Add
	
	var body: some View {
		GeometryReader {
			let size = $0.size
			
			VStack(spacing: 0) {
				TopBar(size)
				
				Divider()
				
				HStack(spacing: 0) {
					SideBar(size)
					
					Divider()
					
					ContentList(size)
					
					if let selectedPage = websiteManager.selectedPage {
						PageDetailView(selectedTab: $currentTab, page: selectedPage)
						
					} else {
						ContentUnavailableView("No Website", image: "codeIcon", description: Text("Please select a website in the dropdown"))
					}
					
				}
				.frame(width: size.width, height: size.height, alignment: .topLeading)
			}
		}
		.background(Color("Background"))
	}
	
	/// Side Bar
	@ViewBuilder
	func SideBar(_ size: CGSize) -> some View {
		VStack(alignment: .center, spacing: 0, content: {
			Divider()
				.frame(width: 43)
			
			ForEach(SidebarTab.allCases, id: \.self) { tab in
				Button(action: {
					if tab == currentTab {
						currentTab = nil
					} else {
						currentTab = tab
					}
				}, label: {
					Image(tab.symbol)
						.font(.title3)
						.foregroundStyle(currentTab == tab ? .accent : .gray)
						.frame(width: 25, height: 25)
				})
				.buttonStyle(.plain)
				.padding(5)
			}
			
			Spacer(minLength: 0)
		})
	}
	
	/// Content List
	@ViewBuilder
	func ContentList(_ size: CGSize) -> some View {
		@Bindable var websiteManager = websiteManager
		VStack(alignment: .center, spacing: 0, content: {
			if let currentTab {
				switch currentTab {
					case .pages:
						PageListView(selectedPage: $websiteManager.selectedPage)
					case .Add:
						AddElementsView(selectedPage: $websiteManager.selectedPage)
					case .navigator:
						NavigatorListView(selectedPage: websiteManager.selectedPage)
					case .components:
						ComponentsListView()
					case .assets:
						AssetsListView()
					case .find: EmptyView()
						
					default:
						AddElementsView(selectedPage: $websiteManager.selectedPage)
				}
			} else {
				Text("Please select a tab")
			}
			
			Spacer(minLength: 0)
		})
		.frame(maxWidth: 400)
	}
	
	/// Top Bar
	@ViewBuilder
	func TopBar(_ size: CGSize) -> some View {
		HStack(alignment: .center, content: {
			Image("webflowLogo")
				.font(.title)
				.frame(width: 25, height: 25)
				.padding(5)
			
			Divider()
				.frame(height: 43)
			
			PopoverButtonView {
				Label("Home", image: "pageDefaultIcon")
					.buttonLabel()
			} content: {
				Button {
					
				} label: {
					HStack(alignment: .top) {
						VStack(alignment: .leading, content: {
							Text("Designing")
							Text("Style elements and build layouts")
						})
					}
				}
				
				Button {
					
				} label: {
					HStack(alignment: .top) {
						VStack(alignment: .leading, content: {
							Text("Editing")
							Text("Edit static and dynamic content")
						})
					}
				}
			}
			
			Spacer()
			
			BreakpointPicker()
			
			Spacer()
			
			PopoverButtonView {
				HStack {
					Label("Home", image: "pageDefaultIcon")
					Image("chevronDown")
				}
				.buttonLabel()
			} content: {
				Button {
					
				} label: {
					HStack(alignment: .top) {
						VStack(alignment: .leading, content: {
							Text("Designing")
							Text("Style elements and build layouts")
						})
					}
				}
				
				Button {
					
				} label: {
					HStack(alignment: .top) {
						VStack(alignment: .leading, content: {
							Text("Editing")
							Text("Edit static and dynamic content")
						})
					}
				}
			}
			
			Image("checkCircleIcon")
			
			Image("codeIcon")
			
			Image("previewIcon")
			
			Button {
				
			} label: {
				Label("Share", image: "accountIcon")
					.buttonLabel()
			}
			.buttonStyle(.plain)
			
			PopoverButtonView {
				HStack {
					Label("Publish", image: "rocket")
					Image("chevronDown")
				}
				.buttonLabel(.background2)
			} content: {
				Button {
					
				} label: {
					HStack(alignment: .top) {
						VStack(alignment: .leading, content: {
							Text("Designing")
							Text("Style elements and build layouts")
						})
					}
				}
				
				Button {
					
				} label: {
					HStack(alignment: .top) {
						VStack(alignment: .leading, content: {
							Text("Editing")
							Text("Edit static and dynamic content")
						})
					}
				}
			}
		})
	}
	
	var screenFrame: CGSize {
		return UIScreen.current?.bounds.size ?? .zero
	}
}

#Preview {
	ContentView()
		.environment(previewWebsiteManager)
}

extension UIWindow {
	static var current: UIWindow? {
		for scene in UIApplication.shared.connectedScenes {
			guard let windowScene = scene as? UIWindowScene else { continue }
			for window in windowScene.windows {
				if window.isKeyWindow { return window }
			}
		}
		return nil
	}
}


extension UIScreen {
	static var current: UIScreen? {
		UIWindow.current?.screen
	}
}
