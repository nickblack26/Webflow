//
//  EmptyListView.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct EmptyListView: View {
	var image: String
	var title: String
	var description: String
	
    var body: some View {
		VStack {
			Image(image)
			Text(title)
				.font(.headline)
				.fontWeight(.medium)
			
			Text(description)
				.foregroundStyle(.secondary)
				.fontWeight(.light)
				.font(.subheadline)
		}
		.frame(maxWidth: .infinity)
		.multilineTextAlignment(.center)
		.padding()
		.background(Color("Background"))
		.clipShape(RoundedRectangle(cornerRadius: 7.5))
    }
}

#Preview {
	EmptyListView(image: "EmptyNoCmsItemsIcon", title: "No CMS Collection pages", description: "Create a CMS Collection and a CMS Collection page will be generated automatically.")
}
