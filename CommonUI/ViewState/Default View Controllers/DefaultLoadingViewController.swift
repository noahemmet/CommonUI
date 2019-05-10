//
//  DefaultLoadingViewController.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/23/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import Common

// MARK: - ViewModel

extension DefaultLoadingViewController {
    public struct ViewModel {
        public var text: String
        public var animationDelay: TimeInterval
        public var animate: Bool
        
        public init(text: String = "Loading…", animationDelay: TimeInterval = 0.3, animate: Bool = true) {
            self.text = text
            self.animationDelay = animationDelay
            self.animate = animate
        }
    }
}

// MARK: - DefaultLoadingViewController

public class DefaultLoadingViewController: UIViewController, ViewModelConfigurable {
    var spinnerView: UIActivityIndicatorView!
    var viewModel: ViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppStyle.background
        
        spinnerView = UIActivityIndicatorView(style: .gray)
        spinnerView.color = AppStyle.darkGray
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.spinnerView.alpha = 0
		let delay: TimeInterval
		if let viewModel = viewModel {
			delay = viewModel.animate ? viewModel.animationDelay : 0
		} else {
			delay = 0
		}
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: Animation.defaultDuration,
            delay: delay,
            options: [],
            animations: { 
                self.spinnerView.startAnimating()
                self.spinnerView.alpha = 1
        }, completion: nil)
    }
    
    public func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
