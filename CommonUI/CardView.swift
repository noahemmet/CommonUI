//
//  CardView.swift
//  CommonUI
//
//  Created by Noah Emmet on 2/3/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation

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
			return ColorTheme(title: .black,
							  titleBackground: #colorLiteral(red: 0.9102776878, green: 0.9102776878, blue: 0.9102776878, alpha: 1),
							  contentBackground: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
							  outerBorder: #colorLiteral(red: 0.6595522474, green: 0.6595522474, blue: 0.6595522474, alpha: 1))
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
		
		clipsToBounds = true
		
		//		titleView.layoutMargins.left = Layout.spacing + Layout.spacingSmall
		//		titleView.layoutMargins.right = Layout.spacing + Layout.spacingSmall
		titleView.layoutMargins.top = Layout.spacing
		//		titleView.layoutMargins.bottom = Layout.spacing
		titleView.setContentCompressionResistancePriority(.required, for: .vertical)
		titleView.setContentCompressionResistancePriority(.required, for: .horizontal)
		titleView.setContentHuggingPriority(.required, for: .vertical)
		titleView.setContentHuggingPriority(.required, for: .horizontal)
		
		titleLabel.numberOfLines = 0
		titleView.addSubview(titleLabel)
		titleLabel.activateConstraints(toMarginsOf: titleView)
		
		contentView.addSubview(wrappedView)
		wrappedView.activateConstraints(to: contentView)
		
		let stackView = UIStackView(arrangedSubviews: [titleView, contentView])
		stackView.axis = .vertical
		addSubview(stackView)
		stackView.activateConstraints(to: self)
		
		// Content corners
		titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		titleView.layer.cornerRadius = cornerRadius
		contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
		contentView.layer.cornerRadius = cornerRadius
		
		// Outer border
		layer.borderWidth = 2
		layer.cornerRadius = cornerRadius
		
		// Outer shadow
		layer.shadowOffset = CGSize(width: 0, height: 4)
		layer.shadowOpacity = 0.8
		layer.shadowRadius = 8
		layer.shadowColor = layer.borderColor
	}
	
	public func configure(colorTheme: ColorTheme) {
		layer.borderColor = colorTheme.outerBorder.cgColor
		layer.shadowColor = layer.borderColor
		titleView.backgroundColor = colorTheme.titleBackground
		contentView.backgroundColor = colorTheme.contentBackground
	}
}

extension CardView: ViewModelConfigurable where WrappedView: ViewModelConfigurable {
	
	public typealias ViewModel = CardViewModel<WrappedView>
	
	public func configure(with viewModel: ViewModel) {
		titleLabel.attributedText = viewModel.title
		configure(colorTheme: viewModel.colorTheme)
	}
}
