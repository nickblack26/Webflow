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
	@Attribute(.unique) var name: String
	@Relationship(deleteRule: .cascade, inverse: \ElementStyleModel.classes) var style: ElementStyleModel?
	var element: ElementModel?
	
	init(name: String, style: ElementStyleModel? = nil) {
		self.name = name
		self.style = style
	}
	
	enum CodingKeys: CodingKey {
		case name
		case style
		case element
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		style = try container.decode(ElementStyleModel.self, forKey: .style)
		element = try container.decode(ElementModel.self, forKey: .element)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(style, forKey: .style)
		try container.encode(element, forKey: .element)
	}
}
