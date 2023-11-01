//
//  ClassModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class ClassModel: Codable {
	@Attribute(.unique) var id: UUID
	@Attribute(.unique) var name: String
	@Relationship(deleteRule: .cascade, inverse: \ElementStyleModel.elementClass) var style: ElementStyleModel?
	var element: ElementModel?
	
	init(id: UUID = UUID(), name: String, style: ElementStyleModel? = nil) {
		self.id = id
		self.name = name
		self.style = style
	}
	
	enum CodingKeys: CodingKey {
		case id
		case name
		case style
		case element
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		style = try container.decode(ElementStyleModel.self, forKey: .style)
		element = try container.decode(ElementModel.self, forKey: .element)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(style, forKey: .style)
		try container.encode(element, forKey: .element)
	}
}
