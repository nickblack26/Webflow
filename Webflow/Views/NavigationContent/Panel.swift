//
//  Panel.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct Panel<C: View>: View {
	let content: C
	
	init(_ content: () -> (C)) {
		self.content = content()
	}
	
    var body: some View {
		List {
			ZStack {
				content
			}
		}
    }
}

#Preview {
	NavigationSplitView {
		Panel {
			Text("")
		}
		.foregroundStyle(.white)
		.background(Color("PanelColor"))
		.scrollContentBackground(.hidden)
	} detail: {
		
	}
}
