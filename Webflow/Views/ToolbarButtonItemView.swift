//
//  ToolbarButtonItemView.swift
//  Webflow
//
//  Created by Nick on 10/31/23.
//

import SwiftUI

struct ToolbarButtonItemView: View {
	@State private var isHovering: Bool = false
	let size = CGFloat.pixelsToPoints(45)
	var icon: String
	
    var body: some View {
		Image(icon)
			.resizable()
			.frame(width: size(), height: size())
			.padding(.all, 5)
			.onHover(perform: {
				isHovering = $0
				DispatchQueue.main.async {
					if (self.isHovering) {
						NSCursor.pointingHand.push()
					} else {
						NSCursor.pop()
					}
				}
			})
			.background(isHovering ? .background2 : .clear)
			.clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
	ToolbarButtonItemView(icon: "FolderAddIcon")
}
