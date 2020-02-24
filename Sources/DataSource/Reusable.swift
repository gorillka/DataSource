//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

public protocol Reusable: AnyObject {
	func dequeueReusableCell<Cell>(for indexPath: IndexPath) -> Cell where Cell: Identifiable
}

// MARK: - UITableView

extension UITableView: Reusable {
	@inline(__always)
	@inlinable
	public func dequeueReusableCell<Cell>(for indexPath: IndexPath) -> Cell where Cell: Identifiable {
		guard let cell = dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
			fatalError("\(Cell.self) should conform to \(UITableViewCell.self).")
		}

		return cell
	}

	@usableFromInline
	internal func dequeueReusableHeaderFooterView<View>() -> View where View: Identifiable {
		guard let view = dequeueReusableHeaderFooterView(withIdentifier: View.identifier) as? View else {
			fatalError("\(View.self) should conform to \(UITableViewHeaderFooterView.self).")
		}

		return view
	}

	@inline(__always)
	@inlinable
	public func dequeueReusableHeaderView<Header>() -> Header where Header: Identifiable {
		dequeueReusableHeaderFooterView()
	}

	@inline(__always)
	@inlinable
	public func dequeueReusableFooterView<Footer>() -> Footer where Footer: Identifiable {
		dequeueReusableHeaderFooterView()
	}
}

// MARK: - UICollectionView

extension UICollectionView: Reusable {
	@inline(__always)
	@inlinable
	public func dequeueReusableCell<Cell>(for indexPath: IndexPath) -> Cell where Cell: Identifiable {
		guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
			fatalError("\(Cell.self) should conform to \(UICollectionViewCell.self).")
		}

		return cell
	}

	@usableFromInline
	internal func dequeueReusableSupplementaryView<View>(for kind: SupplementaryViewKind,
	                                                     at indexPath: IndexPath) -> View where View: Identifiable {
		guard let view = dequeueReusableSupplementaryView(ofKind: kind.rawValue,
		                                                  withReuseIdentifier: View.identifier,
		                                                  for: indexPath) as? View else {
			fatalError("\(View.self) should conform to \(UICollectionReusableView.self).")
		}

		return view
	}

	@inline(__always)
	@inlinable
	public func dequeueReusableHeaderView<Header>(for indexPath: IndexPath) -> Header where Header: Identifiable {
		dequeueReusableSupplementaryView(for: .header, at: indexPath)
	}

	@inline(__always)
	@inlinable
	public func dequeueReusableFooterView<Header>(for indexPath: IndexPath) -> Header where Header: Identifiable {
		dequeueReusableSupplementaryView(for: .footer, at: indexPath)
	}
}
