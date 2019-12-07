//
//  UICollectionView+Extensions.swift
//  SlashKit
//
//  Created by Noah Emmet on 4/15/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
  // MARK: Registration
  
  func registerCell<C: UICollectionViewCell>(ofType type: C.Type) {
    self.register(type, forCellWithReuseIdentifier: String(describing: type))
  }
  
  func registerCell<V: UIView & ViewModelConfigurable>(wrapping type: V.Type) {
    self.register(
      WrapperCollectionCell<V>.self,
      forCellWithReuseIdentifier: String(describing: type)
    )
  }
  
  func registerCellFromNib<C: UICollectionViewCell>(ofType type: C.Type) {
    let nib = UINib(nibName: C.xibIdentifier, bundle: nil)
    self.register(nib, forCellWithReuseIdentifier: String(describing: type))
  }
  
  func registerCellFromNib<V: UIView & ViewModelConfigurable>(wrapping type: V.Type) {
    let nib = UINib(nibName: V.xibIdentifier, bundle: nil)
    self.register(nib, forCellWithReuseIdentifier: String(describing: type))
  }
  
  func registerReusableView<V: UIView & ViewModelConfigurable>(wrapping type: V.Type) {
    let identifier = String(describing: type)
    self.register(
      WrapperCollectionReusableView<V>.self,
      forSupplementaryViewOfKind: identifier,
      withReuseIdentifier: identifier
    )
  }
  
  func registerReusableView<V: UIView>(ofType type: V.Type) {
    let identifier = String(describing: type)
    self.register(V.self, forSupplementaryViewOfKind: identifier, withReuseIdentifier: identifier)
  }
  
  // MARK: Dequeument
  
  func dequeueCell<C: UICollectionViewCell>(ofType type: C.Type, at indexPath: IndexPath) -> C {
    let cell = self.dequeueReusableCell(
      withReuseIdentifier: String(describing: type),
      for: indexPath
    ) as! C
    return cell
  }
  
  func dequeueCell<V: UIView & ViewModelConfigurable>(
    wrapping type: V.Type,
    at indexPath: IndexPath
  ) -> WrapperCollectionCell<V> {
    let cell: WrapperCollectionCell<V> = self.dequeueReusableCell(
      withReuseIdentifier: String(describing: type),
      for: indexPath
    ) as! WrapperCollectionCell
    return cell
  }
  
  func dequeueReusableView<V: UIView>(ofType type: V.Type, at indexPath: IndexPath) -> V {
    let identifier = String(describing: type)
    let view: V = dequeueReusableSupplementaryView(
      ofKind: identifier,
      withReuseIdentifier: identifier,
      for: indexPath
    ) as! V
    return view
  }
  
  func dequeueReusableView<V: UIView & ViewModelConfigurable>(
    wrapping type: V.Type,
    at indexPath: IndexPath
  ) -> WrapperCollectionReusableView<V> {
    let identifier = String(describing: type)
    let view: WrapperCollectionReusableView<V> = dequeueReusableSupplementaryView(
      ofKind: identifier,
      withReuseIdentifier: identifier,
      for: indexPath
    ) as! WrapperCollectionReusableView
    return view
  }
  
  // MARK: - Scrolling
  
  func scrollToLastIndexPath(animated: Bool) {
    let lastSection = self.numberOfSections - 1
    guard lastSection >= 0 else { return }
    let lastRow = self.numberOfItems(inSection: lastSection) - 1
    guard lastSection >= 0, lastRow >= 0 else { return }
    let last = IndexPath(item: lastRow, section: lastSection)
    scrollToItem(at: last, at: .bottom, animated: animated)
  }
  
  // Selection
  
  func deselect(animated: Bool, delay: TimeInterval = Animation.deselectionDelay) {
    let deselection: () -> Void = {
      if let indexPaths = self.indexPathsForSelectedItems {
        for indexPath in indexPaths {
          self.deselectItem(at: indexPath, animated: animated)
        }
      }
    }
    if delay > 0 {
      DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: deselection)
    } else {
      deselection()
    }
  }
}
