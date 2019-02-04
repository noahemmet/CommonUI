//
//  CardViewController.swift
//  CommonUI
//
//  Created by Noah Emmet on 2/3/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation

// MARK: - CardViewController.ViewModel

extension CardViewController {
	
	public struct ViewModel {
		public let colorTheme: ColorTheme
		public let title: NSAttributedString
		public let content: WrappedView.ViewModel
		
		public init(colorTheme: ColorTheme, title: NSAttributedString, content: WrappedView.ViewModel) {
			self.colorTheme = colorTheme
			self.title = title
			self.content = content
		}
	}
	
	public struct ColorTheme {
		public let title: UIColor?
		public let titleBackground: UIColor
		public let contentBackground: UIColor
		public let outerBorder: UIColor

		public init(title: UIColor?, titleBackground: UIColor, contentBackground: UIColor, outerBorder: UIColor) {
			self.title = title
			self.titleBackground = titleBackground
			self.contentBackground = contentBackground
			self.outerBorder = outerBorder
		}
	}
}

// MARK: - CardViewController

public class CardViewController<WrappedView: UIView & ViewModelConfigurable>: UIViewController, ViewModelConfigurable {
	
	var titleView: UIView!
	var titleLabel: UILabel!
	var contentView: UIView!
	
	let cornerRadius: CGFloat = 8
	
	public let wrappedView: WrappedView
	
	public init(wrapping wrappedView: WrappedView) {
		self.wrappedView = wrappedView
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		titleView = UIView(frame: .zero)
		titleView.layoutMargins.left = Layout.spacing + Layout.spacingSmall
		titleView.layoutMargins.right = Layout.spacing + Layout.spacingSmall
		titleView.layoutMargins.top = Layout.spacing
		titleView.layoutMargins.bottom = Layout.spacing
		titleView.setContentCompressionResistancePriority(.required, for: .vertical)
		titleView.setContentCompressionResistancePriority(.required, for: .horizontal)
		titleView.setContentHuggingPriority(.required, for: .vertical)
		titleView.setContentHuggingPriority(.required, for: .horizontal)
		
		titleLabel = Label(frame: .zero)
		titleLabel.text = "hi"
		titleView.addSubview(titleLabel)
		titleLabel.activateConstraints(toMarginsOf: titleView)
		
		contentView = UIView(frame: .zero)
		contentView.addSubview(wrappedView)
		wrappedView.activateConstraints(to: contentView)
		
		let stackView = UIStackView(arrangedSubviews: [titleView, contentView])
		stackView.axis = .vertical
		view.addSubview(stackView)
		stackView.activateConstraints(to: view)
		
		// Content corners
		titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		titleView.layer.cornerRadius = cornerRadius
		contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		contentView.layer.cornerRadius = cornerRadius
		
		// Outer border
		view.layer.borderWidth = 2
		view.layer.cornerRadius = cornerRadius
		
		// Outer shadow
		view.layer.shadowOffset = CGSize(width: 0, height: 4)
		view.layer.shadowOpacity = 1
		view.layer.shadowRadius = 8
		view.layer.shadowColor = view.layer.borderColor
	}
	
	public func configure(with viewModel: ViewModel) {
		
	}
	
	private func configure(colorTheme: ColorTheme) {
		view.layer.borderColor = colorTheme.outerBorder.cgColor
		view.layer.shadowColor = view.layer.borderColor
		titleView.backgroundColor = colorTheme.titleBackground
		contentView.backgroundColor = colorTheme.contentBackground

	}
	
}
