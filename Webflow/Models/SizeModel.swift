//
//  SizeModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class SizeModel {
	@Attribute(.unique) var id: UUID
	var element: ElementStyleModel?
	var width: CGFloat?
	var height: CGFloat?
	var minWidth: CGFloat?
	var minHeight: CGFloat?
	var maxWidth: CGFloat?
	var maxHeight: CGFloat?
	
	init(id: UUID = UUID(), element: ElementStyleModel? = nil, width: CGFloat? = nil, height: CGFloat? = nil, minWidth: CGFloat? = nil, minHeight: CGFloat? = nil, maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) {
		self.id = id
		self.element = element
		self.width = width
		self.height = height
		self.minWidth = minWidth
		self.minHeight = minHeight
		self.maxWidth = maxWidth
		self.maxHeight = maxHeight
	}
}
