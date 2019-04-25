//
//  DefaultFailureViewController.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/23/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import Common

public protocol ErrorViewModelConfigurable: ViewModelConfigurable where ViewModel: Error {
    static func viewModel(from error: Error) -> ViewModel
}

public protocol DefaultFailureViewControllerDelegate: class {
    func defaultFailureViewController(_ defaultFailureViewController: DefaultFailureViewController, didTapReloadButton reloadButton: UIButton)
    func defaultFailureViewController(_ defaultFailureViewController: DefaultFailureViewController, didTapSecondaryButton secondaryButton: UIButton)
}

public class DefaultFailureViewController: UIViewController, ErrorViewModelConfigurable {
    public static func viewModel(from error: Error) -> CustomSuccessViewStateError {
        return CustomSuccessViewStateError.loadFailed(error)
    }
    
    var stackView: UIStackView!
    var errorView: TextView!
    var reloadButton: UIButton!
    var secondaryButton: UIButton!
    public weak var delegate: DefaultFailureViewControllerDelegate?
    
    public class func present(from presenter: UIViewController, with error: Error, animated: Bool) {
        let failureViewController = try! DefaultFailureViewController(viewModel: .loadFailed(error))
        presenter.navigationController?.pushViewController(failureViewController, animated: animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
		
		view.preservesSuperviewLayoutMargins = true
        view.backgroundColor = AppStyle.background

        errorView = TextView(frame: .zero)
		errorView.font = UIFont.preferredFont(forTextStyle: .body)
		errorView.setContentHuggingPriority(.required, for: .vertical)
		errorView.setContentCompressionResistancePriority(.required, for: .vertical)
		errorView.textContainerInset.left = Layout.spacingMedium
		errorView.textContainerInset.right = Layout.spacingMedium
		errorView.isEditable = false
		errorView.isSelectable = true
		errorView.isScrollEnabled = false

		
		let scrollView = UIScrollView(frame: .zero)
		scrollView.addSubview(errorView)
		scrollView.preservesSuperviewLayoutMargins = true
		errorView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).activate()
		errorView.activateConstraints(to: scrollView)
		
        reloadButton = UIButton(type: .custom)
        reloadButton.setTitle("Reload", for: .normal)
        reloadButton.setTitleColor(AppStyle.tint, for: .normal)
        reloadButton.setTitleColor(AppStyle.tintHighlight, for: .highlighted)
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .primaryActionTriggered)
		
        secondaryButton = UIButton(type: .custom)
        secondaryButton.setTitle("Log Out", for: .normal)
        secondaryButton.setTitleColor(AppStyle.tint, for: .normal)
        secondaryButton.setTitleColor(AppStyle.tintHighlight, for: .highlighted)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .primaryActionTriggered)
		
        stackView = UIStackView(arrangedSubviews: [scrollView, reloadButton, secondaryButton])
		stackView.spacing = Layout.spacing
		stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        view.addSubview(stackView)
		stackView.activateConstraints(to: view,
									  insets: UIEdgeInsets(bottom: -Layout.spacing),
									  horizontal: .view,
									  vertical: .margins)
    }
	
    public func configure(with viewModel: CustomSuccessViewStateError) {
        errorView.text = "\(viewModel)"
    }
    
    @objc
    func reloadButtonTapped() {
        delegate?.defaultFailureViewController(self, didTapReloadButton: reloadButton)
    }
	
    @objc
    func secondaryButtonTapped() {
        delegate?.defaultFailureViewController(self, didTapSecondaryButton: secondaryButton)
    }
}

