//
//  DefaultEmptyViewController.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/23/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import Common

extension DefaultEmptyViewController {
    public struct ViewModel {
        public var text: String
        
        public init(text: String = "Empty") {
            self.text = text
        }
    }
}

public class DefaultEmptyViewController: UIViewController, ViewModelConfigurable {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppStyle.emptyScreen
    }
    
    public func configure(with viewModel: ViewModel) {
        
    }
}
