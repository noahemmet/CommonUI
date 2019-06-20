//
//  TextFieldStackViewController.swift
//  CommonUI
//
//  Created by Noah Emmet on 5/21/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation
import Common

public class TextFieldStackViewController: UIViewController, ViewModelConfigurable {
	public struct ViewModel {
		var textFields: [TextFieldConfig]
	}
	
	public struct TextFieldConfig {
		let text: String?
		let placeholder: String
		let font = UIFont.preferredFont(forTextStyle: .body)
		let textContentType: UITextContentType
		
		func create() -> UITextField {
			let textField = UITextField(frame: .zero)
			textField.text = text
			textField.placeholder = placeholder
			textField.font = font
			return textField
		}
	}
	
	let stackView = UIStackView(frame: .zero)
	var viewModel: ViewModel!
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		stackView.axis = .vertical
		stackView.spacing = Layout.spacing
		view.addSubview(stackView)
		stackView.activateConstraints(to: view)
	}
	
	public func configure(with viewModel: TextFieldStackViewController.ViewModel) {
		self.viewModel = viewModel
		stackView.removeAllArrangedSubviews()
		for config in viewModel.textFields {
			let textField = config.create()
			stackView.addArrangedSubview(textField)
		}
	}
}
