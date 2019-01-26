//
//  Platform.swift
//  CommonUI
//
//  Created by Noah Emmet on 1/25/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation

public enum Platform {
	public static var isSimulator: Bool {
		return TARGET_OS_SIMULATOR != 0
	}
}
