//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

@usableFromInline
internal func abstractMethod(file: StaticString = #file, line: UInt = #line) -> Never {
	fatalError("Abstract method call", file: file, line: line)
}
