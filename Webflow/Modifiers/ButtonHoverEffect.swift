//
//  ButtonHoverEffect.swift
//  Webflow
//
//  Created by Nick on 10/31/23.
//

import SwiftUI

struct ButtonHoverEffect: ViewModifier {
	@State private var isHovering: Bool = false

	func body(content: Content) -> some View {
		content
			.padding(.all, 5)
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
			.background(isHovering ? .background2 : .clear)
			.clipShape(RoundedRectangle(cornerRadius: 4))
	}
}

extension View {
	func buttonHoverEffect() -> some View {
		modifier(ButtonHoverEffect())
	}
}
