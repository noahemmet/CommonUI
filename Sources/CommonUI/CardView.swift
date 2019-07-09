//
//  CardView.swift
//  CommonUI
//
//  Created by Noah Emmet on 2/3/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CardView.ViewModel

extension CardView {
	public struct CardViewModel<WrappedView: ViewModelConfigurable> {
		public let colorTheme: ColorTheme
		public let title: NSAttributedString
		public let content: WrappedView.ViewModel
		
		public init(colorTheme: ColorTheme = ColorTheme.defaultColorTheme, title: NSAttributedString, content: WrappedView.ViewModel) {
			self.colorTheme = colorTheme
			self.title = title
			self.content = content
		}
	}
	
	public struct ColorTheme {
		public static var defaultColorTheme: ColorTheme {
			return ColorTheme(title: AppStyle.primaryText,
							  titleBackground: AppStyle.background,
							  contentBackground: AppStyle.background2,
							  outerBorder: AppStyle.border)
		}
		
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

// MARK: - CardView

public class CardView<WrappedView: UIView>: UIView {
	
	public let titleView = UIView(frame: .zero)
	public let titleLabel = Label(frame: .zero)
	public let contentView = UIView(frame: .zero)
	
	public let wrappedView: WrappedView
	
	let cornerRadius: CGFloat = 8
	
	public init(wrapping wrappedView: WrappedView) {
		self.wrappedView = wrappedView
		super.init(frame: .zero)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func commonInit() {
		
		titleView.layoutMargins.top = Layout.spacing + 2
		titleView.layoutMargins.bottom = Layout.spacing
		titleView.setContentCompressionResistancePriority(.required, for: .vertical)
		titleView.setContentCompressionResistancePriority(.required, for: .horizontal)
		titleView.setContentHuggingPriority(.required, for: .vertical)
		titleView.setContentHuggingPriority(.required, for: .horizontal)
		
		titleLabel.numberOfLines = 0
		titleView.addSubview(titleLabel)
		titleLabel.activateConstraints(toMarginsOf: titleView)
		titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
		titleLabel.setContentHuggingPriority(.required, for: .vertical)
		
		contentView.addSubview(wrappedView)
		wrappedView.activateConstraints(toMarginsOf: contentView)
		
		let stackView = UIStackView(arrangedSubviews: [titleView, contentView])
		stackView.axis = .vertical
		addSubview(stackView)
		stackView.activateConstraints(to: self)
		
		// Content corners
		titleView.clipsToBounds = true
		titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		titleView.layer.cornerRadius = cornerRadius
		contentView.clipsToBounds = true
		contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		contentView.layer.cornerRadius = cornerRadius
		
		// Outer border
		layer.borderWidth = 2
		layer.cornerRadius = cornerRadius
		
		// Outer shadow
		layer.shadowOffset = CGSize(width: 0, height: 4)
		layer.shadowOpacity = 0.2
		layer.shadowRadius = 4
		layer.shadowColor = layer.borderColor
	}
	
	public func configure(with colorTheme: ColorTheme) {
		layer.borderColor = colorTheme.outerBorder.cgColor
		layer.shadowColor = UIColor.black.cgColor
		titleLabel.textColor = colorTheme.title
		titleView.backgroundColor = colorTheme.titleBackground
		contentView.backgroundColor = colorTheme.contentBackground
	}
}

extension CardView: ViewModelConfigurable where WrappedView: ViewModelConfigurable {
	
	public typealias ViewModel = CardViewModel<WrappedView>
	
	public func configure(with viewModel: ViewModel) {
		titleLabel.attributedText = viewModel.title
		configure(with: viewModel.colorTheme)
	}
}
