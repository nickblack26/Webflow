//
//  EmptyListView.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct EmptyListView: View {
	var item: EmptyPageModel
	
    var body: some View {
		VStack {
			Image(item.image)
			Text(item.title)
				.font(.headline)
				.fontWeight(.medium)
			
			Text(item.description)
				.foregroundStyle(.secondary)
				.fontWeight(.light)
		}
		.frame(maxWidth: .infinity)
		.multilineTextAlignment(.center)
		.padding()
    }
}

#Preview {
	EmptyListView(item: .init(image: "EmptyNoCmsItemsIcon", title: "No CMS Collection pages", description: "Create a CMS Collection and a CMS Collection page will be generated automatically."))
}
