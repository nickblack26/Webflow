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
	var element: ElementStyleModel? = nil
	var marginTop: CGFloat?
	var marginRight: CGFloat?
	var marginBottom: CGFloat?
	var marginLeft: CGFloat?
	var paddingTop: CGFloat?
	var paddingRight: CGFloat?
	var paddingBottom: CGFloat?
	var paddingLeft: CGFloat?
	
	init(margin: CGFloat? = nil, padding: CGFloat? = nil) {
		self.marginTop = margin
		self.marginRight = margin
		self.marginBottom = margin
		self.marginLeft = margin
		self.paddingTop = padding
		self.paddingRight = padding
		self.paddingBottom = padding
		self.paddingLeft = padding
	}
	
	init(marginVertical: CGFloat? = nil, marginHorizontal: CGFloat? = nil, paddingVertical: CGFloat? = nil, paddingHorizontal: CGFloat? = nil) {
		self.marginTop = marginVertical
		self.marginRight = marginHorizontal
		self.marginBottom = marginVertical
		self.marginLeft = marginHorizontal
		self.paddingTop = paddingVertical
		self.paddingRight = paddingHorizontal
		self.paddingBottom = paddingVertical
		self.paddingLeft = paddingHorizontal
	}
	
	init(marginTop: CGFloat? = nil, marginHorizontal: CGFloat? = nil, marginBottom: CGFloat? = nil, paddingTop: CGFloat? = nil, paddingHorizontal: CGFloat? = nil, paddingBottom: CGFloat? = nil) {
		self.marginTop = marginTop
		self.marginRight = marginHorizontal
		self.marginBottom = marginBottom
		self.marginLeft = marginHorizontal
		self.paddingTop = paddingTop
		self.paddingRight = paddingHorizontal
		self.paddingBottom = paddingBottom
		self.paddingLeft = paddingHorizontal
	}
	
	init(marginTop: CGFloat? = nil, marginRight: CGFloat? = nil,  marginBottom: CGFloat? = nil, marginLeft: CGFloat? = nil, paddingTop: CGFloat? = nil, paddingRight: CGFloat? = nil, paddingBottom: CGFloat? = nil, paddingLeft: CGFloat? = nil) {
		self.marginTop = marginTop
		self.marginRight = marginRight
		self.marginBottom = marginBottom
		self.marginLeft = marginLeft
		self.paddingTop = paddingTop
		self.paddingRight = paddingRight
		self.paddingBottom = paddingBottom
		self.paddingLeft = paddingLeft
	}
	
	enum CodingKeys: CodingKey {
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
