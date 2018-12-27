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
    var errorLabel: UILabel!
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
        errorLabel = UILabel(frame: .zero)
        errorLabel.numberOfLines = 0
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
		
        stackView = UIStackView(arrangedSubviews: [errorLabel, reloadButton, secondaryButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        view.addSubview(stackView)
        stackView.activateConstraints(toMarginsOf: view)
    }
    
    public func configure(with viewModel: CustomSuccessViewStateError) {
        errorLabel.text = "\(viewModel)"
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

