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
final class ElementModel: Codable {
	var name: String
	var category: Category
	var parent: ElementModel?
	var icon: String?
	var tag: Tag?
	
	@Relationship(deleteRule: .cascade, inverse: \ClassModel.element)
	var classes: [ClassModel]
	
	@Relationship(deleteRule: .cascade, inverse: \ElementStyleModel.element)
	var style: ElementStyleModel?
	
	@Relationship(deleteRule: .cascade, inverse: \ElementSettingsModel.element)
	var settings: ElementSettingsModel?
	
	@Relationship(deleteRule: .cascade, inverse: \ElementModel.parent)
	var children: [ElementModel]?
	
	init(name: String, elementType: Category = .Structure, icon: String? = nil, tag: Tag = .Div, classes: [ClassModel]  = [], style: ElementStyleModel? = nil, settings: ElementSettingsModel? = nil, children: [ElementModel]? = []) {
		self.name = name
		self.category = elementType
		self.icon = icon
		self.classes = classes
		self.style = style
		self.settings = settings
		self.children = children
	}
	
	enum CodingKeys: CodingKey {
		case name
		case elementType
		case classes
		case children
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		category = try container.decode(Category.self, forKey: .elementType)
		classes = try container.decode([ClassModel].self, forKey: .classes)
		children = try container.decode([ElementModel].self, forKey: .children)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(category, forKey: .elementType)
		try container.encode(classes, forKey: .classes)
		try container.encode(children, forKey: .children)
	}
	
	static func defaultElements() -> [ElementModel] {
		[
			.init(name: "Section", icon: "AddPanelSectionIcon", tag: .Section),
			.init(name: "Container", icon: "AddPanelContainerIcon", style: .init(display: .Block, spacing: .init(paddingHorizontal: 0), size: .init(maxWidth: 940))),
			.init(name: "Quick Stack", icon: "AddPanelQuickStackIcon", style: .init(display: .Grid, spacing: .init(padding: 20))),
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
	
	enum Tag: String, CaseIterable, Codable {
		case A
		case Abbr
		case Acronym
		case Address
		case Applet
		case Area
		case Article
		case Aside
		case Audio
		case B
		case Base
		case Basefont
		case Bdi
		case Bdo
		case Big
		case Blockquote
		case Body
		case Br
		case Button
		case Canvas
		case Caption
		case Center
		case Cite
		case Code
		case Col
		case Colgroup
		case Data
		case Datalist
		case Dd
		case Del
		case Details
		case Dfn
		case Dialog
		case Dir
		case Div
		case Dl
		case Dt
		case Em
		case Embed
		case Fieldset
		case Figcaption
		case Figure
		case Font
		case Footer
		case Form
		case Frame
		case Frameset
		case H1
		case H2
		case H3
		case H4
		case H5
		case H6
		case Head
		case Header
		case Hgroup
		case Hr
		case Html
		case I
		case Iframe
		case Img
		case Input
		case Ins
		case Kbd
		case Label
		case Legend
		case Li
		case Link
		case Main
		case Map
		case Mark
		case Menu
		case Meta
		case Meter
		case Nav
		case Noframes
		case Noscript
		case Object
		case Ol
		case Optgroup
		case Option
		case Output
		case P
		case Param
		case Picture
		case Pre
		case Progress
		case Q
		case Rp
		case Rt
		case Ruby
		case S
		case Samp
		case Script
		case Search
		case Section
		case Select
		case Small
		case Source
		case Span
		case Strike
		case Strong
		case Style
		case Sub
		case Summary
		case Sup
		case Svg
		case Table
		case Tbody
		case Td
		case Template
		case Textarea
		case Tfoot
		case Th
		case Thead
		case Time
		case Title
		case Tr
		case Track
		case Tt
		case U
		case Ul
		case Var
		case Video
		case Wbr
		
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
				default:
					"ElementDivIcon"
			}
		}
		
		var styleDefault: ElementStyleModel {
			switch self {
				case .Div: .init(display: .Block)
				case .Header: .init(display: .Block)
				case .Footer: .init(display: .Block)
				case .Nav: .init(display: .Block)
				case .Main: .init()
				case .Section: .init(display: .Block)
				case .Article: .init(display: .Block)
				case .Aside: .init(display: .Block)
				case .Address: .init()
				case .Figure: .init(display: .Block, spacing: SpacingModel(paddingTop: 16, paddingHorizontal: 40, paddingBottom: 16))
				default: .init()
			}
		}
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
