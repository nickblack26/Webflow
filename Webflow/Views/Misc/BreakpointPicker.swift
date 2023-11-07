import SwiftUI
import Foundation

enum Breakpoint: String, CaseIterable {
	case DesktopXXL = "1920px and up"
	case DesktopXL = "1440px and up"
	case Desktop = "1280px and up"
	case Laptop
	case Tablet
	case MobileLandscape = "Mobile Landscape"
	case Mobile
	
	var icon: String {
		switch self {
			case .DesktopXXL: "DeviceDesktopXXLIcon"
			case .DesktopXL: "DeviceDesktopXLIcon"
			case .Desktop: "DeviceDesktopIcon"
			case .Laptop: "DeviceLaptopStarIcon"
			case .Tablet: "DeviceTabletPortraitIcon"
			case .MobileLandscape: "DeviceMobileLandscapeIcon"
			case .Mobile: "DeviceMobilePortraitIcon"
		}
	}
	
	var widths: (CGFloat, CGFloat) {
		switch self {
			case .DesktopXXL: (1920, .infinity)
			case .DesktopXL: (1440, 1919)
			case .Desktop: (1280, 1439)
			case .Laptop: (992, 1279)
			case .Tablet: (768, 991)
			case .MobileLandscape: (479, 767)
			case .Mobile: (1, 478)
		}
	}
}

struct BreakpointPicker: View {
	@State private var currentBreakpoint: Breakpoint = .Laptop
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
				}
				.buttonStyle(.bordered)
				.tint(.background2)
			}
			
			if Int(currentWidth) > 999 {
				Text("\(Int(currentWidth)) \(Text("PX").foregroundStyle(.secondary))")
			} else if Int(currentWidth) > 99 {
				Text(" \(Int(currentWidth)) \(Text("PX").foregroundStyle(.secondary))")
			} else if Int(currentWidth) > 9 {
				Text("  \(Int(currentWidth)) \(Text("PX").foregroundStyle(.secondary))")
			} else {
				Text("   \(Int(currentWidth)) \(Text("PX").foregroundStyle(.secondary))")
			}
				
		}
		.pickerStyle(.palette)
    }
}

#Preview {
    BreakpointPicker()
}
