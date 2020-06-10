//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import CoreData
import UIKit

extension Table {
    open class FetchedDataSource<EntityType: NSManagedObject, CellType: Identifiable>:
        DataSource<Section<EntityType>, CellType>, NSFetchedResultsControllerDelegate, Fetchable
        where CellType: UITableViewCell {
        @inline(__always)
        @inlinable
        override public final var sections: [Section<EntityType>] {
            get { frc.sections?.map(Section.init) ?? [] }
            set { abstractMethod() }
        }

        @usableFromInline
        internal let frc: FetchedResultsController<SectionType.Item>

        @usableFromInline
        internal var transactionBatchHandler: (TransactionBatch) -> Void = { _ in }

        @usableFromInline
        internal var transactionBatch: TransactionBatch = []

        @inline(__always)
        @inlinable
        @available(*, unavailable)
        override public init(
            sections: [SectionType],
            _ cellConfigure: @escaping (CellType, SectionType.Item, IndexPath, UITableView) -> CellType
        ) {
            abstractMethod()
        }

        @inline(__always)
        @inlinable
        public init<Request: FetchRequestable>(
            request: Request,
            _ cellConfigure: @escaping (CellType, SectionType.Item, IndexPath, UITableView) -> CellType
        ) where Request.EntityType == SectionType.Item {
            self.frc = FetchedResultsController(request: request)

            super.init(sections: [], cellConfigure)

            frc.delegate = self
        }

        @inline(__always)
        @inlinable
        public final func perform(_ configure: ((NSFetchRequest<EntityType>) -> Void)? = nil) throws {
            configure?(frc.request)

            try frc.performFetch()
        }

        @inline(__always)
        @inlinable
        public final func processTransactionBatch(_ transactionBatch: @escaping (TransactionBatch) -> Void) {
            transactionBatchHandler = transactionBatch
        }

        @inline(__always)
        @inlinable
        public final func controllerWillChangeContent(
            _ controller: NSFetchedResultsController<NSFetchRequestResult>
        ) {
            transactionBatch = []
        }

        @inline(__always)
        @inlinable
        public final func controllerDidChangeContent(
            _ controller: NSFetchedResultsController<NSFetchRequestResult>
        ) {
            transactionBatchHandler(transactionBatch)
        }

        @inline(__always)
        @inlinable
        public final func controller(
            _ controller: NSFetchedResultsController<NSFetchRequestResult>,
            didChange sectionInfo: NSFetchedResultsSectionInfo,
            atSectionIndex sectionIndex: Int,
            for type: NSFetchedResultsChangeType
        ) {
            let section = Transaction.Section(changeType: type, sectionIndex: sectionIndex)

            transactionBatch.append(.section(section))
        }

        @inline(__always)
        @inlinable
        public final func controller(
            _ controller: NSFetchedResultsController<NSFetchRequestResult>,
            didChange anObject: Any,
            at indexPath: IndexPath?,
            for type: NSFetchedResultsChangeType,
            newIndexPath: IndexPath?
        ) {
            let item = Transaction.Item(type, indexPath: indexPath, newIndexPath: newIndexPath)

            transactionBatch.append(.item(item))
        }
    }
}
