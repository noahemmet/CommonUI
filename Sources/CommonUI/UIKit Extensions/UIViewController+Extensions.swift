//
//  UIViewController+Extensions.swift
//  Slash
//
//  Created by Noah Emmet on 3/14/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Storyboards

public protocol ViewControllerStoryboardInstantiatable: class {
  static func fromStoryboard() -> Self
  static func fromStoryboard(using bundle: Bundle) -> Self
}

extension UIViewController: ViewControllerStoryboardInstantiatable {
  public static var storyboardIdentifier: String {
    // Get the name of current class
    let classString = NSStringFromClass(self)
    let components = classString.components(separatedBy: ".")
    assert(!components.isEmpty, "Failed extract class name from \(classString)")
    return components.last!
  }

  public static func fromStoryboard() -> Self {
    let bundle = Bundle(for: self)
    return fromStoryboard(using: bundle)
  }

  public static func fromStoryboard(using bundle: Bundle) -> Self {
    // If this fails, make sure the `.storyboard` is the same name as the view controller.
    let storyboard = UIStoryboard(name: storyboardIdentifier, bundle: bundle)
    return instantiateFromStoryboard(storyboard, type: self)
  }
}

extension UIViewController {
  private class func instantiateFromStoryboard<VC: UIViewController>(
    _ storyboard: UIStoryboard,
    type: VC.Type
  ) -> VC {
    return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! VC
  }
}

extension ViewModelConfigurable where Self: UIViewController {
  public init(viewModel: ViewModel) throws {
    self.init(nibName: nil, bundle: nil)
    self.loadViewIfNeeded()
    try self.tryConfigure(with: viewModel)
  }
}

// MARK: - Convenience

public extension UIViewController {
  enum ChildViewControllerConstraintActivation {
    case view
    case margins
  }

  @discardableResult
  func addChildViewController(
    _ child: UIViewController,
    insets: UIEdgeInsets = .zero,
    horizontal: UIView.AxisConstraint = .view,
    vertical: UIView.AxisConstraint = .view
  ) -> AnchorConstraints {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
    return child.view.activateConstraints(
      to: view,
      insets: insets,
      horizontal: horizontal,
      vertical: vertical
    )
  }

  var pointerStrings: [String] {
    let vcPointerString = String(format: "%p", self)
    let navChildPointerStrings = (self as? UINavigationController)?.viewControllers.flatMap { $0.pointerStrings } ?? []
    let childPointerStrings = children.flatMap { $0.pointerStrings }
    return [vcPointerString] + navChildPointerStrings + childPointerStrings
  }
}
