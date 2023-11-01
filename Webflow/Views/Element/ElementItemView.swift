//
//  ElementItemView.swift
//  Webflow
//
//  Created by Nick on 10/9/23.
//

import SwiftUI

struct ElementItemView: View {
	var element: ElementModel
    var body: some View {
		NavigationLink(value: element) {
			VStack {
				
			}
		}
		.buttonStyle(.plain)
    }
}

//#Preview {
//    ElementItemView()
//}
