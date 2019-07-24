import UIKit
import UIKit.UIGestureRecognizerSubclass

public class ShortTapGestureRecognizer: UITapGestureRecognizer {
	/// Anything below 0.3 may cause doubleTap to be inaccessible by many users
	public var tapMaxDelay: Double = 0.3
	
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
		super.touchesBegan(touches, with: event)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + tapMaxDelay) { [weak self] in
			if self?.state != .recognized {
				self?.state = .failed
			}
		}
	}
}
