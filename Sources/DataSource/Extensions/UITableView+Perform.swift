//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

extension UITableView {
    @inline(__always)
    @inlinable
    public func performBatchUpdate(
        _ batch: TransactionBatch,
        animation: RowAnimation = .automatic,
        completion: @escaping (Bool) -> Void = { _ in }
    ) {
        if batch.isEmpty { return completion(true) }

        let sections = batch.filter {
            if case .section = $0 {
                return true
            } else {
                return false
            }
        }
        let items = batch.filter {
            if case .item = $0 {
                return true
            } else {
                return false
            }
        }
        if #available(iOS 11, *) {
            performBatchUpdates({
                updateSections(sections, animation: animation)
                updateItems(items, animation: animation)
            }, completion: completion)
        } else {
            beginUpdates()
            updateSections(sections, animation: animation)
            updateItems(items, animation: animation)
            endUpdates()

            completion(true)
        }
    }

    @usableFromInline
    internal func updateSections(_ sections: TransactionBatch, animation: RowAnimation) {
        if sections.isEmpty { return }

        sections.map { element -> Transaction.Section? in
            if case let .section(section) = element {
                return section
            } else {
                return nil
            }
        }.compactMap { $0 }
            .forEach {
                switch $0.changeType {
                case .insert: insertSections([$0.sectionIndex], with: animation)
                case .delete: deleteSections([$0.sectionIndex], with: animation)
                default: break
                }
            }
    }

    @usableFromInline
    internal func updateItems(_ items: TransactionBatch, animation: RowAnimation) {
        if items.isEmpty { return }

        items.map { element -> Transaction.Item? in
            if case let .item(item) = element {
                return item
            } else {
                return nil
            }
        }.compactMap { $0 }
            .forEach {
                switch $0.changeType {
                case .insert: insertRows(at: [$0.newIndexPath].compactMap { $0 }, with: animation)
                case .delete: deleteRows(at: [$0.indexPath].compactMap { $0 }, with: animation)
                case .update: reloadRows(at: [$0.indexPath].compactMap { $0 }, with: animation)
                case .move:
                    deleteRows(at: [$0.indexPath].compactMap { $0 }, with: animation)
                    insertRows(at: [$0.newIndexPath].compactMap { $0 }, with: animation)
                @unknown default: fatalError()
                }
            }
    }
}
