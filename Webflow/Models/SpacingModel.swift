//
//  SpacingModel.swift
//  Webflow
//
//  Created by Nick on 10/6/23.
//

import Foundation
import SwiftData

@Model
class SpacingModel {
	@Attribute(.unique) var id: UUID
	var element: ElementStyleModel?
	var marginLeft: CGFloat?
	var marginCenter: CGFloat?
	var marginRight: CGFloat?
	var marginBottom: CGFloat?
	var paddingLeft: CGFloat?
	var paddingCenter: CGFloat?
	var paddingRight: CGFloat?
	var paddingBottom: CGFloat?
	
	init(id: UUID = UUID(), element: ElementStyleModel? = nil, marginLeft: CGFloat? = nil, marginCenter: CGFloat? = nil, marginRight: CGFloat? = nil, marginBottom: CGFloat? = nil, paddingLeft: CGFloat? = nil, paddingCenter: CGFloat? = nil, paddingRight: CGFloat? = nil, paddingBottom: CGFloat? = nil) {
		self.id = id
		self.element = element
		self.marginLeft = marginLeft
		self.marginCenter = marginCenter
		self.marginRight = marginRight
		self.marginBottom = marginBottom
		self.paddingLeft = paddingLeft
		self.paddingCenter = paddingCenter
		self.paddingRight = paddingRight
		self.paddingBottom = paddingBottom
	}
}
