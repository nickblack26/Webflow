//
//  ElementModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
final class ElementModel {
	@Attribute(.unique) var id: UUID
	var name: String
	var elementType: ElementType
	var parentElement: ElementModel?
	
	@Relationship(deleteRule: .cascade, inverse: \ClassModel.element)
	var classes: [ClassModel]
	
	@Relationship(deleteRule: .cascade, inverse: \ElementStyleModel.element)
	var style: ElementStyleModel? = nil
	
	@Relationship(deleteRule: .cascade, inverse: \ElementSettingsModel.element)
	var settings: ElementSettingsModel? = nil
	
	@Relationship(deleteRule: .cascade, inverse: \ElementModel.parentElement)
	var childElements: [ElementModel]
	
	init(id: UUID = UUID(), name: String, elementType: ElementType = .structure, parentElement: ElementModel? = nil, classes: [ClassModel]  = [], style: ElementStyleModel? = nil, settings: ElementSettingsModel? = nil, childElements: [ElementModel] = []) {
		self.id = id
		self.name = name
		self.elementType = elementType
		self.parentElement = parentElement
		self.classes = classes
		self.style = style
		self.settings = settings
		self.childElements = childElements
	}
}

extension ElementModel {
	enum ElementType: String, CaseIterable, Codable {
		case structure
		case basic
		case typography
		case cms
		case media
		case forms
		case advanced
		case other
	}
}
