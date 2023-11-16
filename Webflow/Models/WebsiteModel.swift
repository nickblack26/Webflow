//
//  WebsiteModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData
import UniformTypeIdentifiers
import GroupActivities

@Model final class DomainModel {
	@Attribute(.unique) var name: String
	var isConnected: Bool
	var isDefault: Bool
	var publishedDate: Date
	var website: WebsiteModel?
	
	init(name: String, isConnected: Bool, isDefault: Bool, publishedDate: Date) {
		self.name = name
		self.isConnected = isConnected
		self.isDefault = isDefault
		self.publishedDate = publishedDate
	}
	
	func update<T>(keyPath: ReferenceWritableKeyPath<DomainModel, T>, to value: T) {
		self[keyPath: keyPath] = value
		publishedDate = .now
	}
}

@Model final class RedirectModel {
	@Attribute(.unique) var oldPath: String
	@Attribute(.unique) var newPath: String
	var website: WebsiteModel?
	
	init(oldPath: String, newPath: String) {
		self.oldPath = oldPath
		self.newPath = newPath
	}
}

@Model final class WebsiteModel: Codable, GroupActivity  {
	@Attribute(.unique) var name: String
	@Attribute(.unique) var internalDomain: String {
		"https://www.\(name.lowercased()).webflow.io"
	}
	
	@Relationship(deleteRule: .cascade, inverse: \PageModel.website) var pages = [PageModel]()
	
	@Relationship(deleteRule: .cascade, inverse: \DomainModel.website) var domains: [DomainModel] = []
	
	@Relationship(deleteRule: .cascade, inverse: \RedirectModel.website) var redirects: [RedirectModel] = []
	
	init(name: String, pages: [PageModel] = [PageModel]()) {
		self.name = name
		self.pages = pages
	}
	
	enum CodingKeys: CodingKey {
		case name
		case pages
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		pages = try container.decode([PageModel].self, forKey: .pages)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(pages, forKey: .pages)
	}
	
	var metadata: GroupActivityMetadata {
		var metadata = GroupActivityMetadata()
		metadata.title = NSLocalizedString("Edit Website", comment: self.name)
		metadata.type = .generic
		return metadata
	}
}

extension UTType {
	static let websiteModel = UTType(exportedAs: "com.nicholasblack.Webflow")
}
