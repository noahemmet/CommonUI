//
//  Animation.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/22/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public enum Animation {
	/// 0.3 seconds
    public static let defaultDuration: TimeInterval = 0.3
	/// 0.15 seconds
    public static let shortDuration: TimeInterval = 0.15
	/// 0.15 seconds
    public static let deselectionDelay: TimeInterval = 0.15
    
    /// The amount of time to elapse between presenting a view controller and loading its transition screen.
	/// 0.01 seconds
    public static let minLoadViewAppearAnimation: TimeInterval = 0.01
    /// Returns true if a load has taken longer than `minLoadViewAppearAnimation`.
    public static func shouldAnimateAfterLoad(since start: Date) -> Bool {
        let delta = Date().timeIntervalSince(start)
        let shouldAnimate = delta > self.minLoadViewAppearAnimation
        return shouldAnimate
    }
}

extension Animation {
	/// 0.4 seconds
    public static let minimumDelay: TimeInterval = 0.4
    public static func afterMinimumDelay(_ delay: TimeInterval = minimumDelay, handler: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: handler)
    }
}

extension UIView {
    public static func spring(delay: TimeInterval = 0, animations: @escaping () -> Void) {
        UIView.animate(withDuration: Animation.defaultDuration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 0.4, options: [], animations: animations, completion: nil)
    }
    
    public func bounceScale(to scale: CGFloat, duration: TimeInterval? = nil, dampingRatio: CGFloat = 3, firstAnimation: (() -> Void)? = nil, secondAnimation: (() -> Void)? = nil) {
        let duration = duration ?? Animation.defaultDuration
        guard duration > 0 else {
            firstAnimation?()
            secondAnimation?()
            return
        }
        let firstAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) { 
            self.transform = self.transform.scaledBy(x: scale, y: scale)
            firstAnimation?()
        }
        firstAnimator.addCompletion { _ in
            let secondAnimator = UIViewPropertyAnimator(duration: duration*2, dampingRatio: dampingRatio) { 
                self.transform = .identity
                secondAnimation?()
            }
            secondAnimator.startAnimation()
        }
        firstAnimator.startAnimation()
    }
}
