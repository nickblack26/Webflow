//
//  EditorTab.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import Foundation
import SwiftUI

enum SidebarTab: String, CaseIterable {
	case add = "Add Elements (A)"
	case pages = "Pages (P)"
	case navigator = "Navigator (Z)"
	case components = "Components (A)"
	case variables = "Varibles (V)"
	case styleSelectors = "Style Selectors (S)"
	case assets = "Assets (J)"
	case cms = "CMS"
	case logic = "Logic (L)"
	case users = "Users"
	case ecommerce = "Ecommerce"
	case apps = "Apps"
	
	var symbol: String {
		switch self {
			case .add: return "addPanelIcon"
			case .pages: return "pagePanelIcon"
			case .navigator: return "navigatorPanelIcon"
			case .components: return "componentsPanelIcon"
			case .variables: return "capabilityVariablePanelIcon"
			case .styleSelectors: return "variablesPanelIcon"
			case .assets: return "assetManagerPanelIcon"
			case .cms: return "capabilityCMSPanelIcon"
			case .logic: return "logicPanelIcon"
			case .users: return "capabilityUserPanelIcon"
			case .ecommerce: return "ecommercePanelIcon"
			case .apps: return "assetManagerPanelIcon"
		}
	}
	
	var keyBoardShortcut: (KeyEquivalent?, EventModifiers?) {
		switch self {
			case .add: return ("a", nil)
			case .pages: return ("p", nil)
			case .navigator: return ("z", nil)
			default: return (nil, nil)
		}
	}
}
