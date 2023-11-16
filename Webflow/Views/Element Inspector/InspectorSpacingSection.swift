//
//  InspectorSpacingSection.swift
//  Webflow
//
//  Created by Nick Black on 11/9/23.
//

import SwiftUI

struct InspectorSpacingSection: View {
	@State private var rotationAngle: Double = 0.0

	
    var body: some View {
		VStack(spacing: 0) {
			TrapezoidShape(
				rotation: .degrees(0),
				height: -25,
				upperWidth: 50,
				lowerWidth: 50
			)
			.fill(Color.blue)
			
			HStack(spacing: 0) {
				TrapezoidShape(
					rotation: .degrees(90),
					height: -36,
					upperWidth: -25,
					lowerWidth: -25
				)
				.fill(Color.blue)
				.rotationEffect(.degrees(90))
				.frame(maxHeight: 112)
			}
			
			TrapezoidShape(
				rotation: .degrees(45),
				height: 25,
				upperWidth: 50,
				lowerWidth: 50
			)
			.fill(Color.blue)
//			HStack {
//				TrapezoidShape(upperWidth: 112, lowerWidth: 64, height: 25)
//					.fill(Color.blue)
//					.rotationEffect(.degrees(-90))
//				
//				Spacer()
//				
//				TrapezoidShape(upperWidth: 112, lowerWidth: 64, height: 25)
//					.fill(Color.blue)
//					.rotationEffect(.degrees(90))
//			}
//			
//			TrapezoidShape(upperWidth: 224, lowerWidth: 168, height: 25)
//				.fill(Color.blue)
//				.rotationEffect(.degrees(180))
		}
			
//		HStack(spacing: 0) {
//			TrapezoidShape(upperWidth: 5, lowerWidth: 60, height: 0)
//				.fill(Color.blue)
//				.rotationEffect(.degrees(90))
//			
//			VStack(spacing: 0) {
//				TrapezoidShape(upperWidth: 224, lowerWidth: 112, height: 24)
//					.fill(Color.blue)
//				
//				TrapezoidShape(upperWidth: 112, lowerWidth: 224, height: 24)
//					.fill(Color.blue)
//			}
//			
//			TrapezoidShape(upperWidth: 112, lowerWidth: 5, height: 24)
//				.fill(Color.blue)
////				.rotationEffect(.degrees(90))
//		}
    }
}

#Preview {
    InspectorSpacingSection()
		.frame(width: 224, height: 112)
}


struct SpacingButton: View {
	@State private var isPresented: Bool = false
	var space: CGFloat?
	var rotate: Double?
	
	var body: some View {
		Button {
			isPresented.toggle()
		} label: {

		}
		.overlay {
			Text("\(space ?? 0, specifier: "%.0f")px")
				.frame(width: 36, height: 112)
		}
		.foregroundStyle(.primary)
		
		.padding(5)
//		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
		.popover(isPresented: $isPresented, content: {
			Text("Hello")
		})
	}
}
