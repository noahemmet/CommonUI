//
//  File.swift
//  
//
//  Created by Noah Emmet on 7/29/19.
//

import UIKit

public class BarButtonItem: UIBarButtonItem {
	public typealias Handler = () -> Void
	private let handler: Handler
	
	public convenience init(title: String, handler: @escaping Handler) {
		self.init(handler: handler)
		self.title = title
	}
	
	public convenience init(image: UIImage, handler: @escaping Handler) {
		self.init(handler: handler)
		self.image = image
	}
	
	private init(handler: @escaping Handler) {
		self.handler = handler
		super.init()
		self.target = self
		self.action = #selector(handle)
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func handle() {
		handler()
	}
}
