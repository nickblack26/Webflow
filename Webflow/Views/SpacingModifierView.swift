//
//  SpacingModifier.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct SpacingModifierView: View {
    var body: some View {
		LazyVGrid(columns: Array(repeating: GridItem(), count: 3), content: {
			Text("0")
				.background(.secondary)
				.frame(maxWidth: .infinity)
		})
		Grid {
			GridRow(alignment: .center) {
				Text("0")
					.background(.secondary)
			}
			.frame(maxWidth: .infinity)
			
			GridRow(alignment: .center) {
				Text("0")
					.background(.secondary)
					.frame(maxWidth: .infinity)
			}
		}
		.frame(maxWidth: .infinity)
    }
}

#Preview {
    SpacingModifierView()
		.frame(width: 500, height: 500)
}
