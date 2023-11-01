//
//  WebsiteModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class WebsiteModel: Codable {
	@Attribute(.unique) var id: UUID
	@Attribute(.unique) var name: String
	@Relationship(deleteRule: .cascade, inverse: \PageModel.website) var pages = [PageModel]()
	
	init(id: UUID = UUID(), name: String, pages: [PageModel] = [PageModel]()) {
		self.id = id
		self.name = name
		self.pages = pages
	}
	
	enum CodingKeys: CodingKey {
		case id
		case name
		case pages
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		pages = try container.decode([PageModel].self, forKey: .pages)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(pages, forKey: .pages)
	}
}
