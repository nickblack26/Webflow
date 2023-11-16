//
//  PageModel+Extension.swift
//  Webflow
//
//  Created by Nick Black on 11/9/23.
//

import Foundation

extension [PageModel] {
	func updateIndices() {
		for (index, item) in enumerated() {
			item.index = index
		}
	}
}
