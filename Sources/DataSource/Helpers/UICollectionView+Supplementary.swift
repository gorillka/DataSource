//
// Copyright © 2020. Orynko Artem
//
// MIT license, see LICENSE file for details
//

import UIKit

extension UICollectionView {
    @usableFromInline
    internal enum SupplementaryViewKind {
        case header
        case footer

        internal var rawValue: String {
            switch self {
            case .header: return UICollectionView.elementKindSectionHeader
            case .footer: return UICollectionView.elementKindSectionFooter
            }
        }
    }
}
