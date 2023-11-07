//
//  ElementInteractionsView.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import SwiftUI

struct ElementInteractionsView: View {
    var body: some View {
		List {
			HStack {
				Text("Interactions")
				
				Spacer()
				
				Button("Clean up"){
					
				}
				.tint(.secondary)
			}
			
			Section {
				ForEach(0..<10, id: \.self) { index in
					VStack(alignment: .leading) {
						Text("Page Load")
							.font(.subheadline)
						Text("<none> / home-intro")
							.font(.caption)
							.foregroundStyle(.secondary)
					}
				}
			} header: {
				HStack {
					Text("Element trigger")
					
					Spacer()
					
					Button {
						 
					} label: {
						 Image("addPanelIcon")
							.resizable()
							.frame(width: 20, height: 20)
					}
					.tint(.secondary)
				}
			}
			.headerProminence(.increased)
			
			Section {
				ForEach(0..<10, id: \.self) { index in
					VStack(alignment: .leading) {
						Text("Page Load")
							.font(.subheadline)
						Text("<none> / home-intro")
							.font(.caption)
							.foregroundStyle(.secondary)
					}
				}
			} header: {
				HStack {
					Text("Page trigger")
					
					Spacer()
					
					Button {
						
					} label: {
						Image("addPanelIcon")
							.resizable()
							.frame(width: 20, height: 20)
					}
					.tint(.secondary)
				}
			}
			.headerProminence(.increased)
		}
		.listStyle(.plain)
		.scrollContentBackground(.hidden)
    }
}

#Preview {
    ElementInteractionsView()
}
