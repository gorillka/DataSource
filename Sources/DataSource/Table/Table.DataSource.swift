//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

extension Table {
    open class DataSource<SectionType: SectionInfo, CellType: Identifiable>:
        GeneralDataSource<SectionType, CellType, UITableView>, UITableViewDataSource
        where CellType: UITableViewCell {
        @inline(__always)
        @inlinable
        open func numberOfSections(in tableView: UITableView) -> Int { numberOfSections() }

        @inline(__always)
        @inlinable
        open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            numberOfItemsInSection(section)
        }

        @inline(__always)
        @inlinable
        open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            configure(
                tableView.dequeueReusableCell(for: indexPath),
                item(at: indexPath),
                indexPath,
                tableView
            )
        }
    }
}
