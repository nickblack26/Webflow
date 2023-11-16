//
//  SiteListItemView.swift
//  Webflow
//
//  Created by Nick on 10/16/23.
//

import SwiftUI

struct WebsiteListItemView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(WebsiteManager.self) private var websiteManager
	@Environment(NavigationManager.self) private var navigation
	@Environment(\.openWindow) private var openWindow
	
	@State private var hovering: Bool = false
	
	var website: WebsiteModel
	
	var body: some View {
		Button {
			navigation.selectedWebsite = website
		} label: {
			VStack(alignment: .leading) {
				VStack {
					AsyncImage(url: URL(string: "https://screenshots.webflow.com/sites/64be9ae522eb4b9359d95694/20230918134423_4f85cf461336f6724bcb4d000de3ba2b.png")) { image in
						image
							.resizable()
							.aspectRatio(16/9, contentMode: .fill)
					} placeholder: {
						VStack {
							Image(systemName: "photo")
								.frame(height: 155)
								.aspectRatio(16/9, contentMode: .fit)
						}
						.background(.secondary)
					}
					.frame(maxWidth: .infinity)
					.onHover(perform: { hovering = $0})
					
					HStack {
						Image("rocket")
							.font(.title)
							.foregroundStyle(.green)
						
						Text("Basic site")
							.padding(.all, 4)
							.background(.gray.opacity(0.1))
							.clipShape(RoundedRectangle(cornerRadius: 5))
						
						Spacer()
						
						Menu {
							Button(role: .destructive) {
								modelContext.delete(website)
							} label: {
								Label("Delete", systemImage: "trash")
							}
							
							Divider()
							
							Button {
								
							} label: {
								Label("Duplicate", systemImage: "square.on.square")
							}
							
							Button {
								
							} label: {
								Label("Move to folder", systemImage: "folder")
							}
							
							Button {
								
							} label: {
								Label("Share", systemImage: "arrow.turn.up.right")
							}
							
							Button {
								
							} label: {
								Label("Editor", systemImage: "pencil")
							}
							
							Button {
								
							} label: {
								Label("Settings", systemImage: "gear")
							}
						} label: {
							Image(systemName: "ellipsis")
								.padding()
						}
					}
					.padding()
				}
				.background {
					RoundedRectangle(cornerRadius: 4)
						.fill(.clear)
						.border(.secondary.opacity(0.5), width: 1)
				}
				
				Text(website.name)
					.fontWeight(.medium)
				
				Text("thehourglassagency.co")
					.font(.callout)
					.fontWeight(.light)
					.foregroundStyle(.secondary)
			}
		}
	}
}

#Preview {
	LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
		WebsiteListItemView(website: .init(name: "The Hourglass Agency"))
			.environment(previewWebsiteManager)
			.modelContainer(for: WebsiteModel.self, inMemory: true)
	}
}
