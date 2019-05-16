//
//  Env.swift
//  CommonUI
//
//  Created by Noah Emmet on 4/30/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation

public enum Env {
	private static let flip: Bool = true
	public static let v1: Bool = !flip
	public static let v2: Bool = flip
}
