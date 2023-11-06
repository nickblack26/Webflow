import SwiftUI

struct ButtonLabel: ViewModifier {
	var background: Color
	
	func body(content: Content) -> some View {
		content
			.padding(.horizontal, 8)
			.padding(.vertical, 4)
			.background(
				.linearGradient(
					colors: [
						.background.opacity(0.75),
							.background.opacity(1)
					],
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)
			)
			.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}

extension View {
	func buttonLabel(_ background: Color = Color("Background")) -> some View {
		modifier(ButtonLabel(background: background))
	}
}

#Preview {
	Button {
		
	} label: {
		Text("Hello")
			.buttonLabel(.blue)
	}
	.buttonStyle(.plain)
}
