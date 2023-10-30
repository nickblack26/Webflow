//
//  WebsiteModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class WebsiteModel {
	@Attribute(.unique) var id: UUID
	@Attribute(.unique) var name: String
	@Relationship(deleteRule: .cascade, inverse: \PageModel.website) var pages = [PageModel]()
	
	init(id: UUID = UUID(), name: String, pages: [PageModel] = [PageModel]()) {
		self.id = id
		self.name = name
		self.pages = pages
	}
}
