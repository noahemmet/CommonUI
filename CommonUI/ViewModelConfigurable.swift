//
//  ViewModelConfigurable.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/17/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

// MARK: - ViewModelConfigurable Protocol

public protocol ViewModelConfigurable {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
	func tryConfigure(with viewModel: ViewModel) throws
}

public extension ViewModelConfigurable {
	func configure(with viewModel: ViewModel) {
		try! tryConfigure(with: viewModel)
	}
	
	func tryConfigure(with viewModel: ViewModel) throws {
		configure(with: viewModel)
	}
}

public typealias ViewControllerModelConfigurable = UIViewController & ViewModelConfigurable
public typealias ViewControllerErrorModelConfigurable = UIViewController & ErrorViewModelConfigurable


// MARK: - ViewModelInitializable Protocol

/// Probably won't work for Storyboards/Xibs
public protocol ViewModelInitializable {
    associatedtype ViewModel
    init(with viewModel: ViewModel)
}

public typealias ViewControllerModelInitializable = UIViewController & ViewModelInitializable

// MARK: - Common UIKit

extension UILabel: ViewModelConfigurable {
    public func configure(with text: String) {
        self.text = text
    }
}
