//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import CoreData

public protocol SectionInfo: NSFetchedResultsSectionInfo {
    associatedtype Item

    var name: String { get }
    var items: [Item] { get }
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

    @inline(__always)
    @inlinable
    internal init(_ sectionInfo: NSFetchedResultsSectionInfo) {
        self.name = sectionInfo.name
        self.items = sectionInfo.objects?.compactMap { $0 as? Item } ?? []
    }

    @inline(__always)
    @inlinable
    public var indexTitle: String? { nil }

    @inline(__always)
    @inlinable
    public var objects: [Any]? { items }

    @inline(__always)
    @inlinable
    public var numberOfObjects: Int { items.count }
}

extension SectionInfo {
    @inline(__always)
    @inlinable
    public var numberOfItems: Int { items.count }
}

extension Section: Equatable {
    public static func == (lhs: Section<Item>, rhs: Section<Item>) -> Bool {
        lhs.name == rhs.name
    }
}
