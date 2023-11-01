//
//  ElementSettings.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class ElementSettingsModel: Codable {
	@Attribute(.unique) var id: UUID
	var pageId: String?
	var tag: HTMLTag
	var excludeFromSearch: Bool
	var element: ElementModel?
	
	init(id: UUID = UUID(), pageId: String? = nil, tag: HTMLTag = .Div, excludeFromSearch: Bool = false) {
		self.id = id
		self.pageId = pageId
		self.tag = tag
		self.excludeFromSearch = excludeFromSearch
	}
	
	enum CodingKeys: CodingKey {
		case id
		case pageId
		case tag
		case excludeFromSearch
		case element
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		pageId = try container.decode(String.self, forKey: .pageId)
		tag = try container.decode(HTMLTag.self, forKey: .tag)
		excludeFromSearch = try container.decode(Bool.self, forKey: .excludeFromSearch)
		element = try container.decode(ElementModel.self, forKey: .element)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(pageId, forKey: .pageId)
		try container.encode(tag, forKey: .tag)
		try container.encode(excludeFromSearch, forKey: .excludeFromSearch)
		try container.encode(element, forKey: .element)
	}
}

extension ElementSettingsModel {
	enum HTMLTag: String, CaseIterable, Codable {
		case Div
		case Header
		case Footer
		case Nav
		case Main
		case Section
		case Article
		case Aside
		case Address
		case Figure
		var id: Self { self }
	}
}
