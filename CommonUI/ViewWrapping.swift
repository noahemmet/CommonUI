//
//  ViewWrapping.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/22/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import Resources

// MARK: - ViewWrappingProtocol

/// Convenience for passing commands to the wrapped view.
public protocol ViewWrapping {
    associatedtype View: UIView & ViewModelConfigurable
    var wrappedView: View { get }
    var highlightColor: UIColor { get }
    var nonHighlightColor: UIColor { get }
}

public extension ViewWrapping {
    func configure(with viewModel: View.ViewModel) {
        wrappedView.configure(with: viewModel)
    }
}

// MARK: - ViewWrapper View

/// A wrapper around a subview. Can handle selection/highlights/accessories.
class ViewWrapper<Wrapped: UIView>: UIView {
    let stackView: UIStackView
    unowned var wrappedView: Wrapped
    
    init(around wrappedView: Wrapped) {
        stackView = UIStackView(arrangedSubviews: [wrappedView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.preservesSuperviewLayoutMargins = true
        self.wrappedView = wrappedView
        super.init(frame: .zero)
        self.addSubview(wrappedView)
        wrappedView.preservesSuperviewLayoutMargins = true
        wrappedView.setContentCompressionResistancePriority(.required, for: .vertical)
        wrappedView.setContentCompressionResistancePriority(.required, for: .horizontal)
        wrappedView.activateConstraints(to: self)
        
        animator.setSelected(false, animated: false)
        animator.setHighlighted(false, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var animator: SelectionAnimator = {
        if let highlightableView = wrappedView as? UIView & ViewHighlightable {
            return SelectionAnimator(view: highlightableView, containerView: self)
        } else {
            return SelectionAnimator(scalingView: wrappedView, highlightableView: self, containerView: self, highlightColor: highlightColor, nonHighlightColor: nonHighlightColor)
        }
    }()
    
    var isSelected: Bool = false {
        didSet {
            if isSelectable {
                // passing in `isSelected` for both lets us keep highlight on cell selection 
                animator.setSelected(isSelected, animated: true)
                animator.setHighlighted(isSelected, animated: true)
            }
        }
    }
    
    var isHighlighted: Bool = false {
        didSet {
            if isSelectable {
                animator.setSelected(isHighlighted, animated: true)
                animator.setHighlighted(isHighlighted, animated: true)
            }
            wrappedView.backgroundColor = isHighlighted ? highlightColor : nonHighlightColor
        }
    }
    
    var isSelectable: Bool = true {
        didSet {
            if isSelectable == false {
                isSelected = false
                isHighlighted = false
            }
        }
    }
    
    public var highlightColor: UIColor = AppStyle.highlight {
        didSet { animator.highlightColor = highlightColor; isHighlighted = false }
    }
//    {
//        set { animator.highlightColor = highlightColor }
//        get { return animator.highlightColor }
//        
//    }
    
    public var nonHighlightColor: UIColor = .clear {
        didSet { backgroundColor = nonHighlightColor; wrappedView.backgroundColor = nonHighlightColor; animator.nonHighlightColor = nonHighlightColor; isHighlighted = false }
    }
//    { 
//        set { animator.nonHighlightColor = nonHighlightColor }
//        get { return animator.nonHighlightColor }
//    }
    
    var widthConstraint: NSLayoutConstraint?
    
    /// Sets a preferred width. Useful for UICollectionView cells.
    var preferredWidth: CGFloat? {
        didSet {
            if let preferredWidth = preferredWidth, widthConstraint == nil {
                widthConstraint = wrappedView.widthAnchor.constraint(equalToConstant: preferredWidth)
                widthConstraint!.isActive = true
                setNeedsUpdateConstraints()
            } else {
                if let widthConstraint = widthConstraint {
                    self.removeConstraint(widthConstraint)
                }
            }
        }
    }
    
    // MARK: Accessories
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if needsAccessoryConfiguration {
            return;
            configureAccessories()
        }
    }
    
    private func configureAccessories() {
        return
        defer { needsAccessoryConfiguration = false }
        let arrangedViews: [UIView?] = stackView.arrangedSubviews
        var expectedArrangedViews: [UIView?] = [wrappedView]
        if showDisclosureArrow, expectedArrangedViews.contains(disclosureArrow) == false {
            disclosureArrow = UIImageView(image: Asset.play.image)
            disclosureArrow?.useAutoLayout()
            disclosureArrow?.contentMode = .scaleAspectFill
            disclosureArrow?.activateConstraints(ofSize: Asset.play.image.size)
            expectedArrangedViews.append(disclosureArrow)
        } else {
            disclosureArrow = nil
        }
        guard arrangedViews != expectedArrangedViews else {
            // Accessories are already configured.
            return
        }
        let flattenedViews = expectedArrangedViews.compactMap { $0 }
        stackView.setArrangedSubviews(flattenedViews)
    }
    
    /// Set this to false after configuring the accessories.
    private var needsAccessoryConfiguration = true
    
    var disclosureArrow: UIImageView? = nil
    var showDisclosureArrow: Bool = false {
        didSet { setNeedsLayout() }
    }
}
