//
//  SearchableProtocol.swift
//  Webflow
//
//  Created by Nick on 10/31/23.
//

import Foundation

protocol Searchable {
	var id: UUID { get }
	var name: String { get }
}
