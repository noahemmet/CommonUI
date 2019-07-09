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
	public static let tint = UIColor() { traitCollection in
		switch traitCollection.userInterfaceStyle {
		case .dark:
			return #colorLiteral(red: 0.8167913732, green: 0.5466325331, blue: 0.7697020156, alpha: 1)
		case .light, .unspecified:
			fallthrough
		@unknown default:
			return #colorLiteral(red: 0.6029995142, green: 0.3311645284, blue: 0.5556180002, alpha: 1)
		}
	}
	
	public static let tintHighlight = UIColor() { traitCollection in
		switch traitCollection.userInterfaceStyle {
		case .dark:
			return #colorLiteral(red: 0.6923140405, green: 0.4633268544, blue: 0.6524010045, alpha: 1)
		case .light, .unspecified:
			fallthrough
		@unknown default:
			return #colorLiteral(red: 0.5, green: 0.2745976743, blue: 0.4607118141, alpha: 1)
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
