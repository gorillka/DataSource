//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

public protocol Identifiable: AnyObject {
	static var identifier: String { get }
}

extension Identifiable {
	@inline(__always)
	@inlinable
	public static var identifier: String { String(describing: Self.self) }
}
