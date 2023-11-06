//
//  CustomSplitView.swift
//  Webflow
//
//  Created by Nick Black on 11/1/23.
//

import SwiftUI


//struct SidebarViewController: UIViewControllerRepresentable {
//	
//	
//	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//		
//	}
//}

struct SplitViewController: UIViewControllerRepresentable {
	
	func makeUIViewController(context: Context) -> UISplitViewController {
		let view = UISplitViewController(style: .tripleColumn)
		view.preferredDisplayMode = .twoOverSecondary
		view.addChild(view)
		return view
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
}

struct CustomSplitView: View {
    var body: some View {
		SplitViewController()
    }
}

#Preview {
    CustomSplitView()
}
