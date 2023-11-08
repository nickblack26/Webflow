//
//  NavigationManager.swift
//  Webflow
//
//  Created by Nick on 11/6/23.
//

import Foundation
import Observation

@Observable
class NavigationManager {
	var selectedWebsite: UUID?
	var selectedPage: UUID?
}
