//
//  UITableView+ViewWrapping.swift
//  CommonUI
//
//  Created by Noah Emmet on 8/7/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

// MARK: - UITableViewCell

open class WrapperTableCell<View: UIView>: UITableViewCell, ViewWrapping, ViewModelConfigurable where View: ViewModelConfigurable {
    
//    private let viewWrapper: ViewWrapper<View>
	
    public let wrappedView: View = {
        return View.fromXibOrFile()
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        viewWrapper = .init(around: wrappedView)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
//        viewWrapper = .init(around: wrappedView)
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(wrappedView)
//		viewWrapper.setContentCompressionResistancePriority(.required, for: .vertical)
//		viewWrapper.setContentCompressionResistancePriority(.required, for: .horizontal)
//		viewWrapper.setContentHuggingPriority(.required, for: .vertical)
//		viewWrapper.setContentHuggingPriority(.required, for: .horizontal)
        wrappedView.translatesAutoresizingMaskIntoConstraints = false
        wrappedView.activateConstraints(to: contentView)
        wrappedView.preservesSuperviewLayoutMargins = true
    }
    
    public var isSelectable: Bool = true
//	{
//        get { return viewWrapper.isSelectable }
//        set { viewWrapper.isSelectable = isSelectable }
//    }
	
//    open override var isSelected: Bool
//		{
//        didSet { viewWrapper.isSelected = isSelected }
//    }
	
//    open override var isHighlighted: Bool
//		{
//        didSet { viewWrapper.isHighlighted = isHighlighted }
//    }
	
    public var highlightColor: UIColor = .white
//	{
//        set { viewWrapper.highlightColor = highlightColor; isHighlighted = false }
//        get { return viewWrapper.highlightColor }
//
//    }
	
    public var nonHighlightColor: UIColor = .white
//	{
//        set { viewWrapper.nonHighlightColor = nonHighlightColor; isHighlighted = false }
//        get { return viewWrapper.nonHighlightColor }
//    }

}


// MARK: - UITableViewCell (Controller)

open class ControllerWrapperTableCell<ViewController: UIViewController>: UITableViewCell, ViewModelConfigurable where ViewController: ViewModelConfigurable {
	
	public let wrappedController: ViewController = {
		return ViewController.init()
	}()
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.addSubview(wrappedController.view)
		wrappedController.view.translatesAutoresizingMaskIntoConstraints = false
		wrappedController.view.activateConstraints(to: contentView)
		wrappedController.view.preservesSuperviewLayoutMargins = true
		contentView.preservesSuperviewLayoutMargins = true
		preservesSuperviewLayoutMargins = true
	}
	
	public func configure(with viewModel: ViewController.ViewModel) {
		wrappedController.configure(with: viewModel)
	}
}

// MARK: - UITableViewHeaderFooterView

public class WrapperTableSectionView<View: UIView>: UITableViewHeaderFooterView, ViewWrapping, ViewModelConfigurable where View: ViewModelConfigurable {
    
    private let viewWrapper: ViewWrapper<View>
    
    public let wrappedView: View = {
        return View.fromXibOrFile()
    }()
    
    public override init(reuseIdentifier: String?) {
        viewWrapper = .init(around: wrappedView)
        super.init(reuseIdentifier: reuseIdentifier)
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
