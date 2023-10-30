//
//  ModelDefaults.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import Foundation

enum DefaultStructureElement: String, CaseIterable  {
	case section = "Section"
	case container = "Container"
	case quickStack = "Quick Stack"
	case vFlex = "V Flex"
	case hFlex = "H Flex"
	
	var icon: String {
		switch self {
			case .section: "AddPanelSectionIcon"
			case .container: "AddPanelContainerIcon"
			case .quickStack: "AddPanelQuickStackIcon"
			case .vFlex: "AddPanelVFlexIcon"
			case .hFlex: "AddPanelHFlexIcon"
		}
	}
	
	var element: ElementModel {
		switch self {
			case .section: .init(name: "Section")
			case .container:.init(name: "Section")
			case .quickStack: .init(name: "Section")
			case .vFlex: .init(name: "Section")
			case .hFlex: .init(name: "Section")
		}
	}
}

enum DefaultBasicElement: String, CaseIterable  {
	case divBlock = "Div Block"
	case list = "List"
	case listItem = "List Item"
	case linkBlock = "Link Block"
	case button = "Button"
	
	var icon: String {
		switch self {
			case .divBlock: "AddPanelDivIcon"
			case .list: "AddPanelListIcon"
			case .listItem: "AddPanelListItemIcon"
			case .linkBlock: "AddPanelLinkBlockIcon"
			case .button: "AddPanelButtonIcon"
		}
	}
	
	var element: ElementModel {
		switch self {
			case .divBlock: .init(name: "Section")
			case .list: .init(name: "Section")
			case .listItem: .init(name: "Section")
			case .linkBlock: .init(name: "Section")
			case .button: .init(name: "Section")
		}
	}
}

enum DefaultTypographyElement: String, CaseIterable  {
	case heading = "Heading"
	case paragraph = "Paragraph"
	case textLink = "Text Link"
	case textBlock = "Text Block"
	case blockQuote = "Block Quote"
	case richText = "Rich Text"
	
	var icon: String {
		switch self {
			case .heading: "AddPanelHeadingIcon"
			case .paragraph: "AddPanelParagraphIcon"
			case .textLink: "AddPanelLinkIcon"
			case .textBlock: "AddPanelTextIcon"
			case .blockQuote: "AddPanelBlockquoteIcon"
			case .richText: "AddPanelRichtextIcon"
		}
	}
	
	var element: ElementModel {
		switch self {
			case .heading: .init(name: "Section")
			case .paragraph: .init(name: "Section")
			case .textLink: .init(name: "Section")
			case .textBlock: .init(name: "Section")
			case .blockQuote: .init(name: "Section")
			case .richText: .init(name: "Section")
		}
	}
}
