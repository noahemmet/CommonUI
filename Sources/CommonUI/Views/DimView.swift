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
	
	public var cutoutView: UIView?
	public var cutoutFrame: CGRect? {
		
		didSet {
			if let cutoutFrame = cutoutFrame {
				let cutoutView = self.cutoutView ?? UIView(frame: .zero)
				cutoutView.backgroundColor = .black
				cutoutView.frame = cutoutFrame
				self.cutoutView = cutoutView
			} else {
				cutoutView = nil
			}
			self.mask = cutoutView
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
