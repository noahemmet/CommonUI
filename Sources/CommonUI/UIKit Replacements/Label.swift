//
//  Label.swift
//  Views
//
//  Created by Noah Emmet on 7/24/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit
import UIKit

public class Label: UILabel {
    
    public var textInsets: UIEdgeInsets = .zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let inverted = textInsets.inverted
        let final = textRect.inset(by: inverted)
        return final
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
