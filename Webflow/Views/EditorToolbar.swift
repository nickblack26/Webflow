//
//  TopBar.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct EditorToolbar: ToolbarContent {
	var body: some ToolbarContent {
		ToolbarItemGroup(placement: .topBarLeading) {
			HStack {
				Image("webflowLogo")
				
				Divider()
				
				Button {
					
				} label: {
					HStack {
						Image("PageDefaultIcon")
						Text("Home")
					}
					.buttonLabel()
				}
				.buttonStyle(.plain)				
			}
		}
		
		ToolbarItemGroup(placement: .principal) {
			BreakpointPicker()
		}
		
		ToolbarItemGroup {
			Menu {
				Button {
					
				} label: {
					VStack(alignment: .leading) {
						Text("Designing")
						Text("Style elements and build layouts")
					}
					.padding()
				}
				.buttonStyle(.plain)
				
				Button {
					
				} label: {
					VStack(alignment: .leading) {
						Text("Editing")
						Text("Edit static and dynamic content")
					}
					.padding()
				}
				.buttonStyle(.plain)
			} label: {
				HStack {
					Image("paintBrush")
					Text("Designing")
					Image("chevronDown")
				}
				.foregroundStyle(.white)
				.buttonLabel()
			}
			
			Image("checkCircleIcon")
				.foregroundStyle(.green)
			
			Image("codeIcon")

			Image("commentIcon")
			
			Image("previewIcon")
	
			Button {
				
			} label: {
				HStack {
					Image("accountIcon")
					Text("Share")
				}
				.buttonLabel()
				.foregroundStyle(.white)
			}
		}
	}
}
