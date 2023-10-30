//
//  ClassModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class ClassModel {
	@Attribute(.unique) var id: UUID
	@Attribute(.unique) var name: String
	@Relationship(deleteRule: .cascade, inverse: \ElementStyleModel.elementClass) var style: ElementStyleModel?
	var element: ElementModel
	
	init(id: UUID = UUID(), name: String, style: ElementStyleModel? = nil, element: ElementModel) {
		self.id = id
		self.name = name
		self.style = style
		self.element = element
	}
}
