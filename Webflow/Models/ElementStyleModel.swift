//
//  ElementStyleModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
final class ElementStyleModel: Codable {
	var display: Display?
	var overflow: Overflow?
	var aspectRatio: AspectRatio?
	var classes: [ClassModel]?
	var element: ElementModel?
	
	@Relationship(deleteRule: .cascade, inverse: \SpacingModel.element)
	var spacing: SpacingModel?
	
	@Relationship(deleteRule: .cascade, inverse: \SizeModel.element)
	var size: SizeModel?
	
	init(display: Display? = nil, overflow: Overflow? = nil, aspectRatio: AspectRatio? = nil, classes: [ClassModel]? = nil, element: ElementModel? = nil, spacing: SpacingModel? = nil, size: SizeModel? = nil) {
		self.display = display
		self.overflow = overflow
		self.aspectRatio = aspectRatio
		self.classes = classes
		self.element = element
		self.spacing = spacing
		self.size = size
	}
	
	enum CodingKeys: CodingKey {
		case display
		case overflow
		case ratio
		case classes
		case element
		case spacing
		case size
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		display = try container.decode(Display.self, forKey: .display)
		overflow = try container.decode(Overflow.self, forKey: .overflow)
		aspectRatio = try container.decode(AspectRatio.self, forKey: .ratio)
		classes = try container.decode([ClassModel].self, forKey: .classes)
		element = try container.decode(ElementModel.self, forKey: .element)
		spacing = try container.decode(SpacingModel.self, forKey: .spacing)
		size = try container.decode(SizeModel.self, forKey: .size)
		
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(element, forKey: .element)
		try container.encode(display, forKey: .display)
		try container.encode(overflow, forKey: .overflow)
		try container.encode(aspectRatio, forKey: .ratio)
		try container.encode(classes, forKey: .classes)
		try container.encode(element, forKey: .element)
		try container.encode(spacing, forKey: .spacing)
		try container.encode(size, forKey: .size)
	}
}

extension ElementStyleModel {
	enum AspectRatio: String, CaseIterable, Codable {
		case Auto
		case Anamorphic
		case Univisium
		case Widescreen
		case Landscape
		case Portrait
		case Square
		case Custom
	}
	
	enum Display: String, Identifiable, CaseIterable, Codable {
		case Block
		case Flex
		case Grid
		case InlineBlock = "Inline Block"
		case Inline
		case Hidden
		
		var description: String {
			switch self {
				case .Block: return "Block elements start on a new line and take up the full available width."
				case .Flex: return "Block elements start on a new line and take up the full available width."
				case .Grid: return "Block elements start on a new line and take up the full available width."
				case .InlineBlock: return "Block elements start on a new line and take up the full available width."
				case .Inline: return "Block elements start on a new line and take up the full available width."
				case .Hidden: return "Block elements start on a new line and take up the full available width."
			}
		}
		
		var icon: String {
			switch self {
				case .Block: "rectangle.arrowtriangle.2.inward"
				case .Flex: "rectangle.split.2x1"
				case .Grid: "square.grid.2x2"
				case .InlineBlock: "rectangle.portrait.arrowtriangle.2.inward"
				case .Inline: "textformat.abc.dottedunderline"
				case .Hidden: "eye.slash"
			}
		}
		
		var id: Self { self }
	}
	
	enum Overflow: String, CaseIterable, Codable {
		case Visible
		case Hidden
		case Scroll
		case Auto
		
		var icon: String {
			switch self {
				case .Visible: "ShowIcon"
				case .Hidden: "HideIcon"
				case .Scroll: "OverflowScrollIcon"
				case .Auto: ""
			}
		}
	}
	
	enum Fit: String, CaseIterable, Codable {
		case Fill
		case Contain
		case Cover
		case None
		case ScaleDown = "Scale Down"
	}
	
	enum Position: String, CaseIterable, Codable {
		case Static
		case Relative
		case Absolute
		case Fixed
		case Sticky
	}
	
	enum Float: String, CaseIterable, Codable {
		case None
		case Left
		case Right
	}
	
	enum Clear: String, CaseIterable, Codable {
		case None
		case Left
		case Right
		case Both
	}
	
	enum Align: String, CaseIterable, Codable {
		case Left
		case Center
		case Right
		case Justify
	}
	
	enum Italicize: String, CaseIterable, Codable {
		case Regular
		case Italic
	}
	
	enum Clipping: String, CaseIterable, Codable {
		case None
		case Padding = "Clip background to padding"
		case Content = "Clip background to content"
		case Text = "Clip background to text"
	}
	
	enum Border: String, CaseIterable, Codable {
		case None
		case Solid
		case Dashed
		case Dotted
	}
	
	enum Blending: String, CaseIterable, Codable {
		case Normal
		case Darken
		case Multiply
		case ColorBurn = "Color Burn"
		case Lighten
		case Screen
		case ColorDodge = "Color Dodge"
		case Overlay
		case SoftLight = "Soft Light"
		case HardLight = "Hard light"
		case Difference
		case Exclusion
		case Hue
		case Saturation
		case Color
		case Luminosity
	}
	
	enum Outline: String, CaseIterable, Codable {
		case None
		case Solid
		case Dashed
		case Dotted
	}
	
}
