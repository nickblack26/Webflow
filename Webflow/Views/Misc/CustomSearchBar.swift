//
//  SwiftUIView.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import SwiftUI
import UIKit

struct CustomSearchBar: UIViewRepresentable {
	var currentClasses: [ClassModel]
	var allClasses: [ClassModel]
	
	func makeUIView(context: Context) -> UISearchTextField {
		let textField = UISearchTextField()
		textField.allowsDeletingTokens = true
		textField.allowsCopyingTokens = true
		textField.placeholder = "Select a class or tag"
		textField.text = ""
		textField.tokenBackgroundColor = UIColor(named: "accentColor", in: .main, compatibleWith: .current)
		
		let tokens: [UISearchToken] = currentClasses.map { token in
			return UISearchToken(icon: nil, text: token.name)
		}
		
		let suggestions: [UISearchSuggestionItem] = allClasses.map { suggest in
			return UISearchSuggestionItem(localizedSuggestion: suggest.name)
		}
		
		textField.searchSuggestions = suggestions
		textField.tokens = tokens
		
		return textField
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		
	}
}

#Preview {
	CustomSearchBar(currentClasses: [], allClasses: [])
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
