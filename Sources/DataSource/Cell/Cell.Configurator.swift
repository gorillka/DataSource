//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import Foundation

extension Cell {
	open class Configurator<Item, Cell: Identifiable, ReusableType: Reusable>: Configurable {
		public final var configurator: (Cell, Item, IndexPath, ReusableType) -> Cell

		@inline(__always)
		@inlinable
		public init(_ configure: @escaping (Cell, Item, IndexPath, ReusableType) -> Cell) {
			self.configurator = configure
		}
	}
}
