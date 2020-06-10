//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import CoreData
import Foundation

public typealias TransactionBatch = [Transaction]

public enum Transaction {
    case item(Item)
    case section(Section)
}

extension Transaction {
    public struct Item {
        public let changeType: NSFetchedResultsChangeType

        public let indexPath: IndexPath?
        public let newIndexPath: IndexPath?

        @usableFromInline
        internal init(_ changeType: NSFetchedResultsChangeType, indexPath: IndexPath?, newIndexPath: IndexPath?) {
            self.changeType = changeType
            self.indexPath = indexPath
            self.newIndexPath = newIndexPath
        }
    }
}

extension Transaction {
    public struct Section {
        public let changeType: NSFetchedResultsChangeType
        public let sectionIndex: Int

        @usableFromInline
        internal init(changeType: NSFetchedResultsChangeType, sectionIndex: Int) {
            self.changeType = changeType
            self.sectionIndex = sectionIndex
        }
    }
}
