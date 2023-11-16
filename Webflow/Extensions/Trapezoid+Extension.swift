import SwiftUI

struct TrapezoidShape: Shape {
	var rotation: Angle
	var height: CGFloat
	var upperWidth: CGFloat
	var lowerWidth: CGFloat
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		path.move(to: CGPoint(x: rect.minX + lowerWidth, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX - upperWidth, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + height))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + height))
		path.rotation(rotation)
		path.closeSubpath()
		return path
	}
}
