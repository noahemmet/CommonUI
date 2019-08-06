//
//  DebugNav.swift
//  CommonUI
//
//  Created by Noah Emmet on 1/25/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation
import UIKit

public enum DebugNav {
	public static func go(after delay: TimeInterval = 0, _ handler: @escaping () -> Void) {
		#if DEBUG
		if Platform.isSimulator {
			DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
				handler()
			}
		}
		#endif
	}
}
