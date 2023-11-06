//
//  CustomSidebarView.swift
//  Webflow
//
//  Created by Nick Black on 11/1/23.
//

import SwiftUI
//import UIKit

struct CustomTabView<Content: View, T: Hashable>: View {
	var hideTabBar: Bool = true
	@Binding var selection: T
	@ViewBuilder var content: Content
    var body: some View {
		ScrollView(.init()) {
			TabView(selection: $selection) {
				content
			}
			.background(TabFinder(hide: hideTabBar))
		}
    }
}

fileprivate struct TabFinder: UIViewRepresentable {
	var hide: Bool
	func makeUIView(context: Context) -> UIView {
		return .init()
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
			if let superView = uiView.superview?.superview {
//				print(superView.subviews(type: NSTabView.self))
			}
		}
	}
}

fileprivate extension UIView {
	func subviews<Type: UIView>(type: Type.Type) -> [Type] {
		var views = subviews.compactMap({ $0 as? Type })
		
		for subView in subviews {
			views.append(contentsOf: subView.subviews(type: type))
		}
		
		return views
	}
}
