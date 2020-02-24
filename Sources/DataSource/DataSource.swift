//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

public protocol DataSourceable: AnyObject {
	associatedtype Item

	func numberOfSections() -> Int
	func numberOfItemsInSection(_ section: Int) -> Int
	func item(at indexPath: IndexPath) -> Item
}

open class DataSource<Item, Cell: Identifiable, ReusableType: Reusable>: NSObject {
	@usableFromInline
	internal let configurator: AnyConfigurator<Item, Cell, ReusableType>

	@usableFromInline
	internal init<C: Configurable>(_ configurator: C) where Item == C.Item, Cell == C.Cell, ReusableType == C.ReusableType {
		self.configurator = AnyConfigurator(configurator)

		super.init()
	}
}
