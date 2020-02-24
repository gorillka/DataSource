//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

public enum Table {}

open class TableViewDataSource<Item, Cell: Identifiable>:
	DataSource<Item, Cell, UITableView>, UITableViewDataSource {
	public func numberOfSections(in tableView: UITableView) -> Int { abstractMethod() }
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { abstractMethod() }
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		abstractMethod()
	}

	public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		abstractMethod()
	}

	public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		abstractMethod()
	}
}
