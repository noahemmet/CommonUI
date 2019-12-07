import UIKit

public extension UIUserInterfaceStyle {
  mutating func toggle() {
    switch self {
    case .light, .unspecified:
      self = .dark
    case .dark:
      fallthrough
    @unknown default:
      self = .light
    }
  }
}
