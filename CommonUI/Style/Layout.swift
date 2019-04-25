//
//  Layout.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/30/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

public enum Layout {
	/// 4
    public static let spacingSmall: CGFloat = 4
	/// 8
    public static let spacing: CGFloat = 8
	/// 16
    public static let spacingMedium: CGFloat = 16
	/// 8 (spacing)
    public static let hMarginInset: CGFloat = spacing
	/// 8 (spacing)
    public static let vMarginInset: CGFloat = spacing
    
    // MARK: - Buttons
	/// 44
    public static let minButtonSize: CGSize = CGSize(dimension: 44)
	/// 48
    public static let minButtonSizeSmallMedium: CGSize = CGSize(dimension: 48)
	/// 54
    public static let minButtonSizeMedium: CGSize = CGSize(dimension: 54)
    
    // MARK: - Cells
	/// 44
    public static let minEstimatedCellHeight: CGFloat = 44
	
	// MARK: - Borders
	/// 1
	public static let borderSmall: CGFloat = 1
	/// 2
	public static let borderMedium: CGFloat = 2
	/// 6
	public static let borderLarge: CGFloat = 6
    
    // MARK: — Corners
	/// 4
    public static let cornerRadiusSmall: CGFloat = 4
	/// 8
    public static let cornerRadiusMedium: CGFloat = 8
	/// 16
    public static let cornerRadiusLarge: CGFloat = 16
}
