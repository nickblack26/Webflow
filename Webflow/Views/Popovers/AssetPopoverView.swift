//
//  AssetPopoverView.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import SwiftUI

enum AssetAltCategory: String, CaseIterable {
	case Descriptive
	case Decorative
}

struct AssetPopoverView: View {
	@State private var altCategory: AssetAltCategory = .Descriptive
	@State private var altText: String = ""
	@Binding var showPopover: Bool
	
    var body: some View {
		Form {
			HStack {
				Text("Asset Details")
					.fontWeight(.medium)
				
				Spacer()
				
				Button {
					showPopover = false
				} label: {
					Image("CloseDefaultIcon")
						.buttonHoverEffect()
				}
				.buttonStyle(.plain)
			}
			.padding(.horizontal, 8)
			.padding(.top, 8)
			
			Divider()
			
			HStack {
				Text("ben-kolde-bs2Ba7t69mM-unsplash.jpg")
					.lineLimit(1)
				
				Button {
					showPopover = false
				} label: {
					Image("TabNewIcon")
						.buttonHoverEffect()
				}
				.buttonStyle(.plain)
				
				Button {
					showPopover = false
				} label: {
					Image("LinkIcon")
						.buttonHoverEffect()
				}
				.buttonStyle(.plain)
			}
			.padding(.horizontal, 8)
			
			HStack {
				HStack {
					Image("ImageResolutionIcon")
					Text("3456px x 4408px")
					
				}
				HStack {
					Image("PerformanceIcon")
					Text("1.44 MB")
				}
			}
			.padding(.horizontal, 8)
			
			Section {
				Picker("Alt Category", selection: $altCategory) {
					ForEach(AssetAltCategory.allCases, id: \.self) { category in
						Text(category.rawValue)
							.tag(category)
					}
				}
				.pickerStyle(.segmented)
			
				if altCategory == .Descriptive {
					TextField("Alt Text", text: $altText, prompt: Text("A cute hedgehog curled into a ball."), axis: .vertical)
						.lineLimit(4, reservesSpace: true)
						.textFieldStyle(.roundedBorder)
				}
			} header: {
				Text("Alt Text")
			} footer: {
				if altCategory == .Descriptive {
					Text("Write a description of this image. Alt text is used by screen readers and/or if an image doesn't load.")
						.padding(8)
						.background(.background2)
						.clipShape(RoundedRectangle(cornerRadius: 5))
				} else {
					Text("Decorative images don't convey meaning and don't require alt text.")
				}
			}
			.padding(.horizontal, 8)
			
			Button {
				
			} label: {
				Label("Delete", image: "DeleteIcon")
			}
			.buttonStyle(.borderedProminent)
			.tint(.background2)
			.padding(.horizontal, 8)
		}
		.formStyle(.columns)
		.frame(width: 300)
    }
}

#Preview {
	AssetPopoverView(showPopover: .constant(true))
}
