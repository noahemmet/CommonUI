//
//  UICollectionView+ViewWrapping.swift
//  CommonUI
//
//  Created by Noah Emmet on 8/7/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

// MARK: - UICollectionViewCell

open class WrapperCollectionCell<View: UIView>: UICollectionViewCell, ViewWrapping, ViewModelConfigurable where View: ViewModelConfigurable {
    
    public class func wrapping(view: View) -> WrapperCollectionCell<View>? {
        let contentView = view.superview
        return contentView?.superview as? WrapperCollectionCell<View>
    }
    
    private let viewWrapper: ViewWrapper<View>
    
    public let wrappedView: View = {
        return View.fromXibOrFile()
    }()
    
    public override init(frame: CGRect) {
        viewWrapper = .init(around: wrappedView)
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        viewWrapper = .init(around: wrappedView)
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(viewWrapper)
        viewWrapper.translatesAutoresizingMaskIntoConstraints = false
        viewWrapper.activateConstraints(to: contentView)
        viewWrapper.preservesSuperviewLayoutMargins = true
        contentView.preservesSuperviewLayoutMargins = true
        preservesSuperviewLayoutMargins = true
        
        wrappedView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
    }
	
	override open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
		setNeedsLayout()
		layoutIfNeeded()
		let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
		var frame = layoutAttributes.frame
		frame.size.height = ceil(size.height)
		layoutAttributes.frame = frame
		return layoutAttributes
	}
    
    public var isSelectable: Bool { 
        get { return viewWrapper.isSelectable }
        set { viewWrapper.isSelectable = isSelectable }
    }
    
    open override var isSelected: Bool {
        didSet { viewWrapper.isSelected = isSelected }
    }
    
    open override var isHighlighted: Bool {
        didSet { viewWrapper.isHighlighted = isHighlighted }
    }
    
    public var highlightColor: UIColor {
        set { viewWrapper.animator.highlightColor = highlightColor }
        get { return viewWrapper.animator.highlightColor }
        
    }
    
    public var nonHighlightColor: UIColor { 
        set { viewWrapper.animator.nonHighlightColor = nonHighlightColor }
        get { return viewWrapper.animator.nonHighlightColor }
    }
    
    public var preferredWidth: CGFloat? {
        get { return viewWrapper.preferredWidth}
        set { viewWrapper.preferredWidth = preferredWidth }
    }
    
    open override var intrinsicContentSize: CGSize {
        return wrappedView.intrinsicContentSize
    }
}

// MARK: - UICollectionReusableView

open class WrapperCollectionReusableView<View: UIView>: UICollectionReusableView, ViewWrapping, ViewModelConfigurable where View: ViewModelConfigurable {
    
    private let viewWrapper: ViewWrapper<View>
    
    public let wrappedView: View = {
        return View.fromXibOrFile()
    }()
    
    public override init(frame: CGRect) {
        viewWrapper = .init(around: wrappedView)
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        viewWrapper = .init(around: wrappedView)
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(viewWrapper)
        viewWrapper.translatesAutoresizingMaskIntoConstraints = false
        viewWrapper.activateConstraints(to: self)
        viewWrapper.preservesSuperviewLayoutMargins = true
        preservesSuperviewLayoutMargins = true
    }
    
    public var highlightColor: UIColor {
        set { viewWrapper.animator.highlightColor = highlightColor }
        get { return viewWrapper.animator.highlightColor }
        
    }
    
    public var nonHighlightColor: UIColor { 
        set { viewWrapper.animator.nonHighlightColor = nonHighlightColor }
        get { return viewWrapper.animator.nonHighlightColor }
    }
}
