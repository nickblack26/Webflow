import SwiftUI

struct ButtonLabel: ViewModifier {
	var foregroundStyle: Color
	var background: Color
	
	func body(content: Content) -> some View {
		content
			.font(.caption)
			.padding(2)
			.foregroundStyle(foregroundStyle)
			.background(background)
			.clipShape(RoundedRectangle(cornerRadius: 2))
	}
}

extension Button {
	func buttonLabel(foregroundStyle: Color = .secondary, background: Color = .clear) -> some View {
		modifier(ButtonLabel(foregroundStyle: foregroundStyle, background: background))
	}
}

#Preview {
	Button("Hello") {
		
	}
	.buttonLabel(foregroundStyle: .blue, background: .orange.opacity(0.15))
}
