//
//  AutoLayout+Extensions.swift
//  Views
//
//  Created by Noah Emmet on 2/10/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public typealias AnchorConstraints = (leading: NSLayoutConstraint, trailing: NSLayoutConstraint, top: NSLayoutConstraint, bottom: NSLayoutConstraint)

public extension UIView {
    
    enum AxisConstraint {
        case view
        case margins
        case safe
    }
    
    @discardableResult
	func anchorConstraints(to view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
		return ( 
            leading: self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailing: self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
            top: self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottom: self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        )
	}
	
    @discardableResult 
    func activateConstraints(to view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let anchorConstraints = self.anchorConstraints(to: view, insets: insets)
        NSLayoutConstraint.activate(anchorConstraints)
        return anchorConstraints
	}
	
    @discardableResult
    func constraints(to view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        return (
            leading: self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailing: self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
            top: self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottom: self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        )
    }
    
    @discardableResult
    func constraints(toMarginsOf view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        return (
            leading: self.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: insets.left),
            trailing: self.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: insets.right),
            top: self.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: insets.top),
            bottom: self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: insets.bottom)
            )
	}
	
    @discardableResult
    func constraints(toSafeAreaOf view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        return (
            leading: self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            trailing: self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: insets.right),
            top: self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            bottom: self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom)
        )
    }
	
    @discardableResult
    func constraints(toReadableContentOf view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
		let guide = view.readableContentGuide
        return (
            leading: self.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: insets.left),
            trailing: self.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: insets.right),
            top: self.topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top),
            bottom: self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: insets.bottom)
        )
    }
	
    @discardableResult
	func activateConstraints(toMarginsOf view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = self.constraints(toMarginsOf: view, insets: insets)
        NSLayoutConstraint.activate(constraints)
        return constraints
	}
	
    @discardableResult
    func activateConstraints(toSafeAreaOf view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = self.constraints(toSafeAreaOf: view, insets: insets)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
	
    @discardableResult
    func activateConstraints(toReadableContentOf view: UIView, insets: UIEdgeInsets = .zero) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = self.constraints(toReadableContentOf: view, insets: insets)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func activateConstraints(to view: UIView, insets: UIEdgeInsets = .zero, horizontal: AxisConstraint, vertical: AxisConstraint) -> AnchorConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint: NSLayoutConstraint
        let trailingConstraint: NSLayoutConstraint
        let topConstraint: NSLayoutConstraint
        let bottomConstraint: NSLayoutConstraint
        switch horizontal {
        case .view:
            leadingConstraint = self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left)
            trailingConstraint = self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
        case .margins:
            leadingConstraint = self.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: insets.left)
            trailingConstraint = self.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: insets.right)
        case .safe:
            leadingConstraint = self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left)
            trailingConstraint = self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: insets.right)
        }
        switch vertical {
        case .view:
            topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top)
            bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        case .margins:
            topConstraint = self.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: insets.top)
            bottomConstraint = self.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: insets.bottom)
        case .safe:
            topConstraint = self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.left)
            bottomConstraint = self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: insets.right)
        }
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        return (leading: leadingConstraint, trailing: trailingConstraint, top: topConstraint, bottom: bottomConstraint)
    }
	
	func constraints(ofSize size: CGSize) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
		return [
			self.heightAnchor.constraint(equalToConstant: size.height),
			self.widthAnchor.constraint(equalToConstant: size.width)
		]
	}
	
	func activateConstraints(ofSize size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(constraints(ofSize: size))
	}
}

public extension NSLayoutConstraint {
    static func activate(_ anchorConstraints: AnchorConstraints) {
        let constraints = self.constraints(for: anchorConstraints)
        activate(constraints)
    }
    
    static func constraints(for anchorConstraints: AnchorConstraints) -> [NSLayoutConstraint] {
        return [anchorConstraints.leading, anchorConstraints.trailing, anchorConstraints.top, anchorConstraints.bottom]
    }
	
	@discardableResult
	func activate() -> NSLayoutConstraint {
		self.isActive = true
		return self
	}
}
