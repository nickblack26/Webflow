//
//  ElementStyleModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class ElementStyleModel {
	@Attribute(.unique) var id: UUID
	var layout: DisplayLayout
	var overflow: Overflow
	var ratio: Ratio
	var elementClass: ClassModel?
	var element: ElementModel?
	
	@Relationship(deleteRule: .cascade, inverse: \SpacingModel.element)
	var spacing: SpacingModel?
	
	@Relationship(deleteRule: .cascade, inverse: \SizeModel.element)
	var size: SizeModel?
	
	init(id: UUID = UUID(), layout: DisplayLayout = .Block, overflow: Overflow = .visible, ratio: Ratio = .Auto, elementClass: ClassModel? = nil, element: ElementModel? = nil) {
		self.id = id
		self.layout = layout
		self.overflow = overflow
		self.ratio = ratio
		self.elementClass = elementClass
		self.element = element
		self.spacing = spacing
		self.size = size
	}
}

extension ElementStyleModel {
	enum Ratio: String, CaseIterable, Codable {
		case Auto
	}
	
	enum DisplayLayout: String, Identifiable, CaseIterable, Codable {
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
		case visible
		case hidden
		case scroll
		case auto
	}
}
