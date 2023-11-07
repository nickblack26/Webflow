//
//  SwiftUIView.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import SwiftUI
import UIKit

struct CustomSearchBar: UIViewRepresentable {
	func makeUIView(context: Context) -> UISearchBar {
		let searchBar = UISearchBar()
		searchBar.text = ""
		searchBar.placeholder = "Select a class or tag"
		searchBar.searchBarStyle = .minimal
		
		searchBar.setTf(color: .clear)
		return searchBar
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		
	}
}

#Preview {
    CustomSearchBar()
}

extension UISearchBar {
	func getTf() -> UITextField? { return value(forKey: "searchField") as? UITextField }
	func setTf(color: UIColor) {
		guard let tf = getTf() else { return }
		switch searchBarStyle {
			case .minimal:
				tf.layer.borderColor = UIColor.systemGray5.cgColor
				tf.layer.borderWidth = 1
				tf.layer.backgroundColor = color.cgColor
				tf.layer.cornerRadius = 5
				
			case .prominent:
				break;
			default:
				tf.backgroundColor = color
		}
	}
}
