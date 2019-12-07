//
//  CardViewController.swift
//  CommonUI
//
//  Created by Noah Emmet on 2/3/19.
//  Copyright © 2019 Noah Emmet. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CardViewController

public class CardViewController<WrappedViewController: UIViewController, ContentView>: UIViewController
  //, ViewModelConfigurable
  where WrappedViewController: ViewModelConfigurable,
  ContentView: UIView
//	ContentView: ViewModelConfigurable,
//	WrappedViewController.ViewModel == ContentView.ViewModel
{
  public typealias ViewModel = WrappedViewController.ViewModel

  public let wrappedViewController: WrappedViewController
  public let cardView: CardView<ContentView>

  public init(wrapping wrappedViewController: WrappedViewController) {
    self.wrappedViewController = wrappedViewController
    self.cardView = CardView<ContentView>(wrapping: wrappedViewController.view as! ContentView)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(cardView)
    cardView.activateConstraints(to: view)
  }
}

//extension CardViewController: ViewModelConfigurable
//	where WrappedViewController: ViewModelConfigurable,
//	ContentView: ViewModelConfigurable,
//	WrappedViewController.ViewModel == ContentView.ViewModel
//{
//
//	public func configure(with viewModel: ViewModel) {
//		cardView.configure(with: viewModel as! CardView<ContentView>.ViewModel)
//	}
//}
