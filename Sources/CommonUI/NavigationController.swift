//
//  NavigationController.swift
//  CommonUI
//
//  Created by Noah Emmet on 7/1/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

/// Includes a `UIPercentDrivenInteractiveTransition` for popping/pushing. 
public class NavigationController: UINavigationController {
	
	/// Whether a user can slide left to pop a view controller
	public var isSlideToPopEnabled = true {
		didSet {
			panRecognizer.isEnabled = isSlideToPopEnabled
			if !isSlideToPopEnabled {
				interactivePopTransition?.cancel()
			}
		}
	}
	
    private var interactivePopTransition: UIPercentDrivenInteractiveTransition?
	private var panRecognizer: UIPanGestureRecognizer!
	
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panRecognizer)
    }
	
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        // Calculate how far the user has dragged across the view
        var progress = recognizer.translation(in: view).x / view.bounds.size.width
        progress = min(1, max(0, progress))
        let xVelocity = recognizer.velocity(in: view).x
		
        switch recognizer.state {
        case .began:
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            _ = self.popViewController(animated: true)
			
        case .changed:
            interactivePopTransition?.update(progress)
			
        case .ended, .cancelled:
            if progress > 0.5 || xVelocity > 100 {
                // slow down the non-interaction completed animation
                interactivePopTransition?.completionSpeed = 0.5
                interactivePopTransition?.finish()
            } else {
                // slow down the non-interaction cancel animation
                interactivePopTransition?.completionSpeed = 0.35 * (progress * 5)
                interactivePopTransition?.cancel()
            }
            interactivePopTransition = nil
			
        default:
            break
        }
    }
	
	/// Works in conjunction with UIViewController.isSlideToPopEnabled
	private var perViewControllerPopSlideToggles: [String: Bool] = [:]
	func setPopSlide(to enabled: Bool, for viewController: UIViewController) {
		let vcPointerString = String(format: "%p", viewController)
		perViewControllerPopSlideToggles[vcPointerString] = enabled
		
	}
	
	func popSlide(for viewController: UIViewController) -> Bool? {
		let vcPointerString = String(format: "%p", viewController)
		let enabled = perViewControllerPopSlideToggles[vcPointerString]
		return enabled
	}
	
	public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		let vcPointerString = String(format: "%p", viewController)
		if let popSlideToggle = perViewControllerPopSlideToggles[vcPointerString] {
			isSlideToPopEnabled = popSlideToggle
		} else {
			isSlideToPopEnabled = true // this will be a problem if you *never* want to slide pop
		}
	}
}

extension NavigationController: UINavigationControllerDelegate {
	
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .none, .push:
            return nil
        case .pop:
            if interactivePopTransition == nil {
                return nil
            } else {
                return SlidingPopTransition()
            }
        }
    }
	
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController is SlidingPopTransition {
            return interactivePopTransition
        } else {
            return nil
        }
    }
}

class SlidingPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
	
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Animation.defaultDuration
    }
	
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
		
        let containerView = transitionContext.containerView
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
		
        // Setup the initial view states
        var initialToFrame = fromViewController.view.frame
        initialToFrame.origin.x = -100
        initialToFrame.origin.y = toViewController.view.frame.origin.y
        toViewController.view.frame = initialToFrame
		
        let dimmingView = UIView(frame: CGRect(x: 0,y: 0, width: toViewController.view.frame.width, height: toViewController.view.frame.height))
        dimmingView.backgroundColor = UIColor.black
        dimmingView.alpha = 0.3
        toViewController.view.addSubview(dimmingView)
		
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveLinear,
            animations: {
                dimmingView.alpha = 0
                toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
                fromViewController.view.frame = CGRect(x: toViewController.view.frame.size.width, y: fromViewController.view.frame.origin.y, width: fromViewController.view.frame.size.width, height: fromViewController.view.frame.size.height)
        }, completion: { finished in
            dimmingView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
