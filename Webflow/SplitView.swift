import SwiftUI

struct SplitView: UIViewControllerRepresentable {
	
	
	func makeUIViewController(context: Context) -> some UIViewController {
		let splitView = UISplitViewController(style: .doubleColumn)
		let sidebar = UIHostingController(rootView: CustomSidebar())
		splitView.viewControllers = [sidebar]
		splitView.preferredSplitBehavior = .overlay
		splitView.showsSecondaryOnlyButton = true
		splitView.primaryBackgroundStyle = .none
		splitView.show(.primary)
		splitView.hide(.secondary)
		splitView.navigationController?.setNavigationBarHidden(true, animated: true)
		return splitView
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
}

#Preview {
	@State var website = NavigationManager()
	
	return SplitView()
		.environment(previewWebsiteManager)
		.environment(website)
	
}
