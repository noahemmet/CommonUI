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
	public static func go(_ handler: @escaping () -> Void) {
		#if DEBUG
		if Platform.isSimulator {
			DispatchQueue.main.async {
				handler()
			}
		}
		#endif
	}
}
