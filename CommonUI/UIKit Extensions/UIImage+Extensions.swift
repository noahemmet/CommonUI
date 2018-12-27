//
//  UIImage+Extensions.swift
//  Views
//
//  Created by Noah Emmet on 5/8/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

extension UIImage {
    public func crop(in rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=self.scale
        rect.origin.y*=self.scale
        rect.size.width*=self.scale
        rect.size.height*=self.scale
        
        guard let imageRef = self.cgImage?.cropping(to: rect) else { return self }
        let image = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
}
