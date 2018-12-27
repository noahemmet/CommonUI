//
//  ViewStateController.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/23/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import Common

// MARK: - ViewStateController

open class ViewStateController<
    SuccessViewController: ViewControllerModelConfigurable,
    FailureViewController: ViewControllerErrorModelConfigurable,
    LoadingViewController: ViewControllerModelConfigurable,
    EmptyViewController: ViewControllerModelConfigurable>
    : UIViewController
{
    
    // MARK: Typealiases
    
    //    public typealias ViewModelProviderType = ViewModelProvider
    public typealias SuccessViewModel = SuccessViewController.ViewModel
    public typealias FailureViewModel = FailureViewController.ViewModel
    public typealias LoadingViewModel = LoadingViewController.ViewModel
    public typealias EmptyViewModel = EmptyViewController.ViewModel
    public typealias ControllerViewState = ViewState<SuccessViewModel, FailureViewModel, LoadingViewModel, EmptyViewModel>
    
    // MARK: ViewState
    
    public private(set) var viewState: ControllerViewState
    
    // MARK: ViewControllers
    
    private var currentViewController: UIViewController!
    public weak var successViewController: SuccessViewController?
    public weak var failureViewController: FailureViewController?
    public weak var loadingViewController: LoadingViewController?
    public weak var emptyViewController: EmptyViewController?
    
    // MARK: ViewControllerDidLoad Closures
    
    public typealias ViewControllerDidLoad<ViewController: UIViewController & ViewModelConfigurable> = (ViewController) -> Void
    public var successViewControllerDidLoad: ViewControllerDidLoad<SuccessViewController>?
    public var failureViewControllerDidLoad: ViewControllerDidLoad<FailureViewController>?
    public var loadingViewControllerDidLoad: ViewControllerDidLoad<LoadingViewController>?
    public var emptyViewControllerDidLoad: ViewControllerDidLoad<EmptyViewController>?
    
    // MARK: Inits
    
    public init(initialViewState: ControllerViewState) {
        self.viewState = initialViewState
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(loadingViewModel: LoadingViewModel) {
        self.init(initialViewState: .loading(loadingViewModel))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIViewController Overrides
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        transition(to: viewState, from: nil, animated: false, completion: nil)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        load(with: , animated: animated, completion: nil)
    }
    
    // MARK: Functions
    public typealias LoadCompletion = (ControllerViewState) -> Void
    //    open func load(with query: Query, animated: Bool, completion: LoadCompletion?) {
    //        let previousViewState = self.viewState
    //        let startTime = Date()
    //        self.client.fetch(query: query) { (result) in
    //            let delta = Date().timeIntervalSince(startTime)
    //            let shouldAnimate = delta > 0.1
    // animation is always true, since this is asyncronous
    //            fatalError("Need place to translate view state from client/query")
    //            self?.transition(to: newViewState, from: previousViewState, animated: true, completion: completion)
    //        }
    //    }
    
    // MARK: - GetViewControllers
    
    /// Override to get view controller from a separate source, such as a storyboard.
    open func getSuccessViewController() -> SuccessViewController {
        guard let successViewController = self.successViewController else {
            let successViewController = SuccessViewController(nibName: nil, bundle: nil)
            self.successViewController = successViewController
            return successViewController
        }
        return successViewController
    }
    
    /// Override to get view controller from a separate source, such as a storyboard.
    open func getFailureViewController() -> FailureViewController {
        guard let failureViewController = self.failureViewController else {
            let failureViewController = FailureViewController(nibName: nil, bundle: nil)
            self.failureViewController = failureViewController
            return failureViewController
        }
        return failureViewController
    }
    
    /// Override to get view controller from a separate source, such as a storyboard.
    open func getLoadingViewController() -> LoadingViewController {
        guard let loadingViewController = self.loadingViewController else {
            let loadingViewController = LoadingViewController(nibName: nil, bundle: nil)
            self.loadingViewController = loadingViewController
            return loadingViewController
        }
        return loadingViewController
    }
    
    /// Override to get view controller from a separate source, such as a storyboard.
    open func getEmptyViewController() -> EmptyViewController {
        guard let emptyViewController = self.emptyViewController else {
            let emptyViewController = EmptyViewController(nibName: nil, bundle: nil)
            self.emptyViewController = emptyViewController
            return emptyViewController
        }
        return emptyViewController
    }
    
    open func configure(successViewController viewController: SuccessViewController, with viewModel: SuccessViewController.ViewModel) {
        viewController.configure(with: viewModel)
    }
    
    open func configure(failureViewController viewController: FailureViewController, with viewModel: FailureViewController.ViewModel) {
        viewController.configure(with: viewModel)
    }
    
    open func configure(emptyViewController viewController: EmptyViewController, with viewModel: EmptyViewController.ViewModel) {
        viewController.configure(with: viewModel)
    }
    
    open func configure(loadingViewController viewController: LoadingViewController, with viewModel: LoadingViewController.ViewModel) {
        viewController.configure(with: viewModel)
    }
    
    private func viewController(for viewState: ControllerViewState) -> UIViewController {
        switch viewState {
        case .success(let viewModel):
            let viewController = self.getSuccessViewController()
            viewController.loadViewIfNeeded()
            successViewControllerDidLoad?(viewController)
            configure(successViewController: viewController, with: viewModel)
            return viewController
        case .failure(let viewModel):
            let viewController = self.getFailureViewController()
            viewController.loadViewIfNeeded()
            failureViewControllerDidLoad?(viewController)
            configure(failureViewController: viewController, with: viewModel)
            return viewController
        case .empty(let viewModel):
            let viewController = self.getEmptyViewController()
            viewController.loadViewIfNeeded()
            emptyViewControllerDidLoad?(viewController)
            configure(emptyViewController: viewController, with: viewModel)
            return viewController
        case .loading(let viewModel):
            let viewController = getLoadingViewController()
            viewController.loadViewIfNeeded()
            loadingViewControllerDidLoad?(viewController)
            configure(loadingViewController: viewController, with: viewModel)
            return viewController
        }
    }
    
    // MARK: - Transitions
    
    open func willTransition(to toViewController: UIViewController, from fromViewController: UIViewController?, animated: Bool) {
        // Override
    }
    
    open func didTransition(to toViewController: UIViewController, from fromViewController: UIViewController?, animated: Bool) {
        // Override
    }
    
    open func transition(to toViewState: ControllerViewState, from fromViewState: ControllerViewState?, animated: Bool, completion: ((ControllerViewState) -> Void)?) {
        
        // Add newViewController to self and configure view
        let oldViewController = currentViewController
        let newViewController = self.viewController(for: toViewState)
        guard oldViewController != newViewController else {
            // This can happen when cancelling an interactive drag, or when refreshing an active screen.
            completion?(toViewState)
            return
        }
        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
        newViewController.view.alpha = 0
        view.backgroundColor = newViewController.view.backgroundColor
        currentViewController = newViewController
        oldViewController?.willMove(toParent: nil)
        addChild(newViewController)
        view.addSubview(newViewController.view)
        newViewController.didMove(toParent: self)
        newViewController.view.activateConstraints(to: self.view)
        
        // Subclassers can override this function
        willTransition(to: newViewController, from: oldViewController, animated: animated)
        
        // Animate fade transition
        let duration: TimeInterval = animated ? Animation.shortDuration : 0
        UIView.animate(withDuration: duration, animations: { 
            newViewController.view.alpha = 1
            oldViewController?.view.alpha = 0
            
        }) { (finished) in
            // Remove oldViewController from self
            oldViewController?.view.removeFromSuperview()
            oldViewController?.removeFromParent()
            completion?(toViewState)
            // Subclassers can override this function
            self.didTransition(to: newViewController, from: oldViewController, animated: animated)
        }
    }
}

// MARK: - CustomSuccessViewStateController


/// A typealias for `ViewStateController`, generic over a `SuccessViewController`, with `DefaultFooViewController` defaults for the rest. 
//public typealias CustomSuccessViewStateController<SuccessViewController: ViewControllerModelConfigurable> = ViewStateController<CustomSuccessViewModelProvider<SuccessViewController.ViewModel>, DefaultLoadingViewController, DefaultEmptyViewController, SuccessViewController, DefaultFailureViewController>


// MARK: - Defaults

extension ViewStateController where LoadingViewController: DefaultLoadingViewController {
//    public convenience init() {
//        let loadingViewState: ViewStateController.ControllerViewState = .loading(DefaultLoadingViewController.ViewModel())
//        self.init(initialViewState: loadingViewState)
//    }
}
//
//extension ViewStateController2: DefaultFailureViewControllerDelegate {
//    public func defaultFailureViewController(_ defaultFailureViewController: DefaultFailureViewController, didTapReloadButton reloadButton: UIButton) {
//        
//        self.load(animated: true, completion: nil)
//    }
//}
