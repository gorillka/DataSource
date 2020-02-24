//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

extension Table {
	open class DataSource<Item, View: Identifiable, SectionType: SectionInfo>: TableViewDataSource<Item, View>, Sectionable
		where Item == SectionType.Item,
		View: UITableViewCell {
		public typealias Cell = View

		public var sections: [SectionType] {
			get { _sections.compactMap { $0.box as? AnySectionBox }.map { $0.base } }
			set { _sections = newValue.map(AnySection.init) }
		}

		@usableFromInline
		internal var _sections: [AnySection<SectionType.Item>]

		@inline(__always)
		@inlinable
		public init<C: Configurable>(sections: [SectionType], configurator: C)
			where Item == C.Item,
			Cell == C.Cell,
			UITableView == C.ReusableType {
			self._sections = sections.map(AnySection.init)

			super.init(configurator)
		}

		@inline(__always)
		@inlinable
		public func numberOfSections() -> Int { sections.count }

		@inline(__always)
		@inlinable
		public func numberOfItemsInSection(_ section: Int) -> Int { sections[section].numberOfItems }

		@inline(__always)
		@inlinable
		public func item(at indexPath: IndexPath) -> SectionType.Item { sections.item(at: indexPath) }

		@inline(__always)
		@inlinable
		public final override func numberOfSections(in tableView: UITableView) -> Int {
			numberOfSections()
		}

		@inline(__always)
		@inlinable
		public final override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			numberOfItemsInSection(section)
		}

		@inline(__always)
		@inlinable
		public final override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			let item = self.item(at: indexPath)

			return configurator.configure(tableView.dequeueReusableCell(for: indexPath), item, indexPath, tableView)
		}
	}
}
