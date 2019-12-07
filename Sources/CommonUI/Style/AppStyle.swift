//
//  Color.swift
//  Views
//
//  Created by Noah Emmet on 4/5/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

public enum AppStyle {
  public static var tint = UIColor() { traitCollection in
    switch traitCollection.userInterfaceStyle {
    case .dark:
      return #colorLiteral(red: 0.8331652398, green: 0.4039638253, blue: 0.3784723405, alpha: 1)
    case .light, .unspecified:
      fallthrough
    @unknown default:
      return #colorLiteral(red: 0.8167913732, green: 0.2771992187, blue: 0.3378234171, alpha: 1)
    }
  }

  public static var tintHighlight = UIColor() { traitCollection in
    switch traitCollection.userInterfaceStyle {
    case .dark:
      return #colorLiteral(red: 0.8331652398, green: 0.2827561127, blue: 0.3445956183, alpha: 1)
    case .light, .unspecified:
      fallthrough
    @unknown default:
      return #colorLiteral(red: 0.8167913732, green: 0.2771992187, blue: 0.3378234171, alpha: 1)
    }
  }

  public static let border = UIColor.separator
  public static let highlight = UIColor.systemGray
  public static let background = UIColor.systemBackground
  public static let background2 = UIColor.secondarySystemBackground
  public static let placeholderText = UIColor.placeholderText
  public static let primaryText = UIColor.label
  public static let secondaryText = UIColor.secondaryLabel

  public static let emptyScreen = #colorLiteral(red: 0.8974830419, green: 0.8710281861, blue: 0.956780246, alpha: 1)

  public static let emptyPersona = #colorLiteral(red: 0.711852964, green: 0.6482803742, blue: 0.956780246, alpha: 1)
}
