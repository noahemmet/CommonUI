//
//  UIBezier+Extensions.swift
//  FingerPaint
//
//  Created by Noah Emmet on 5/28/17.
//  Copyright © 2017 Sticks. All rights reserved.
//

import UIKit
import Common

public extension UIBezierPath {
//    convenience init?(lineFragment: LineFragment) {
//        switch lineFragment {
//        case .free(let touchPoints):
//            let points = touchPoints.map { $0.center }
//            let path = Path(catmullRomPoints: points, closed: false, alpha: 1)
//            self.init(cgPath: path.toCGPath())
//        case .straight(let lines):
//            let linePoints = lines.map { ($0.center, $1.center) }
//            let mostRecent = linePoints.last!
//            let points = [mostRecent.0, mostRecent.1]
//            let path = Path(catmullRomPoints: points, closed: false, alpha: 1)
//            self.init(cgPath: path.toCGPath())
//        case .finished:
//            return nil
//        }
//    }
    
    enum CodingError: Error {
        case unknown
    }
    
    func data() throws -> Data {
        let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        return data
    }
    
    static func from(data: Data) throws -> UIBezierPath {
        let bezierPath = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIBezierPath.self, from: data).unwrap(orThrow: ThrownError(CodingError.unknown))
        return bezierPath
    }
    
    
    class func random(in frame: CGRect, curves curveRange: Range<Int>) -> UIBezierPath {
        let bezier = UIBezierPath()
        let firstPoint = CGPoint.random(in: frame)
        bezier.move(to: firstPoint)
        
        let numCurves = Int.random(in: curveRange)
        for _ in 0 ..< numCurves {
            bezier.addQuadCurve(to: CGPoint.random(in: frame), controlPoint: CGPoint.random(in: frame))
        }
        return bezier
    }
    
//    func appendTouchEvent(_ touchEvent: TouchEvent) {
//        switch touchEvent {
//        case .initial(let current):
//            break
//        case .additional(let current):
//            break
//        case .moved(let current):
//            break
//        case .removed(let current):
//            break
//        case .finished:
//            break
//        }
//    }
//    convenience init?(drawEvent: DrawEvent) {
//        switch drawEvent {
//        case .none:
//            return nil
//        case .free(let touchPoints):
//            let points = touchPoints.map { $0.center }
//            self.init(catmullRomPoints: points, closed: false, alpha: 1.0)
//        case .straightLine(let touchPoints):
//            guard touchPoints.count >= 2 else {
//                return nil
//            }
//            let points = touchPoints.map { $0.center }
//            
//            let bezierPath = UIBezierPath()
//            bezierPath.move(to: points[0])
//            for point in points.dropFirst() {
//                bezierPath.addLine(to: point)
//            }
//            self.init(cgPath: bezierPath.cgPath)
////        case .mixed(let events):
////            let firstPath = UIBezierPath(drawEvent: events[0])!
////            let bezierPaths: [UIBezierPath] = events.flatMap { UIBezierPath(drawEvent: $0) }
////            for path in bezierPaths {
////                firstPath.append(path)
////            }
////            self.init(cgPath: firstPath.cgPath)
//        }
//    }
}
