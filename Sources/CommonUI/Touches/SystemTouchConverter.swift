//
//  SystemTouchConverter.swift
//  FingerPaint
//
//  Created by Noah Emmet on 5/28/17.
//  Copyright © 2017 Sticks. All rights reserved.
//

import Foundation
import UIKit
import Common

public typealias TouchStream = [String: TouchPoint]

public protocol SystemTouchConverterDelegate: class {
    func touchConverter(_ touchConverter: SystemTouchConverter, didBegin newStreams: TouchStream, current: TouchStream, previous: TouchStream)
	func touchConverter(_ touchConverter: SystemTouchConverter, didMove movedStreams: TouchStream, current: TouchStream, previous: TouchStream)
    func touchConverter(_ touchConverter: SystemTouchConverter, didEnd endedStreams: TouchStream, current: TouchStream, previous: TouchStream)
}

public class SystemTouchConverter: SystemTouchableViewDelegate {
	public weak var delegate: SystemTouchConverterDelegate?
    private var current: [String: TouchPoint] = [:]
    
	public init() { }
	
	public static func touchStream(from uiTouches: Set<UITouch>) -> TouchStream {
		let uiTouchArray = Array(uiTouches)
		let touchPointsByAddress: [(String, TouchPoint)] = uiTouchArray.map { ($0.address, TouchPoint($0)) }
		let touchPointsByAddressDict: [String: TouchPoint] = Dictionary(uniqueKeysWithValues: touchPointsByAddress)
		return touchPointsByAddressDict
	}
    
    public func reset() {
        current = [:]
    }
	
	public func touchesBegan(_ touches: Set<UITouch>) {
        let previous = current
		let new = SystemTouchConverter.touchStream(from: touches)
        current = current.merging(new) { p1, p2 in
            assertionFailure("Should never have overlapping touches")
            return p2
        }
        delegate?.touchConverter(self, didBegin: new, current: current, previous: previous)
	}
	
	public func touchesMoved(_ touches: Set<UITouch>) {
        let previous = current
		let moved = SystemTouchConverter.touchStream(from: touches)
        current = current.merging(moved) { p1, p2 in
            return p2
        }
		delegate?.touchConverter(self, didMove: moved, current: current, previous: previous)
	}
	
	public func touchesEnded(_ touches: Set<UITouch>) {
        let previous = current
		let removed = SystemTouchConverter.touchStream(from: touches)
        current = current.subtracting(removed)
		delegate?.touchConverter(self, didEnd: removed, current: current, previous: previous)
	}
}
