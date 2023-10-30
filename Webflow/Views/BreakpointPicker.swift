//
//  BreakpointPicker.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI
import Foundation

enum Breakpoint: String, CaseIterable {
	case desktopXXL = "1920px and up"
	case desktopXL = "1440px and up"
	case desktop = "1280px and up"
	case laptop = "Laptop"
	case tablet = "Table"
	case mobileLandscape = "Mobile Landscape"
	case mobile = "Mobile"
	
	var icon: String {
		switch self {
			case .desktopXXL: "DeviceDesktopXXLIcon"
			case .desktopXL: "DeviceDesktopXLIcon"
			case .desktop: "DeviceDesktopIcon"
			case .laptop: "DeviceLaptopStarIcon"
			case .tablet: "DeviceTabletPortraitIcon"
			case .mobileLandscape: "DeviceMobileLandscapeIcon"
			case .mobile: "DeviceMobilePortraitIcon"
		}
	}
	
	var widths: (CGFloat, CGFloat) {
		switch self {
			case .desktopXXL: (1920, .infinity)
			case .desktopXL: (1440, 1919)
			case .desktop: (1280, 1439)
			case .laptop: (992, 1279)
			case .tablet: (768, 991)
			case .mobileLandscape: (479, 767)
			case .mobile: (1, 478)
		}
	}
}

struct BreakpointPicker: View {
	@State private var currentBreakpoint: Breakpoint = .laptop
	@State private var currentWidth: CGFloat = 991.0
	
	init() {
		for breakpoint in Breakpoint.allCases {
			if (breakpoint.widths.0...breakpoint.widths.1).contains(currentWidth) {
				self._currentBreakpoint = State(initialValue: breakpoint)
				break
			}
		}
	}
	
    var body: some View {
		HStack {
			ForEach(Breakpoint.allCases, id: \.self) { breakpoint in
				Button {
					withAnimation {
						currentBreakpoint = breakpoint
						currentWidth = breakpoint.widths.0
					}
				} label: {
					Image(breakpoint.icon)
						.padding(.all, 10)
						.background(currentBreakpoint == breakpoint ? .background2 : .clear)
				}
				.buttonStyle(.plain)
			}
			
			Text("\(Int(currentWidth)) \(Text("PX").foregroundStyle(.secondary))")
		}
		.pickerStyle(.palette)
    }
}

#Preview {
    BreakpointPicker()
}
