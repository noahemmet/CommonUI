//
//  CollectionViewFlowLayout.swift
//  CommonUI
//
//  Created by Noah Emmet on 7/28/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

open class CollectionViewFlowLayout: UICollectionViewFlowLayout {
  open override func invalidationContext(
    forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
    withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes
  ) -> UICollectionViewLayoutInvalidationContext {
    let context = super.invalidationContext(
      forPreferredLayoutAttributes: preferredAttributes,
      withOriginalAttributes: originalAttributes
    )
    context.invalidateSupplementaryElements(
      ofKind: UICollectionView.elementKindSectionHeader,
      at: [originalAttributes.indexPath]
    )
    return context
  }
}
