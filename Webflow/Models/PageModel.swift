//
//  PageModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

struct EmptyPageModel: Codable {
	var image: String
	var title: String
	var description: String
}

@Model
class PageModel: Codable, Searchable {
	@Attribute(.unique) var id: UUID = UUID()
	@Attribute(.unique) var name: String
	@Attribute(.unique) var slug: String {
		"/\(self.name)"
	}
	var status: Status
	var website: WebsiteModel? = nil
	var categoryId: Category.RawValue
	var category: Category
	var parent: PageModel?
	var createdAt: Date = Date()
	var isHome: Bool
	var index: Int
	
	@Relationship(deleteRule: .cascade)
	var body: ElementModel
	
	@Relationship(deleteRule: .cascade, inverse: \PageModel.parent)
	var children: [PageModel]?
	
	init(name: String, status: Status = .Published, body: ElementModel = .init(name: "Body"), typeId: Category.RawValue = Category.Static.rawValue, type: Category = .Static, childPages: [PageModel] = [], isHome: Bool = false, index: Int) {
		self.name = name
		self.status = status
		self.body = body
		self.categoryId = typeId
		self.category = type
		self.children = childPages
		self.isHome = isHome
		self.index = index
	}
	
	enum CodingKeys: CodingKey {
		case id
		case name
		case status
		case website
		case typeId
		case type
		case body
		case childPages
		case isHome
		case index
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		status = try container.decode(Status.self, forKey: .status)
		website = try container.decode(WebsiteModel.self, forKey: .website)
		categoryId = try container.decode(String.self, forKey: .typeId)
		category = try container.decode(Category.self, forKey: .type)
		body = try container.decode(ElementModel.self, forKey: .body)
		children = try container.decode([PageModel].self, forKey: .childPages)
		isHome = try container.decode(Bool.self, forKey: .isHome)
		index = try container.decode(Int.self, forKey: .index)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(status, forKey: .status)
		try container.encode(website, forKey: .website)
		try container.encode(categoryId, forKey: .typeId)
		try container.encode(category, forKey: .type)
		try container.encode(body, forKey: .body)
		try container.encode(children, forKey: .childPages)
		try container.encode(isHome, forKey: .isHome)
		try container.encode(index, forKey: .index)
	}
}

extension PageModel {
	enum Status: String, CaseIterable, Codable {
		case Published
		case StagedForPublishing = "Stage For Publishing"
		case Draft
	}
	
	enum Category: String, CaseIterable, Codable {
		case Static
		case Utility
		case CMS = "CMS Collection"
		case Ecommerce
		case User
		
		var emptyView: EmptyPageModel {
			switch self {
				case .CMS:
					return .init(image: "EmptyNoCmsItemsIcon", title: "No CMS Collection pages", description: "Create a CMS Collection and a CMS Collection page will be generated automatically.")
				case .Ecommerce:
					return .init(image: "EmptyNoCommerceIcon", title: "No CMS Collection pages", description: "Create a CMS Collection and a CMS Collection page will be generated automatically.")
				case .User:
					return .init(image: "EmptyNoUsersIcon", title: "No User pages", description: "Enable Users for this project and the Users template pages will be generated automatically.")
				default:
					return .init(image: "", title: "", description: "")
			}
		}
	}
}
