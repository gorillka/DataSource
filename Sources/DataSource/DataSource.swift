//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

public typealias GeneralDataSource = DataSource

public protocol DataSourceable: AnyObject {
    associatedtype SectionType: SectionInfo

    var sections: [SectionType] { get set }

    func numberOfSections() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func section(at index: Int) -> SectionType
    func item(at indexPath: IndexPath) -> SectionType.Item
}

open class DataSource<SectionType: SectionInfo, CellType: Identifiable, ViewType>:
    NSObject, DataSourceable, Configurable {
    public var sections: [SectionType]

    public final let configurator: (CellType, SectionType.Item, IndexPath, ViewType) -> CellType

    @inline(__always)
    @inlinable
    public init(
        sections: [SectionType] = [],
        _ cellConfigure: @escaping (CellType, SectionType.Item, IndexPath, ViewType) -> CellType
    ) {
        self.sections = sections
        self.configurator = cellConfigure
    }

    @inline(__always)
    @inlinable
    open func numberOfSections() -> Int { sections.count }

    @inline(__always)
    @inlinable
    open func numberOfItemsInSection(_ section: Int) -> Int { sections[section].numberOfItems }

    @inline(__always)
    @inlinable
    open func section(at index: Int) -> SectionType { sections[index] }

    @inline(__always)
    @inlinable
    open func item(at indexPath: IndexPath) -> SectionType.Item { sections.item(at: indexPath) }
}

extension Array where Element: SectionInfo {
    @usableFromInline
    internal func item(at indexPath: IndexPath) -> Element.Item {
        self[indexPath.section].items[indexPath.row]
    }
}
