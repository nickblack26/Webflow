//
//  ModelDefaults.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import Foundation

enum DefaultStructureElement: String, CaseIterable  {
	case Section
	case Container
	case QuickStack = "Quick Stack"
	case VFlex = "V Flex"
	case HFlex = "H Flex"
	
	var icon: String {
		switch self {
			case .Section: "AddPanelSectionIcon"
			case .Container: "AddPanelContainerIcon"
			case .QuickStack: "AddPanelQuickStackIcon"
			case .VFlex: "AddPanelVFlexIcon"
			case .HFlex: "AddPanelHFlexIcon"
		}
	}
	
	var element: ElementModel {
		switch self {
			case .Section: .init(name: "Section")
			case .Container:.init(name: "Section")
			case .QuickStack: .init(name: "Section")
			case .VFlex: .init(name: "Section")
			case .HFlex: .init(name: "Section")
		}
	}
}

enum DefaultBasicElement: String, CaseIterable  {
	case DivBlock = "Div Block"
	case List = "List"
	case ListItem = "List Item"
	case LinkBlock = "Link Block"
	case Button = "Button"
	
	var icon: String {
		switch self {
			case .DivBlock: "AddPanelDivIcon"
			case .List: "AddPanelListIcon"
			case .ListItem: "AddPanelListItemIcon"
			case .LinkBlock: "AddPanelLinkBlockIcon"
			case .Button: "AddPanelButtonIcon"
		}
	}
	
	var element: ElementModel {
		switch self {
			case .DivBlock: .init(name: "Section")
			case .List: .init(name: "Section")
			case .ListItem: .init(name: "Section")
			case .LinkBlock: .init(name: "Section")
			case .Button: .init(name: "Section")
		}
	}
}

enum DefaultTypographyElement: String, CaseIterable  {
	case Heading = "Heading"
	case Paragraph = "Paragraph"
	case TextLink = "Text Link"
	case TextBlock = "Text Block"
	case BlockQuote = "Block Quote"
	case RichText = "Rich Text"
	
	var icon: String {
		switch self {
			case .Heading: "AddPanelHeadingIcon"
			case .Paragraph: "AddPanelParagraphIcon"
			case .TextLink: "AddPanelLinkIcon"
			case .TextBlock: "AddPanelTextIcon"
			case .BlockQuote: "AddPanelBlockquoteIcon"
			case .RichText: "AddPanelRichtextIcon"
		}
	}
	
	var element: ElementModel {
		switch self {
			case .Heading: .init(name: "Section")
			case .Paragraph: .init(name: "Section")
			case .TextLink: .init(name: "Section")
			case .TextBlock: .init(name: "Section")
			case .BlockQuote: .init(name: "Section")
			case .RichText: .init(name: "Section")
		}
	}
}
