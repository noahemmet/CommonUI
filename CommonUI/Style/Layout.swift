//
//  Layout.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/30/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public enum Layout {
    public static let spacingSmall: CGFloat = 4
    public static let spacing: CGFloat = 8
    public static let spacingMedium: CGFloat = 16
    public static let hMarginInset: CGFloat = spacing
    public static let vMarginInset: CGFloat = spacing
    
    // MARK: - Buttons
    public static let minButtonSize: CGSize = CGSize(dimension: 44)
    public static let minButtonSizeSmallMedium: CGSize = CGSize(dimension: 48)
    public static let minButtonSizeMedium: CGSize = CGSize(dimension: 54)
    
    // MARK: - Cells
    public static let minEstimatedCellHeight: CGFloat = 44
    
    // MARK: Style
    public static let cornerRadiusSmall: CGFloat = 4
    public static let cornerRadiusMedium: CGFloat = 8
    public static let cornerRadiusLarge: CGFloat = 16
}
