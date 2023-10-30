//
//  EmptyPageDetailView.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct EmptyPageDetailView: View {
	var body: some View {
		VStack {
			Spacer()
			
			HStack {
				Spacer()
				
				Button {
					
				} label: {
					Label("Add a layout", systemImage: "plus")
						.padding()
						.background(.blue.opacity(0.25))
						.foregroundStyle(Color.accentColor)
						.clipShape(RoundedRectangle(cornerRadius: 5))
				}
				
				Spacer()
			}
			
			Spacer()
		}
		.background {
			Rectangle()
				.fill(.clear)
				.border(.gray.opacity(0.5), width: 5)
		}
		.padding(2)
		.background {
			Rectangle()
				.strokeBorder(.secondary, style: StrokeStyle(dash: [5]))
		}
		.padding()
	}
}

#Preview {
	EmptyPageDetailView()
}
