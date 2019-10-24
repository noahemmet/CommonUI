import Foundation
import UIKit

public extension UINavigationController {
  func pushNewStack(startingWith viewController: UIViewController, animated: Bool) {
    let rootViewController = viewControllers[0]
    setViewControllers([rootViewController, viewController], animated: animated)
  }
}

public extension UIViewController {
  func setPopSlideEnabled(_ enabled: Bool) {
    guard let navController = navigationController as? NavigationController else {
      fatalError("navigationController superclass must be of type NavigationController")
    }
    navController.setPopSlide(to: enabled, for: self)
  }
}
