import Foundation
import UIKit
import Common

// MARK: - ViewStateController

/// Manages the display and transitioning of view controllers based on a generic `ViewState` enum.
open class ViewStateController<
  SuccessViewController: ViewControllerModelConfigurable,
  FailureViewController: ViewControllerErrorModelConfigurable,
  LoadingViewController: ViewControllerModelConfigurable,
  EmptyViewController: ViewControllerModelConfigurable
>
  : UIViewController
{
  // MARK: Typealiases
  
  public typealias SuccessViewModel = SuccessViewController.ViewModel
  public typealias FailureViewModel = FailureViewController.ViewModel
  public typealias LoadingViewModel = LoadingViewController.ViewModel
  public typealias EmptyViewModel = EmptyViewController.ViewModel
  public typealias ControllerViewState = ViewState<
    SuccessViewModel,
    FailureViewModel,
    LoadingViewModel,
    EmptyViewModel
  >
  
  /// An enum of possible view controllers 
  public enum ViewController {
    case success(SuccessViewController)
    case failure(FailureViewController)
    case loading(LoadingViewController)
    case empty(EmptyViewController)
    
    /// Returns the associated value as a `UIViewController`.
    public var uiViewController: UIViewController {
      switch self {
      case .success(let successViewController): return successViewController
      case .failure(let failureViewController): return failureViewController
      case .loading(let loadingViewController): return loadingViewController
      case .empty(let emptyViewController): return emptyViewController
      }
    }
  }
  
  // MARK: ViewState
  
  public private(set) var viewState: ControllerViewState {
    didSet {
      self.viewStateDidChange()
    }
  }
  
  /// Subclassers can override.
  open func viewStateDidChange() {}
  
  
  // MARK: ViewControllers
  
  /// The currently displayed view controller
  private weak var currentViewController: UIViewController!
  public var successViewController: SuccessViewController?
  public var failureViewController: FailureViewController?
  public var loadingViewController: LoadingViewController?
  public var emptyViewController: EmptyViewController?
  
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
    // Load the first view controller.
    //		transition(to: viewState, from: nil, animated: false, completion: nil)
  }
  
  private var viewHasAppeared = false
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if !viewHasAppeared {
      transition(to: viewState, from: nil, animated: true, completion: nil)
      viewHasAppeared = true
    }
  }
  
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
  
  // MARK: Configuring ViewControllers
  
  open func configure(
    successViewController viewController: SuccessViewController,
    with viewModel: SuccessViewController.ViewModel
  ) {
    self.attempt { try viewController.tryConfigure(with: viewModel) }
  }
  
  open func configure(
    failureViewController viewController: FailureViewController,
    with viewModel: FailureViewController.ViewModel
  ) {
    self.attempt { try viewController.tryConfigure(with: viewModel) }
  }
  
  open func configure(
    emptyViewController viewController: EmptyViewController,
    with viewModel: EmptyViewController.ViewModel
  ) {
    self.attempt { try viewController.tryConfigure(with: viewModel) }
  }
  
  open func configure(
    loadingViewController viewController: LoadingViewController,
    with viewModel: LoadingViewController.ViewModel
  ) {
    self.attempt { try viewController.tryConfigure(with: viewModel) }
  }
  
  /// Returns a `ViewController` enum for a given view state.
  private func getViewController(for viewState: ControllerViewState) -> ViewController {
    switch viewState {
    case .success:
      let viewController = self.getSuccessViewController()
      successViewControllerDidLoad?(viewController)
      return .success(viewController)
    case .failure:
      let viewController = self.getFailureViewController()
      failureViewControllerDidLoad?(viewController)
      return .failure(viewController)
    case .loading:
      let viewController = getLoadingViewController()
      loadingViewControllerDidLoad?(viewController)
      return .loading(viewController)
    case .empty:
      let viewController = self.getEmptyViewController()
      emptyViewControllerDidLoad?(viewController)
      return .empty(viewController)
    }
  }
  
  /// Configures a view controller for a given view state.
  private func configureViewController(for viewState: ControllerViewState) {
    switch viewState {
    case .success(let viewModel):
      let viewController = self.getSuccessViewController()
      configure(successViewController: viewController, with: viewModel)
    case .failure(let viewModel):
      let viewController = self.getFailureViewController()
      configure(failureViewController: viewController, with: viewModel)
    case .loading(let viewModel):
      let viewController = getLoadingViewController()
      configure(loadingViewController: viewController, with: viewModel)
    case .empty(let viewModel):
      let viewController = self.getEmptyViewController()
      configure(emptyViewController: viewController, with: viewModel)
    }
  }
  
  // MARK: - Transitions
  
  /// Subclassers can override 
  open func willTransition(
    to toViewController: ViewController,
    from fromViewController: UIViewController?,
    animated: Bool
  ) {}
  
  /// Subclassers can override
  open func didTransition(
    to toViewController: ViewController,
    from fromViewController: UIViewController?,
    animated: Bool
  ) { /* Override */ }
  
  /// Transitions to a new view state. Handles child/parent view controller loading and offloading.
  open func transition(
    to toViewState: ControllerViewState,
    from fromViewState: ControllerViewState?,
    animated: Bool,
    completion: ((ControllerViewState) -> Void)?
  ) {
    // Add newViewController to self and configure view
    let oldViewController = currentViewController
    let newViewControllerType = self.getViewController(for: toViewState)
    let newViewController = newViewControllerType.uiViewController
    guard oldViewController != newViewController else {
      // This can happen when cancelling an interactive drag, or when refreshing an active screen.
      configureViewController(for: toViewState)
      completion?(toViewState)
      return
    }
    currentViewController = newViewController
    addChildViewController(newViewController)
    newViewController.view.alpha = 0
    newViewController.view.backgroundColor = oldViewController?.view.backgroundColor
    //		newViewController.view.setNeedsUpdateConstraints()
    //		newViewController.view.updateConstraintsIfNeeded()
    configureViewController(for: toViewState)
    
    // Subclassers can override this function
    willTransition(to: newViewControllerType, from: oldViewController, animated: animated)
    
    let animations: () -> Void = {
      newViewController.view.alpha = 1
      oldViewController?.view.alpha = 0
    }
    let animationCompletion: (Bool) -> Void = { _ in
      // Remove oldViewController from self
      oldViewController?.willMove(toParent: nil)
      oldViewController?.removeFromParent()
      oldViewController?.view.removeFromSuperview()
      completion?(toViewState)
      // Subclassers can override this function
      self.didTransition(to: newViewControllerType, from: oldViewController, animated: animated)
    }
    if animated {
      // Animate fade transition
      UIView.animate(
        withDuration: Animation.shortDuration,
        animations: animations,
        completion: animationCompletion
      )
    } else {
      animations()
      animationCompletion(true)
    }
  }
  
  open func attempt(animated: Bool = true, handler: () throws -> Void) {
    do {
      try handler()
    } catch let error {
      self.handleError(error, animated: animated)
    }
  }
  
  open func handleError(_ error: Error, animated: Bool = true) {
    let viewError = FailureViewController.viewModel(from: error)
    let errorState = ControllerViewState(viewError)
    self.transition(to: errorState, from: self.viewState, animated: animated, completion: nil)
  }
}

// MARK: - Defaults

extension ViewStateController where LoadingViewController: DefaultLoadingViewController {
  open func showLoading(animated: Bool) {
    let loadingViewModel = DefaultLoadingViewController.ViewModel()
    self.transition(
      to: .loading(loadingViewModel),
      from: self.viewState,
      animated: animated,
      completion: nil
    )
  }
}
