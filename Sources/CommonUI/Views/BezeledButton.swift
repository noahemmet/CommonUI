//
//  BezeledButton.swift
//  CommonUI
//
//  Created by Noah Emmet on 8/1/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

public final class BezeledButton: UIView {
	public let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
	public let button = Button(frame: .zero)
	public let subButton = UIButton(frame: .zero)
	private var action: (() -> Void)?
	
	convenience public init(title: String, action: @escaping () -> Void) {
		self.init(frame: .zero)
		self.action = action
		button.setTitle(title, for: .normal)
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	func commonInit() {
		addTopBorder()
		
		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
		button.addTarget(self, action: #selector(handleAction), for: .primaryActionTriggered)
		
		subButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
		subButton.setTitleColor(AppStyle.primaryText, for: .normal)
		subButton.setTitleColor(AppStyle.secondaryText, for: .highlighted)
		subButton.isHidden = true
		
		blurView.setContentCompressionResistancePriority(.required, for: .vertical)
		blurView.setContentCompressionResistancePriority(.required, for: .horizontal)
		blurView.setContentHuggingPriority(.required, for: .vertical)
		blurView.setContentHuggingPriority(.required, for: .horizontal)
		addSubview(blurView)
		blurView.activateConstraints(to: self)
		
		let stackView = UIStackView(arrangedSubviews: [button, subButton])
		stackView.axis = .vertical
		stackView.distribution = .fill//Proportionally
		blurView.contentView.addSubview(stackView)
		stackView.activateConstraints(toMarginsOf: blurView)
	}
	
	@objc
	private func handleAction() {
		self.action?()
	}
	
	//    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
	//        let convertedToButtonTouch = convert(point, to: button)
	//        let shouldForwardToButton = (button.point(inside: convertedToButtonTouch, with: event) && button.isUserInteractionEnabled)
	//        return shouldForwardToButton
	//    }
}

extension BezeledButton: UIViewRepresentable {
	
	public func makeUIView(context: Context) -> BezeledButton {
		return BezeledButton(frame: .zero)
	}
	
	public func updateUIView(_ uiView: BezeledButton, context: Context) {
		context.coordinator
	}
	
	
}
