//
//  BezeledButton.swift
//  CommonUI
//
//  Created by Noah Emmet on 8/1/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public class BezeledButton: UIView {
    public let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    public let button = Button(frame: .zero)
    public let subButton = UIButton(frame: .zero)
    
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
        subButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
        subButton.setTitleColor(AppStyle.tint, for: .normal)
        subButton.setTitleColor(AppStyle.tintHighlight, for: .highlighted)
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
    
//    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let convertedToButtonTouch = convert(point, to: button)
//        let shouldForwardToButton = (button.point(inside: convertedToButtonTouch, with: event) && button.isUserInteractionEnabled)
//        return shouldForwardToButton
//    }
}
