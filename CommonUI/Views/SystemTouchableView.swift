//
//  TouchableView.swift
//  FingerPaint
//
//  Created by Noah Emmet on 5/28/17.
//  Copyright © 2017 Sticks. All rights reserved.
//

import Foundation

public protocol SystemTouchableViewDelegate: class {
    func touchesBegan(_ touches: Set<UITouch>)
    func touchesMoved(_ touches: Set<UITouch>)
    func touchesEnded(_ touches: Set<UITouch>)
}

public class SystemTouchableView: UIView {
	public weak var touchDelegate: SystemTouchableViewDelegate?
	
    override public func didMoveToSuperview() {
		isMultipleTouchEnabled = true
	}
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		touchDelegate?.touchesBegan(touches)
	}
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		touchDelegate?.touchesMoved(touches)
	}
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		touchDelegate?.touchesEnded(touches)
	}
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchDelegate?.touchesEnded(touches)
    }
}
