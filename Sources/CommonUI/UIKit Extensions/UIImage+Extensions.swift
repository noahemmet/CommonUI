//
//  UIImage+Extensions.swift
//  Views
//
//  Created by Noah Emmet on 5/8/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import UIKit

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
	
	public func scaled(to newSize: CGSize) -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: newSize)
		let image = renderer.image { _ in
			self.draw(in: CGRect(origin: .zero, size: newSize))
		}
		return image
	}
}
