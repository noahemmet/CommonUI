//
//  DimView.swift
//
//  Created by Noah Emmet on 12/15/16.
//  Copyright © 2016 Sticks. All rights reserved.
//

import UIKit

public class DimView: UIView {
	public let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
	public var onTap: (_:(DimView) -> Void)?
	
//	public var cutoutView: UIView?
	public var cutoutFrame: CGRect? {
		
		didSet {
			
			if let cutoutFrame = cutoutFrame {
				self.mask(rect: cutoutFrame, invert: false)
			} else {
				self.layer.mask = nil
			}
		}
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	private func setup() {
		backgroundColor = UIColor(white: 0.0, alpha: 0.4) // mimic the default dimmingviews as close as possible
		addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc
	private func handleTap(_: UITapGestureRecognizer) {
		onTap?(self)
	}
}
