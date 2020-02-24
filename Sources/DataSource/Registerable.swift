//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

public protocol Registrable: AnyObject {
	func register<Cell>(_ cellClass: Cell.Type) where Cell: Identifiable
}

extension Registrable {
	@usableFromInline
	internal func nib(for cellClass: Identifiable.Type) -> UINib? {
		guard let path = Bundle.main.path(forResource: cellClass.identifier, ofType: "nib") else { return nil }
		guard FileManager.default.fileExists(atPath: path) else { return nil }

		return UINib(nibName: cellClass.identifier, bundle: .main)
	}
}

// MARK: - UITableView

extension UITableView: Registrable {
	@inline(__always)
	@inlinable
	public func register<Cell>(_ cellClass: Cell.Type) where Cell: Identifiable {
		if let nib = nib(for: cellClass) {
			register(nib, forCellReuseIdentifier: cellClass.identifier)
		} else {
			register(cellClass.self, forCellReuseIdentifier: cellClass.identifier)
		}
	}

	@usableFromInline
	internal func registerHeaderFooter(_ headerFooterClass: Identifiable.Type) {
		register(headerFooterClass, forHeaderFooterViewReuseIdentifier: headerFooterClass.identifier)
	}

	@inline(__always)
	@inlinable
	public func registerHeader(_ headerClass: Identifiable.Type) {
		registerHeaderFooter(headerClass)
	}

	@inline(__always)
	@inlinable
	public func registerFooter(_ footerClass: Identifiable.Type) {
		registerHeaderFooter(footerClass)
	}
}

// MARK: - UICollectionView

extension UICollectionView: Registrable {
	@inline(__always)
	@inlinable
	public func register<Cell>(_ cellClass: Cell.Type) where Cell: Identifiable {
		if let nib = nib(for: cellClass) {
			register(nib, forCellWithReuseIdentifier: cellClass.identifier)
		} else {
			register(cellClass, forCellWithReuseIdentifier: cellClass.identifier)
		}
	}

	@usableFromInline
	internal func registerSupplementaryView(_ viewClass: Identifiable.Type, for kind: SupplementaryViewKind) {
		if let nib = nib(for: viewClass) {
			register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: viewClass.identifier)
		} else {
			register(viewClass, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: viewClass.identifier)
		}
	}

	@inline(__always)
	@inlinable
	public func registerHeader(_ headerClass: Identifiable.Type) {
		registerSupplementaryView(headerClass, for: .header)
	}

	@inline(__always)
	@inlinable
	public func registerFooter(_ footerClass: Identifiable.Type) {
		registerSupplementaryView(footerClass, for: .footer)
	}
}
