//
//  PopoverButtonView.swift
//  Webflow
//
//  Created by Nick Black on 11/1/23.
//

import SwiftUI

struct PopoverButtonView<Label: View, PopoverContent: View>: View {
	@State private var isPresented: Bool = false
	@ViewBuilder var label: Label
	@ViewBuilder var content: PopoverContent
	var attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds)
	var arrowEdge: Edge = .top
	
    var body: some View {
		Button {
			isPresented.toggle()
		} label: {
			label
				.buttonLabel()
		}
		.buttonStyle(.plain)
		.popover(isPresented: $isPresented, attachmentAnchor: attachmentAnchor, arrowEdge: arrowEdge, content: {
			content
		})
    }
}

#Preview {
	PopoverButtonView(label: {
		HStack {
			Label("Designing", image: "paintBrush")
			Image("chevronDown")
		}
	}, content: {
		
	})
}
