//
//  PageListGroup.swift
//  Webflow
//
//  Created by Nick on 10/26/23.
//

import SwiftUI

struct GroupedList<T: RandomAccessCollection>: View where T.Element: Identifiable & Hashable {
	var title: String
	var data: T
	
    var body: some View {
		DisclosureGroup(title) {
			ForEach(data, id: \.self) { item in
				NavigationLink(value: item) {
//					Label(item, image: "PageDefaultIcon")
				}
			}
		}
    }
}

//#Preview {
//    GroupedList()
//}
