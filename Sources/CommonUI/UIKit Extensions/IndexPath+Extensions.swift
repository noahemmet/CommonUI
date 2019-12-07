//
//  IndexPath+Extensions.swift
//  CommonUI
//
//  Created by Noah Emmet on 1/28/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation
import UIKit

public extension IndexPath {
  // Rows
  
  func isFirstRow() -> Bool {
    return row == 0
  }
  
  func isFirstItem() -> Bool {
    return item == 0
  }
  
  func isLastRow(in tableView: UITableView) -> Bool {
    let numRows = tableView.numberOfRows(inSection: self.section)
    return row == numRows
  }
  
  func isLastItem(in collectionView: UICollectionView) -> Bool {
    let numItems = collectionView.numberOfItems(inSection: self.section)
    return item == numItems
  }
  
  // Sections
  
  func isFirstSection() -> Bool {
    return section == 0
  }
  
  func isLastSection(in tableView: UITableView) -> Bool {
    let numSections = tableView.numberOfSections
    return section == numSections
  }
  
  func isLastSection(in collectionView: UICollectionView) -> Bool {
    let numSections = collectionView.numberOfSections
    return section == numSections
  }
}
