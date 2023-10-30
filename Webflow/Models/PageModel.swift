//
//  PageModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

struct EmptyPageModel {
	var image: String
	var title: String
	var description: String
}

@Model
class PageModel {
	@Attribute(.unique) var id: UUID
	@Attribute(.unique) var name: String
	var elementStatus: ElementStatus
	var website: WebsiteModel?
	var type: PageType
	
	@Relationship(deleteRule: .cascade)
	var body: ElementModel
	
	init(id: UUID = UUID(), name: String, elementStatus: ElementStatus = .Public, website: WebsiteModel? = nil, body: ElementModel = .init(name: "Body"), type: PageType = .generic) {
		self.id = id
		self.name = name
		self.elementStatus = elementStatus
		self.website = website
		self.body = body
		self.type = type
	}
}

extension PageModel {
	enum ElementStatus: String, CaseIterable, Codable {
		case Public
		case Draft
	}
	
	enum PageType: String, CaseIterable, Codable {
		case generic = "Static"
		case utility = "Utility"
		case cms = "CMS Collection"
		case ecommerce = "Ecommerce"
		case user = "User"
		
		var emptyView: EmptyPageModel {
			switch self {
				case .cms:
					return .init(image: "EmptyNoCmsItemsIcon", title: "No CMS Collection pages", description: "Create a CMS Collection and a CMS Collection page will be generated automatically.")
				case .ecommerce:
					return .init(image: "EmptyNoCommerceIcon", title: "No CMS Collection pages", description: "Create a CMS Collection and a CMS Collection page will be generated automatically.")
				case .user:
					return .init(image: "EmptyNoUsersIcon", title: "No User pages", description: "Enable Users for this project and the Users template pages will be generated automatically.")
				default:
					return .init(image: "", title: "", description: "")
			}
		}
	}
}
