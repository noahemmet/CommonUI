//
//  TouchManager.swift
//  FingerPaint
//
//  Created by Noah Emmet on 5/17/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit
import Common

public protocol TouchManagerDelegate: class {
  func touchManager(_ touchManager: TouchManager, didAddNewTouchPoints touchPoints: [TouchPoint])
  func touchManager(_ touchManager: TouchManager, didFinishTouchPoints touchPoints: [TouchPoint])
}

public class TouchManager {
  public enum TouchType {
    case freeform
    case straight
  }
  
  public unowned var view: SystemTouchableView
  public weak var delegate: TouchManagerDelegate?
  public var touchType: TouchType = .freeform {
    didSet {
      currentTouchPoints = []
      systemTouchConverter.reset()
    }
  }
  private var currentTouchPoints: [TouchPoint] = []
  private let systemTouchConverter = SystemTouchConverter()
  
  public init(view: SystemTouchableView) { 
    self.view = view
    systemTouchConverter.delegate = self
    view.touchDelegate = systemTouchConverter
  }
  
  func handleNewStream(_ newStream: TouchStream) {
    currentTouchPoints = newStream.map { $0.value }
    delegate?.touchManager(self, didAddNewTouchPoints: currentTouchPoints)
  }
  
  func handleMovedStream(_ movedStream: TouchStream) {
    currentTouchPoints = movedStream.map { $0.value }
    delegate?.touchManager(self, didAddNewTouchPoints: currentTouchPoints)
  }
  
  func handleEndedStreams(_ endedStream: TouchStream) {
    let currentTouchPoints = endedStream.map { $0.value }
    delegate?.touchManager(self, didAddNewTouchPoints: currentTouchPoints)
    delegate?.touchManager(self, didFinishTouchPoints: currentTouchPoints)
  }
}

extension TouchManager: SystemTouchConverterDelegate {
  public func touchConverter(_ touchConverter: SystemTouchConverter, didBegin newStreams: TouchStream, current: TouchStream, previous: TouchStream) {
    assert(newStreams.count > 0)
    assert(current.count > 0)
    handleNewStream(newStreams)
  }
  
  public func touchConverter(_ touchConverter: SystemTouchConverter, didMove movedStreams: TouchStream, current: TouchStream, previous: TouchStream) {
    assert(movedStreams.count > 0)
    assert(current.count > 0)
    handleMovedStream(movedStreams)
  }
  
  public func touchConverter(_ touchConverter: SystemTouchConverter, didEnd endedStreams: TouchStream, current: TouchStream, previous: TouchStream) {
    assert(endedStreams.count > 0)
    //        assert(current.count > 0)
    handleEndedStreams(current)
  }
}
