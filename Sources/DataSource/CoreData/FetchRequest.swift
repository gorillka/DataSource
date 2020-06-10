//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import CoreData

public protocol FetchRequestable: NSFetchRequest<NSFetchRequestResult> {
    associatedtype EntityType: NSManagedObject

    var context: NSManagedObjectContext { get }

    var sectionKeyPath: String? { get }
    var cacheName: String? { get }
}

public protocol Fetchable {
    associatedtype EntityType: NSManagedObject

    func perform(_ configure: ((NSFetchRequest<EntityType>) -> Void)?) throws
    func processTransactionBatch(_ transactionBatch: @escaping (TransactionBatch) -> Void)
}

open class FetchRequest<EntityType: NSManagedObject>: NSFetchRequest<NSFetchRequestResult>, FetchRequestable {
    public var sectionKeyPath: String?
    public var cacheName: String?

    public let context: NSManagedObjectContext

    @inline(__always)
    @inlinable
    public init(context: NSManagedObjectContext) {
        self.context = context

        super.init()

        self.entity = EntityType.entity()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FetchRequestable {
    @inline(__always)
    @inlinable
    public var predicate: NSPredicate? { NSPredicate(value: true) }

    @inline(__always)
    @inlinable
    public var sectionKeyPath: String? { nil }

    @inline(__always)
    @inlinable
    public var cacheName: String? { nil }
}
