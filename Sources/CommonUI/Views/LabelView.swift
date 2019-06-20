//
//  LabelView.swift
//  CommonUI
//
//  Created by Noah Emmet on 8/1/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public class LabelView: UIView, ViewModelConfigurable {
    
    public struct ViewModel {
        public let text: String
        public let textColor: UIColor
        public let font: UIFont

        public init(text: String, textColor: UIColor = AppStyle.primaryText, font: UIFont = UIFont.preferredFont(forTextStyle: .body)) {
            self.text = text
            self.textColor = textColor
            self.font = font
        }
        
    }
    
    public let label: UILabel = .init(frame: .zero)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
//        label.backgroundColor = .yellow
//        backgroundColor = .red
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        addSubview(label)
        label.activateConstraints(toMarginsOf: self)
    }
    
    public func configure(with viewModel: LabelView.ViewModel) {
        label.text = viewModel.text
        label.textColor = viewModel.textColor
        label.font = viewModel.font
        label.setNeedsUpdateConstraints()
        label.updateConstraintsIfNeeded()
//        label.preservesSuperviewLayoutMargins = false
        
//        label.preferredMaxLayoutWidth = frame.width
//        label.sizeToFit()
//        label.setNeedsUpdateConstraints()
//        label.updateConstraintsIfNeeded()
    }
}
