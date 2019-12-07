//
//  TouchableView.swift
//  FingerPaint
//
//  Created by Noah Emmet on 5/28/17.
//  Copyright © 2017 Sticks. All rights reserved.
//

import Foundation
import UIKit

public protocol SystemTouchableViewDelegate: class {
  func touchesBegan(_ touches: Set<UITouch>)
  func touchesMoved(_ touches: Set<UITouch>)
  func touchesEnded(_ touches: Set<UITouch>)
}

public class SystemTouchableView: UIView {
  public weak var touchDelegate: SystemTouchableViewDelegate?

  public override func didMoveToSuperview() {
    isMultipleTouchEnabled = true
  }

  public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchDelegate?.touchesBegan(touches)
  }

  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchDelegate?.touchesMoved(touches)
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchDelegate?.touchesEnded(touches)
  }

  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchDelegate?.touchesEnded(touches)
  }
}
