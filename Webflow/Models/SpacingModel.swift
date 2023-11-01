//
//  SpacingModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class SpacingModel: Codable {
	@Attribute(.unique) var id: UUID
	var element: ElementStyleModel?
	var marginLeft: CGFloat?
	var marginTop: CGFloat?
	var marginRight: CGFloat?
	var marginBottom: CGFloat?
	var paddingLeft: CGFloat?
	var paddingTop: CGFloat?
	var paddingRight: CGFloat?
	var paddingBottom: CGFloat?
	
	init(id: UUID = UUID(), element: ElementStyleModel? = nil, marginLeft: CGFloat? = nil, marginCenter: CGFloat? = nil, marginRight: CGFloat? = nil, marginBottom: CGFloat? = nil, paddingLeft: CGFloat? = nil, paddingCenter: CGFloat? = nil, paddingRight: CGFloat? = nil, paddingBottom: CGFloat? = nil) {
		self.id = id
		self.element = element
		self.marginLeft = marginLeft
		self.marginTop = marginCenter
		self.marginRight = marginRight
		self.marginBottom = marginBottom
		self.paddingLeft = paddingLeft
		self.paddingTop = paddingCenter
		self.paddingRight = paddingRight
		self.paddingBottom = paddingBottom
	}
	
	enum CodingKeys: CodingKey {
		case id
		case element
		case marginLeft
		case marginCenter
		case marginRight
		case marginBottom
		case paddingLeft
		case paddingCenter
		case paddingRight
		case paddingBottom
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		marginLeft = try container.decode(CGFloat.self, forKey: .marginLeft)
		marginTop = try container.decode(CGFloat.self, forKey: .marginCenter)
		marginRight = try container.decode(CGFloat.self, forKey: .marginRight)
		marginBottom = try container.decode(CGFloat.self, forKey: .marginBottom)
		paddingLeft = try container.decode(CGFloat.self, forKey: .paddingLeft)
		paddingTop = try container.decode(CGFloat.self, forKey: .paddingCenter)
		paddingRight = try container.decode(CGFloat.self, forKey: .paddingRight)
		paddingBottom = try container.decode(CGFloat.self, forKey: .paddingBottom)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(marginLeft, forKey: .marginLeft)
		try container.encode(marginTop, forKey: .marginCenter)
		try container.encode(marginRight, forKey: .marginRight)
		try container.encode(marginBottom, forKey: .marginBottom)
		try container.encode(paddingLeft, forKey: .paddingLeft)
		try container.encode(paddingTop, forKey: .paddingCenter)
		try container.encode(paddingRight, forKey: .paddingRight)
		try container.encode(paddingBottom, forKey: .paddingBottom)
	}
}
