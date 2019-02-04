//
//  CardViewController.swift
//  CommonUI
//
//  Created by Noah Emmet on 2/3/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation

// MARK: - CardViewController

public class CardViewController<WrappedView: UIView & ViewModelConfigurable>: UIViewController, ViewModelConfigurable {
	
	public let cardView: CardView<WrappedView>
	public var wrappedView: WrappedView {
		return cardView.wrappedView
	}

	public init(wrapping wrappedView: WrappedView) {
		self.cardView = CardView(wrapping: wrappedView)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(cardView)
		cardView.activateConstraints(to: view)
	}
	
	public func configure(with viewModel: CardView<WrappedView>.ViewModel) {
		cardView.configure(with: viewModel)
	}
}
