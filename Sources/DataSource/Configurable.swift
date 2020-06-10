//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import Foundation

public protocol Configurable {
    associatedtype Item
    associatedtype CellType: Identifiable
    associatedtype ViewType

    var configurator: (CellType, Item, IndexPath, ViewType) -> CellType { get }
}

extension Configurable {
    @inline(__always)
    @inlinable
    internal func configure(_ cell: CellType, _ item: Item, _ index: IndexPath, _ view: ViewType) -> CellType {
        configurator(cell, item, index, view)
    }
}
