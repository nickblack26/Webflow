//
//  ButtonLabel.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct ButtonLabel: ViewModifier {
	func body(content: Content) -> some View {
		content
			.padding(.horizontal, 8)
			.padding(.vertical, 4)
			.background(
				.linearGradient(
					colors: [
						Color("ActionSecondaryBackground")
							.opacity(0.12),
						Color("ActionSecondaryBackground")
							.opacity(0.1)
					],
					startPoint: .trailing,
					endPoint: .leading
				)
			)
			.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}

extension View {
	func buttonLabel() -> some View {
		modifier(ButtonLabel())
	}
}
