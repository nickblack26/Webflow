//
//  PublishingPopoverView.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import SwiftUI

struct PublishingPopoverView: View {
	@State private var publishStaging: Bool = true
	@State private var publishProduction: Bool = false
	@State private var startPublishing: Bool = false
	@State private var isPreparingToPublish: Bool = true
	@State private var isOptimizing: Bool = false
	@State private var isPackaging: Bool = false
	@State private var isDeploying: Bool = false
	@State private var isPrepared: Bool = true
	@State private var isOptimized: Bool = false
	@State private var isPackaged: Bool = false
	@State private var isDeployed: Bool = false
	@State private var rotationAngle: Double = 0

	
	@Binding var isPresented: Bool
	
	var body: some View {
		Form {
			Text(startPublishing ? "Publishing in progress" : "Choose publish destination")
				.padding(.horizontal, 8)
				.padding(.top, 8)
			
			Divider()
			
			if !startPublishing {
				Section("Staging") {
					HStack(alignment: .top) {
						
						ZStack {
							RoundedRectangle(cornerRadius: 2)
								.fill(publishStaging ? .accent : .background2)
								.frame(width: 15, height: 15, alignment: .center)
							
							if publishStaging {
								Image("CheckDefaultIcon")
									.resizable()
									.frame(width: 15, height: 15, alignment: .center)
									.foregroundColor(.white)
							}
						}
						
						
						VStack(alignment: .leading, content: {
							Text("the-hourglass-agency.webflow.io")
								.foregroundStyle(.secondary)
								.font(.callout)
							Text("Not published")
								.foregroundStyle(.secondary)
								.font(.callout)
						})
						.frame(maxWidth: .infinity, alignment: .leading)
					}
					.onTapGesture {
						publishStaging.toggle()
					}
				}
				.padding(.horizontal, 8)
			} else {
				VStack(alignment: .leading) {
					HStack {
						Image(isPrepared ? "checkCircleIcon" : "RefreshIcon")
							.rotationEffect(Angle(degrees: rotationAngle))
							.contentTransition(.symbolEffect(.replace))

						Text("Preparing to publish")
					}
					
					
					HStack {
						Image(isOptimizing ? "RefreshIcon" : "MoreIcon")
							.rotationEffect(Angle(degrees: rotationAngle))
							.contentTransition(.symbolEffect(.replace))
						
						Text("Optimizing HTML, CSS, and JS files")
					}
					
					HStack {
						Image(isPackaging ? "RefreshIcon" : "MoreIcon")
							.rotationEffect(Angle(degrees: rotationAngle))
							.contentTransition(.symbolEffect(.replace))
						Text("Packaging everything up")
					}
					
					HStack {
						Image(isDeployed ? "RefreshIcon" : "MoreIcon")
							.rotationEffect(Angle(degrees: rotationAngle))
							.contentTransition(.symbolEffect(.replace))
						Text("Deploying to CDN")
					}
					
				}
				
			}
			
			Divider()
			
			Section("Production") {
				HStack(alignment: .top) {
					ZStack {
						RoundedRectangle(cornerRadius: 2)
							.fill(publishProduction ? .accent : .background2)
							.frame(width: 15, height: 15, alignment: .center)
						
						if publishProduction {
							Image("CheckDefaultIcon")
								.resizable()
								.frame(width: 15, height: 15, alignment: .center)
								.foregroundColor(.white)
						}
					}
					
					VStack(alignment: .leading, content: {
						Text("Custom domain")
							.foregroundStyle(.secondary)
							.font(.callout)
						
						Text("Add a custom domain")
							.foregroundStyle(.secondary)
							.font(.callout)
							.underline()
					})
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				.onTapGesture {
					publishProduction.toggle()
				}
			}
			.padding(.horizontal, 8)
			
			Divider()
				.frame(height: startPublishing ? 1 : 2)
			
			HStack {
				Button("Close") {
					isPresented.toggle()
				}
				.buttonStyle(.borderedProminent)
				.tint(.background2)
				
				if !startPublishing {
					Button("Publish to selected domains") {
						withAnimation(.easeInOut(duration: 0.3)) {
							startPublishing.toggle()
							isPreparingToPublish.toggle()
							rotationAngle += 180
						} completion: {
							rotationAngle = 0
							withAnimation {
								isPrepared.toggle()
								isOptimizing.toggle()
								rotationAngle += 180
							} completion: {
								rotationAngle = 0
								withAnimation {
									isOptimized.toggle()
									isPackaging.toggle()
								} completion: {
									rotationAngle = 0
									withAnimation {
										isPackaged.toggle()
										isDeploying.toggle()
										rotationAngle += 180
									} completion: {
										rotationAngle = 0
										withAnimation {
											isDeployed.toggle()
											rotationAngle += 180
										}
									}
								}
							}
						}
						rotationAngle = startPublishing ? 180 : 0
					}
					.buttonStyle(.borderedProminent)
					.tint(.accent)
					.disabled(!publishStaging && !publishProduction)
				}
			}
			.frame(maxWidth: .infinity, alignment: .trailing)
			.padding(.horizontal, 8)
			.padding(.bottom, 8)
		}
		.formStyle(.columns)
		.frame(width: 500, alignment: .leading)
	}
}

#Preview {
	
	
	return PublishingPopoverView(isPresented: .constant(true))
}
