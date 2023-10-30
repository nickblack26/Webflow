//
//  ElementSettings.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class ElementSettingsModel {
	@Attribute(.unique) var id: UUID
	var pageId: String?
	var tag: ElementSettingsTag
	var excludeFromSearch: Bool
	var element: ElementModel?
	
	init(id: UUID = UUID(), pageId: String? = nil, tag: ElementSettingsTag = .Div, excludeFromSearch: Bool = false) {
		self.id = id
		self.pageId = pageId
		self.tag = tag
		self.excludeFromSearch = excludeFromSearch
	}
}

extension ElementSettingsModel {
	enum ElementSettingsTag: String, CaseIterable, Codable {
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
