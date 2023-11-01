import Foundation

protocol Searchable {
	var id: UUID { get }
	var name: String { get }
}

func dataSearch<T: Searchable>(searchText: String, data: [T]) -> [T] {
	if(searchText.isEmpty) {
		return data
	} else {
		return data.filter { $0.name.contains(searchText) }
	}
}
