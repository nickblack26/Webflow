import SwiftUI

struct InspectorSizeSection: View {
	@Environment(\.modelContext) var modelContext
	@State private var ratio: ElementStyleModel.AspectRatio = .Auto
	@State private var overflow: ElementStyleModel.Overflow = ElementStyleModel.Overflow.Visible
	@State private var isExpanded: Bool = true
	@Bindable var element: ElementModel
	
	let formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.zeroSymbol = ""
		return formatter
	}()
	
	var body: some View {
		DisclosureGroup("Size", isExpanded: $isExpanded) {
			LazyVGrid(columns: [GridItem(), GridItem()]) {
				HStack {
					Button("Width") {
						
					}
					.buttonLabel()
					.frame(minWidth: 40, alignment: .leading)
					
					TextField(
						"Width",
						value:
							Binding<CGFloat>(
								get: {
									return element.style?.size?.width ?? 0
								},
								set: {
									if let style = element.style {
										@Bindable var style = style
										if let size = style.size {
											@Bindable var size = size
											size.width = $0
										} else {
											let size = SizeModel(width: $0)
											style.size = size
										}
									} else {
										let size = SizeModel(width: $0)
										let style = ElementStyleModel(size: size)
										element.style = style
									}
								}
							),
						formatter: formatter,
						prompt: Text("Auto")
					)
					.onSubmit {
						print(modelContext.hasChanges)
						try? modelContext.save()
						print(element.style?.size?.width)
					}
				}
				
				HStack {
					Button("Height") {
						
					}
					.buttonLabel()
					.frame(minWidth: 40, alignment: .leading)
					
					TextField(
						"Height",
						value:
							Binding(
								get: {
									return element.style?.size?.height ?? 0
								},
								set: {
									if $0 > 0 {
										if let style = element.style, let size = style.size {
											size.height = $0
										} else if let style = element.style {
											let size = SizeModel(height: $0)
											style.size = size
										} else {
											let size = SizeModel(height: $0)
											let style = ElementStyleModel(size: size)
											element.style = style
										}
									}
								}
							),
						formatter: formatter,
						prompt: Text("Auto")
					)
					.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Min W")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField(
						"Min W",
						value:
							Binding(
								get: {
									return element.style?.size?.minWidth ?? 0
								},
								set: {
									if $0 > 0 {
										if let style = element.style, let size = style.size {
											size.minWidth = $0
										} else if let style = element.style {
											let size = SizeModel(minWidth: $0)
											style.size = size
										} else {
											let size = SizeModel(minWidth: $0)
											let style = ElementStyleModel(size: size)
											element.style = style
										}
									}
								}
							),
						formatter: formatter,
						prompt: Text("0")
					)
					.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Min H")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField(
						"Min H",
						value:
							Binding(
								get: {
									return element.style?.size?.minHeight ?? 0
								},
								set: {
									if $0 > 0 {
										if let style = element.style, let size = style.size {
											size.minHeight = $0
										} else if let style = element.style {
											let size = SizeModel(minHeight: $0)
											style.size = size
										} else {
											let size = SizeModel(minHeight: $0)
											let style = ElementStyleModel(size: size)
											element.style = style
										}
									}
								}
							),
						formatter: formatter,
						prompt: Text("0")
					)
					.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Max W")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField(
						"Max W",
						value:
							Binding(
								get: {
									return element.style?.size?.maxWidth ?? 0
								},
								set: {
									if $0 > 0 {
										if let style = element.style, let size = style.size {
											size.maxWidth = $0
										} else if let style = element.style {
											let size = SizeModel(maxWidth: $0)
											style.size = size
										} else {
											let size = SizeModel(maxWidth: $0)
											let style = ElementStyleModel(size: size)
											element.style = style
										}
									}
								}
							),
						formatter: formatter,
						prompt: Text("None")
					)
					.textFieldStyle(.roundedBorder)
				}
				
				HStack {
					Text("Max H")
						.font(.caption)
						.foregroundStyle(.secondary)
						.frame(minWidth: 40, alignment: .leading)
					
					TextField(
						"Max H",
						value:
							Binding(
								get: {
									return element.style?.size?.maxHeight ?? 0
								},
								set: {
									if $0 > 0 {
										if let style = element.style, let size = style.size {
											size.maxHeight = $0
										} else if let style = element.style {
											let size = SizeModel(maxHeight: $0)
											style.size = size
										} else {
											let size = SizeModel(maxHeight: $0)
											let style = ElementStyleModel(size: size)
											element.style = style
										}
									}
								}
							),
						formatter: formatter,
						prompt: Text("None")
					)
					.textFieldStyle(.roundedBorder)
				}
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.textFieldStyle(.roundedBorder)
			.onAppear {
				print(element.style?.size?.width)
			}
			.listRowSeparator(.hidden)
						
			HStack {
				Text("Ratio")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(minWidth: 50, alignment: .leading)
				
				
				Picker(selection: $ratio) {
					ForEach(ElementStyleModel.AspectRatio.allCases, id: \.self) { ratio in
						Text(ratio.rawValue)
							.tag(ratio)
					}
				} label: {
					HStack {
						Text(ratio.rawValue)
						
						Spacer()
						
						Image("chevronDown")
					}
					.frame(maxWidth: .infinity, alignment: .leading)
				}
				.pickerStyle(.menu)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			HStack {
				Text("Overflow")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(minWidth: 50, alignment: .leading)
				
				
				Picker("Overflow", selection: $overflow) {
					ForEach(ElementStyleModel.Overflow.allCases, id: \.self) { overflow in
						if(overflow.icon.isEmpty) {
							Text("Auto")
								.tag(overflow)
						} else {
							Image(overflow.icon)
								.tag(overflow)
						}
					}
				}
				.pickerStyle(.segmented)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			
			HStack {
				Text("Fit")
					.font(.caption)
					.foregroundStyle(.secondary)
					.frame(minWidth: 50, alignment: .leading)
				
				Picker("Fit", selection: $overflow) {
					ForEach(ElementStyleModel.Fit.allCases, id: \.self) { overflow in
						Text(overflow.rawValue)
							.tag(overflow)
					}
				}
				.pickerStyle(.menu)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}

#Preview {
	InspectorSizeSection(element: .init(name: "Body"))
		.modelContainer(for: SizeModel.self, inMemory: true)
}
