//
//  UICollectionViewFlowLayout+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 1/28/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionViewFlowLayout {
  // MARK: Registration

  func registerDecorationView<V: UIView & ViewModelConfigurable>(ofType type: V.Type) {
    let identifier = String(describing: type)
    self.register(WrapperCollectionReusableView<V>.self, forDecorationViewOfKind: identifier)
  }

  // MARK: Dequeument
}
