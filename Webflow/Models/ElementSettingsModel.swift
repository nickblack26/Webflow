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
	var pageId: String?
	var tag: HTMLTag
	var excludeFromSearch: Bool
	var element: ElementModel?
	
	init(pageId: String? = nil, tag: HTMLTag = .Div, excludeFromSearch: Bool = false) {
		self.pageId = pageId
		self.tag = tag
		self.excludeFromSearch = excludeFromSearch
	}
	
	enum CodingKeys: CodingKey {
		case pageId
		case tag
		case excludeFromSearch
		case element
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		pageId = try container.decode(String.self, forKey: .pageId)
		tag = try container.decode(HTMLTag.self, forKey: .tag)
		excludeFromSearch = try container.decode(Bool.self, forKey: .excludeFromSearch)
		element = try container.decode(ElementModel.self, forKey: .element)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
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
		
		var icon: String {
			switch self {
				case .Div:
					"ElementDivIcon"
				case .Header:
					"ElementDivIcon"
				case .Footer:
					"ElementDivIcon"
				case .Nav:
					"ElementDivIcon"
				case .Main:
					"ElementDivIcon"
				case .Section:
					"ElementDivIcon"
				case .Article:
					"ElementDivIcon"
				case .Aside:
					"ElementDivIcon"
				case .Address:
					"ElementDivIcon"
				case .Figure:
					"ElementDivIcon"
			}
		}
	}
}
