//
//  SizeModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class SizeModel: Codable {
	@Attribute(.unique) var id: UUID
	var element: ElementStyleModel?
	var width: CGFloat?
	var height: CGFloat?
	var minWidth: CGFloat?
	var minHeight: CGFloat?
	var maxWidth: CGFloat?
	var maxHeight: CGFloat?
	
	init(id: UUID = UUID(), element: ElementStyleModel? = nil, width: CGFloat? = nil, height: CGFloat? = nil, minWidth: CGFloat? = nil, minHeight: CGFloat? = nil, maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) {
		self.id = id
		self.element = element
		self.width = width
		self.height = height
		self.minWidth = minWidth
		self.minHeight = minHeight
		self.maxWidth = maxWidth
		self.maxHeight = maxHeight
	}
	
	enum CodingKeys: CodingKey {
		case id
		case element
		case width
		case height
		case minWidth
		case minHeight
		case maxWidth
		case maxHeight
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		element = try container.decode(ElementStyleModel.self, forKey: .element)
		width = try container.decode(CGFloat.self, forKey: .width)
		height = try container.decode(CGFloat.self, forKey: .height)
		minWidth = try container.decode(CGFloat.self, forKey: .minWidth)
		minHeight = try container.decode(CGFloat.self, forKey: .minHeight)
		maxWidth = try container.decode(CGFloat.self, forKey: .maxWidth)
		maxHeight = try container.decode(CGFloat.self, forKey: .maxHeight)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(element, forKey: .element)
		try container.encode(width, forKey: .width)
		try container.encode(height, forKey: .height)
		try container.encode(minWidth, forKey: .minWidth)
		try container.encode(minHeight, forKey: .minHeight)
		try container.encode(maxWidth, forKey: .maxWidth)
		try container.encode(maxHeight, forKey: .maxHeight)
	}
}
