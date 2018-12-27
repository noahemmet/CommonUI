//
//  UITableView+Extensions.swift
//  ScrollKit
//
//  Created by Noah Emmet on 2/3/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public extension UITableView {
	
    // MARK: Register Cells
    
	func registerCell<C: UITableViewCell>(ofType type: C.Type) {
		self.register(type, forCellReuseIdentifier: String(describing: type))
	}
    
    func registerCellNib<C: UITableViewCell>(ofType type: C.Type) {
        let nib = UINib(nibName: C.xibIdentifier, bundle: nil)
        let identifier = String(describing: type)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerCell<V: UIView & ViewModelConfigurable>(wrapping type: V.Type) {
        self.register(WrapperTableCell<V>.self, forCellReuseIdentifier: String(describing: type))
    }
    
    func registerCell<VC: UIViewController & ViewModelConfigurable>(wrapping type: VC.Type) {
        self.register(ControllerWrapperTableCell<VC>.self, forCellReuseIdentifier: String(describing: type))
    }
    
    func registerCellFromNib<V: UIView & ViewModelConfigurable>(wrapping type: V.Type) {
        let nib = UINib(nibName: V.xibIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: String(describing: type))
    }

    
    // MARK: Register Header/Footers
	
    func registerHeaderFooterView<V: UITableViewHeaderFooterView>(ofType type: V.Type) {
        self.register(type, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }
    
    func registerHeaderFooterViewNib<V: UITableViewHeaderFooterView>(ofType type: V.Type) {
        let nib = UINib(nibName: V.xibIdentifier, bundle: nil)
        let identifier = String(describing: type)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterView<V: UIView & ViewModelConfigurable>(wrapping type: V.Type) {
        self.register(WrapperTableSectionView<V>.self, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }
    
    // MARK: Dequeue Cells
    
	func dequeueCell<C: UITableViewCell>(ofType type: C.Type, at indexPath: IndexPath) -> C {
		let cell = self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! C
		return cell
	}
    
    func dequeueCell<V: UIView & ViewModelConfigurable>(wrapping type: V.Type, at indexPath: IndexPath) -> WrapperTableCell<V> {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! WrapperTableCell<V>
        return cell
    }
    
    func dequeueCell<VC: UIViewController & ViewModelConfigurable>(wrapping type: VC.Type, at indexPath: IndexPath) -> ControllerWrapperTableCell<VC> {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! ControllerWrapperTableCell<VC>
        return cell
    }
    
    // MARK: Dequeue Header/Footers
    
    func dequeueHeaderFooterView<V: UIView>(ofType type: V.Type) -> V {
        let view = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! V
        return view
    }
    
    func dequeueHeaderFooterView<V: UIView & ViewModelConfigurable>(wrapping type: V.Type) -> WrapperTableSectionView<V> {
        let view = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! WrapperTableSectionView<V>
        return view
    }
}

// MARK: - Heights

public extension UITableView {
    typealias EstimateSectionHeight = (Int) -> CGFloat
    func estimatedHeight(with estimate: EstimateSectionHeight) -> CGFloat {
        let sectionCount = self.numberOfSections
        let estimatedSectionHeights: [(section: Int, height: CGFloat)] = (0..<sectionCount).map { (section: $0, height: estimate($0))}
        let estimatedRowHeights: [(rowCount: Int, height: CGFloat)] = estimatedSectionHeights.map { (rowCount: self.numberOfRows(inSection: $0.section), height: $0.height) }
        let averageHeight = estimatedRowHeights.map { CGFloat($0.rowCount) * $0.height }.average
        let rowHeight = averageHeight / CGFloat(sectionCount)
        return rowHeight
    }
}

// Misc

public extension UITableView {
    
    func resize() {
        let currentOffset = contentOffset 
//        if !animated {
            UIView.setAnimationsEnabled(false)
//        }
        beginUpdates()
        endUpdates()
//        if !animated {
            UIView.setAnimationsEnabled(true)
//        }
        setContentOffset(currentOffset, animated: false)
    }
    
    func deselectIfSelected(animated: Bool) {
        if let selected = indexPathForSelectedRow {
            deselectRow(at: selected, animated: animated)
        }
    }
}
