//
//  ElementModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData
import CoreTransferable
import UniformTypeIdentifiers

@Model
final class ElementModel: Codable, Searchable {
	@Attribute(.unique) var id: UUID
	var name: String
	var category: Category
	var parent: ElementModel?
	var icon: String?
	
	@Relationship(deleteRule: .cascade, inverse: \ClassModel.element)
	var classes: [ClassModel]
	
	@Relationship(deleteRule: .cascade, inverse: \ElementStyleModel.element)
	var style: ElementStyleModel?
	
	@Relationship(deleteRule: .cascade, inverse: \ElementSettingsModel.element)
	var settings: ElementSettingsModel?
	
	@Relationship(deleteRule: .cascade, inverse: \ElementModel.parent)
	var children: [ElementModel]?
	
	init(id: UUID = UUID(), name: String, elementType: Category = .Structure, icon: String? = nil, classes: [ClassModel]  = [], style: ElementStyleModel? = nil, settings: ElementSettingsModel? = nil, children: [ElementModel]? = []) {
		self.id = id
		self.name = name
		self.category = elementType
		self.icon = icon
		self.classes = classes
		self.style = style
		self.settings = settings
		self.children = children
	}
	
	enum CodingKeys: CodingKey {
		case id
		case name
		case elementType
		case parent
		case classes
		case style
		case settings
		case children
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(UUID.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		category = try container.decode(Category.self, forKey: .elementType)
		parent = try container.decode(ElementModel.self, forKey: .parent)
		classes = try container.decode([ClassModel].self, forKey: .classes)
		style = try container.decode(ElementStyleModel.self, forKey: .style)
		settings = try container.decode(ElementSettingsModel.self, forKey: .settings)
		children = try container.decode([ElementModel].self, forKey: .children)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(name, forKey: .name)
		try container.encode(category, forKey: .elementType)
		try container.encode(parent, forKey: .parent)
		try container.encode(classes, forKey: .classes)
		try container.encode(style, forKey: .style)
		try container.encode(settings, forKey: .settings)
		try container.encode(children, forKey: .children)
	}
	
	static func defaultElements() -> [ElementModel] {
		[
			.init(name: "Section", icon: "AddPanelSectionIcon"),
			.init(name: "Container", icon: "AddPanelContainerIcon"),
			.init(name: "Quick Stack", icon: "AddPanelQuickStackIcon"),
			.init(name: "V Flex", icon: "AddPanelVFlexIcon"),
			.init(name: "H Flex", icon: "AddPanelHFlexIcon"),
			.init(name: "Div Block", elementType: .Basic, icon: "AddPanelDivIcon"),
			.init(name: "List", elementType: .Basic, icon: "AddPanelListIcon"),
			.init(name: "List Item", elementType: .Basic, icon: "AddPanelListItemIcon"),
			.init(name: "Link Block", elementType: .Basic, icon: "AddPanelLinkBlockIcon"),
			.init(name: "Button", elementType: .Basic, icon: "AddPanelButtonIcon"),
			.init(name: "Heading", elementType: .Typography, icon: "AddPanelHeadingIcon"),
			.init(name: "Paragraph", elementType: .Typography, icon: "AddPanelParagraphIcon"),
			.init(name: "Text Link", elementType: .Typography, icon: "AddPanelLinkIcon"),
			.init(name: "Text Block", elementType: .Typography, icon: "AddPanelTextIcon"),
			.init(name: "Block Quote", elementType: .Typography, icon: "AddPanelBlockquoteIcon"),
			.init(name: "Rich Text", elementType: .Typography, icon: "AddPanelRichtextIcon"),
			.init(name: "Collection List", elementType: .CMS),
			.init(name: "Image", elementType: .Media),
			.init(name: "Video", elementType: .Media),
			.init(name: "Youtube", elementType: .Media),
			.init(name: "Lottie", elementType: .Media),
			.init(name: "Spline Scene", elementType: .Media),
			.init(name: "Form Block", elementType: .Forms),
			.init(name: "Label", elementType: .Forms),
			.init(name: "Input", elementType: .Forms),
			.init(name: "File Upload", elementType: .Forms),
			.init(name: "Text Area", elementType: .Forms),
			.init(name: "Checkbox", elementType: .Forms),
			.init(name: "Radio Button", elementType: .Forms),
			.init(name: "Select", elementType: .Forms),
			.init(name: "reCAPTCHA", elementType: .Forms),
			.init(name: "Form Button", elementType: .Forms),
			.init(name: "Search", elementType: .Advanced),
			.init(name: "Background Video", elementType: .Advanced),
			.init(name: "Dropdown", elementType: .Advanced),
			.init(name: "Embed", elementType: .Advanced),
			.init(name: "Lightbox", elementType: .Advanced),
			.init(name: "Navbar", elementType: .Advanced),
			.init(name: "Slider", elementType: .Advanced),
			.init(name: "Map", elementType: .Advanced),
			.init(name: "Facebook", elementType: .Advanced),
			.init(name: "Twitter", elementType: .Advanced),
			.init(name: "Grid", elementType: .Other),
			.init(name: "Columns", elementType: .Other),
		]
	}
}

extension ElementModel {
	enum Category: String, CaseIterable, Codable {
		case Structure
		case Basic
		case Typography
		case CMS
		case Media
		case Forms
		case Advanced
		case Other
	}
}

extension ElementModel: Transferable {
	static var transferRepresentation: some TransferRepresentation {
		CodableRepresentation(contentType: .elementModel)
	}
}
extension UTType {
	static let elementModel = UTType(exportedAs: "com.nicholasblack.Webflow")
}
