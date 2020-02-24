//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import Foundation

public protocol SectionInfo {
	associatedtype Item

	var name: String { get }
	var items: [Item] { get }
}

public protocol Sectionable: DataSourceable {
	associatedtype SectionType: SectionInfo

	var sections: [SectionType] { get set }
}

public final class Section<Item>: SectionInfo {
	public let name: String
	public let items: [Item]

	@inline(__always)
	@inlinable
	public init(name: String, items: [Item] = []) {
		self.name = name
		self.items = items
	}
}

extension SectionInfo {
	@inline(__always)
	@inlinable
	public var numberOfItems: Int { items.count }
}

public struct AnySection<Item>: SectionInfo {
	public var name: String { box.name }
	public var items: [Item] { box.items }

	@usableFromInline
	internal let box: AnySectionBase<Item>

	@inline(__always)
	@inlinable
	internal init<Section: SectionInfo>(_ section: Section) where Item == Section.Item {
		self.box = AnySectionBox(section)
	}
}

@usableFromInline
internal class AnySectionBase<Item>: SectionInfo {
	@inline(__always)
	@inlinable
	internal var name: String { abstractMethod() }

	@inline(__always)
	@inlinable
	internal var items: [Item] { abstractMethod() }

	@inline(__always)
	@inlinable
	internal init() {}
}

@usableFromInline
internal final class AnySectionBox<Base: SectionInfo>: AnySectionBase<Base.Item> {
	@inline(__always)
	@inlinable
	internal override var name: String { base.name }

	@inline(__always)
	@inlinable
	internal override var items: [Base.Item] { base.items }

	@usableFromInline
	internal let base: Base

	@inline(__always)
	@inlinable
	internal init(_ base: Base) {
		self.base = base
	}
}

extension Array where Element: SectionInfo {
	@usableFromInline
	internal func item(at indexPath: IndexPath) -> Element.Item {
		self[indexPath.section].items[indexPath.row]
	}
}
