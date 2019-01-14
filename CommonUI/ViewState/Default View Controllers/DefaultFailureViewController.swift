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
        let failureViewController = DefaultFailureViewController(viewModel: .loadFailed(error))
        presenter.navigationController?.pushViewController(failureViewController, animated: animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppStyle.background
        errorView = TextView(frame: .zero)
		errorView.isEditable = false
		errorView.isSelectable = true
		errorView.isScrollEnabled = true
		errorView.alwaysBounceVertical = true
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
		
        stackView = UIStackView(arrangedSubviews: [errorView, reloadButton, secondaryButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        view.addSubview(stackView)
        stackView.activateConstraints(toMarginsOf: view)
		errorView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3).isActive = true
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

