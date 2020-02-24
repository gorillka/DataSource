//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import Foundation

public protocol Configurable {
	associatedtype Item
	associatedtype Cell: Identifiable
	associatedtype ReusableType: Reusable

	var configurator: (Cell, Item, IndexPath, ReusableType) -> Cell { get }
}

extension Configurable {
	@inline(__always)
	@inlinable
	internal func configure(_ view: Cell, _ item: Item, _ index: IndexPath, _ reusable: ReusableType) -> Cell {
		configurator(view, item, index, reusable)
	}
}

public struct AnyConfigurator<Item, Cell: Identifiable, ReusableType: Reusable>: Configurable {
	@inline(__always)
	@inlinable
	public var configurator: (Cell, Item, IndexPath, ReusableType) -> Cell { box.configurator }

	@usableFromInline
	internal let box: AnyConfiguratorBase<Item, Cell, ReusableType>

	@inline(__always)
	@inlinable
	internal init<C: Configurable>(_ configurator: C) where Item == C.Item, Cell == C.Cell, ReusableType == C.ReusableType {
		self.box = AnyConfiguratorBox(configurator)
	}
}

@usableFromInline
internal class AnyConfiguratorBase<Item, Cell: Identifiable, ReusableType: Reusable>: Configurable {
	@inline(__always)
	@inlinable
	internal var configurator: (Cell, Item, IndexPath, ReusableType) -> Cell { abstractMethod() }

	@inline(__always)
	@inlinable
	internal init() {}
}

@usableFromInline
internal final class AnyConfiguratorBox<Base: Configurable>: AnyConfiguratorBase<Base.Item, Base.Cell, Base.ReusableType> {
	@inline(__always)
	@inlinable
	internal override var configurator: (Base.Cell, Base.Item, IndexPath, Base.ReusableType) -> Base.Cell {
		base.configurator
	}

	@usableFromInline
	internal let base: Base

	@inline(__always)
	@inlinable
	internal init(_ base: Base) {
		self.base = base

		super.init()
	}
}
