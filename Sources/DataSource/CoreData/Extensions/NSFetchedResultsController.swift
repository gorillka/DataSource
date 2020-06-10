//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import CoreData

@usableFromInline
internal class FetchedResultsController<ResultType: NSManagedObject>: NSFetchedResultsController<NSFetchRequestResult> {
    @usableFromInline
    internal init<Request: FetchRequestable>(
        request: Request
    ) where ResultType == Request.EntityType {
        super.init(
            fetchRequest: request,
            managedObjectContext: request.context,
            sectionNameKeyPath: request.sectionKeyPath,
            cacheName: request.cacheName
        )
    }

    @usableFromInline
    internal var request: NSFetchRequest<ResultType> {
        fetchRequest as! NSFetchRequest<ResultType>
    }
}
