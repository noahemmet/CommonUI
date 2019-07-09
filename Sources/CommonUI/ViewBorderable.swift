//
//  ViewBorderable.swift
//  Views
//
//  Created by Noah Emmet on 5/26/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public class Border: UIView {
    public enum Visibility {
        case automatic
        case full
        case inset
        case hide
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = AppStyle.border
    }
}

public extension UIView {
    private static let topLeadingBorderConstraintKey = "topLeadingBorderConstraintIdentifier"
    private static let topTrailingBorderConstraintKey = "topTrailingBorderConstraintIdentifier"
    private static let bottomLeadingBorderConstraintKey = "bottomLeadingBorderConstraintIdentifier"
    private static let bottomTrailingBorderConstraintKey = "bottomTrailingBorderConstraintIdentifier"
	static let defaultSectionBorderThickness: CGFloat = 1
	static let defaultRowBorderThickness: CGFloat = 1 / UIScreen.main.scale
	static let defaultSectionInset: CGFloat = 0
	static let defaultRowInset: CGFloat = 16
    
    var topLeadingBorderConstraint: NSLayoutConstraint! {
        let constraint = self.constraints.first(where: {$0.identifier == UIView.topLeadingBorderConstraintKey })
        return constraint
    }
    
    var topTrailingBorderConstraint: NSLayoutConstraint! {
        let constraint = self.constraints.first(where: {$0.identifier == UIView.topTrailingBorderConstraintKey })
        return constraint
    }
    
    var bottomLeadingBorderConstraint: NSLayoutConstraint! {
        let constraint = self.constraints.first(where: {$0.identifier == UIView.bottomLeadingBorderConstraintKey })
        return constraint
    }
    
    var bottomTrailingBorderConstraint: NSLayoutConstraint! {
        let constraint = self.constraints.first(where: {$0.identifier == UIView.bottomTrailingBorderConstraintKey })
        return constraint
    }
    
    var topBorder: Border! {
        let border = subviews.first(where: { $0.tag == ViewTags.topBorder }) as? Border
        return border
    }
    
    var bottomBorder: Border! {
        let border = subviews.first(where: { $0.tag == ViewTags.bottomBorder }) as? Border
        return border
    }
    
    private func configureInsetConstraints(topLeading: CGFloat, bottomLeading: CGFloat, topTrailing: CGFloat = 0, bottomTrailing: CGFloat = 0) {
        topLeadingBorderConstraint.constant = topLeading
        topTrailingBorderConstraint.constant = topTrailing
        bottomLeadingBorderConstraint.constant = bottomLeading
        bottomTrailingBorderConstraint.constant = bottomTrailing
    }
    
    // TableView
    
    func configureBorders(at indexPath: IndexPath, in tableView: UITableView, top: Border.Visibility = .automatic, bottom: Border.Visibility = .automatic, rowInset leadingRowInset: CGFloat? = nil) {
        configureBorders(at: indexPath, totalRows: tableView.numberOfRows(inSection: indexPath.section), top: top, bottom: bottom, rowInset: leadingRowInset ?? tableView.layoutMargins.left)
    }
    
    // CollectionView
    
    func configureBorders(at indexPath: IndexPath, in collectionView: UICollectionView, top: Border.Visibility = .automatic, bottom: Border.Visibility = .automatic, rowInset leadingRowInset: CGFloat? = nil) {
        configureBorders(at: indexPath, totalRows: collectionView.numberOfItems(inSection: indexPath.section), top: top, bottom: bottom, rowInset: leadingRowInset)
    }
    
    func configureBorders(at indexPath: IndexPath, totalRows: Int, top: Border.Visibility = .automatic, bottom: Border.Visibility = .automatic, rowInset leadingRowInset: CGFloat? = nil) {
        let isSectionStart = indexPath.row == 0
        let isSectionEnd = indexPath.row == totalRows - 1
        self.configureBorders(sectionStart: isSectionStart, sectionEnd: isSectionEnd, top: top, bottom: bottom, rowInset: leadingRowInset)
    }
    
    func configureBorders(sectionStart: Bool, sectionEnd: Bool, top: Border.Visibility = .automatic, bottom: Border.Visibility = .automatic, rowInset leadingRowInset: CGFloat? = nil) {
        let _ = self.findOrCreateBorders()
        let topLeading: CGFloat
        let bottomLeading: CGFloat
        switch top {
        case .automatic:
            topLeading = sectionStart ? UIView.defaultSectionInset : leadingRowInset ?? UIView.defaultRowInset
            topBorder.isHidden = !sectionStart
        case .full:
            topLeading = 0
            topBorder.isHidden = false
        case .inset:
            topLeading = leadingRowInset ?? UIView.defaultRowInset
            topBorder.isHidden = false
        case .hide:
            topLeading = 0
            topBorder.isHidden = true
        }
        switch bottom {
        case .automatic:
            bottomLeading = sectionEnd ? UIView.defaultSectionInset : leadingRowInset ?? UIView.defaultRowInset
            bottomBorder.isHidden = !sectionEnd
        case .full:
            bottomLeading = 0
            bottomBorder.isHidden = false
        case .inset:
            bottomLeading = leadingRowInset ?? UIView.defaultRowInset
            bottomBorder.isHidden = false
        case .hide:
            bottomLeading = 0
            bottomBorder.isHidden = true
        }
        configureInsetConstraints(topLeading: topLeading, bottomLeading: bottomLeading)
    }
    
    func constrainBorderRowInset(to view: UIView) {
        fatalError("do something")
    }
    
    func setBorderColor(to borderColor: UIColor) {
        assert(topBorder != nil)
        assert(bottomBorder != nil)
        topBorder.backgroundColor = borderColor
        bottomBorder.backgroundColor = borderColor
    }
    
    private func findOrCreateBorders() -> (top: Border, bottom: Border) {
        let topBorder: Border
        if let existingTopBorder = self.topBorder {
            topBorder = existingTopBorder 
        } else {
            topBorder = addTopBorder()
        }
        let bottomBorder: Border
        if let existingBottomBorder = self.bottomBorder {
            bottomBorder = existingBottomBorder 
        } else {
            bottomBorder = addBottomBorder()
        }
        return (topBorder, bottomBorder)
    } 
    
    @discardableResult
	func addTopBorder() -> Border {
        let border = Border(frame: .zero)
        border.tag = ViewTags.topBorder
        border.translatesAutoresizingMaskIntoConstraints = false
        addSubview(border)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: UIView.defaultSectionBorderThickness)
        let topConstraint = border.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let leadingConstraint = border.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingConstraint.identifier = UIView.topLeadingBorderConstraintKey
        let trailingConstraint = border.trailingAnchor.constraint(equalTo: trailingAnchor)
        trailingConstraint.identifier = UIView.topTrailingBorderConstraintKey
        NSLayoutConstraint.activate([heightConstraint, topConstraint, leadingConstraint, trailingConstraint])
        return border
    }
    
    @discardableResult
	func addBottomBorder() -> Border {
        let border = Border(frame: .zero)
        border.tag = ViewTags.bottomBorder
        border.translatesAutoresizingMaskIntoConstraints = false
        addSubview(border)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: UIView.defaultSectionBorderThickness)
        let bottomConstraint = border.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        let leadingConstraint = border.leadingAnchor.constraint(equalTo: leadingAnchor)
        leadingConstraint.identifier = UIView.bottomLeadingBorderConstraintKey
        let trailingConstraint = border.trailingAnchor.constraint(equalTo: trailingAnchor)
        trailingConstraint.identifier = UIView.bottomTrailingBorderConstraintKey
        NSLayoutConstraint.activate([heightConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        return border
    }
}
