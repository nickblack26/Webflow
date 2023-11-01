//
//  AsyncImageGridItemView.swift
//  Webflow
//
//  Created by Nick on 10/30/23.
//

import SwiftUI

struct AsyncImageGridItemView: View {
	@State private var hovering: Bool = false
	var url: URL?
	var title: String?
	
    var body: some View {
		VStack {
			AsyncImage(url: url) { image in
				image
					.resizable()
					.scaledToFit()
					.frame(height: 84)
					.frame(maxWidth: .infinity)
					.background(.gray)
			} placeholder: {
				Rectangle()
					.fill(.gray)
					.frame(height: 84)
					.frame(maxWidth: .infinity)
			}
			
			Text(title ?? "ben-kolde-bs2Ba7t69mM-unsplash.jpg")
				.lineLimit(1)
		}
		.overlay(alignment: .bottomTrailing) {
			Image(systemName: "checkmark.circle")
				.frame(maxWidth: .infinity, alignment: .trailing)
				.background(
					.linearGradient(
						colors: [
							.background.opacity(0.0),
							.background
					],
						startPoint: .bottomLeading,
						endPoint: .bottomTrailing
					)
				)
		}
    }
}

#Preview {
    AsyncImageGridItemView()
}
