//
//  ViewModelProvider.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/24/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
import Common

// MARK: - ViewModelProviding

/// Returns a `ViewState` generic over four types of view model.
public protocol ViewModelProviding {
    /// Used for dependency vending
//    static var key: String { get }
    
    associatedtype Context
    associatedtype SuccessViewModel
    associatedtype FailureViewModel: Error
    associatedtype LoadingViewModel
    associatedtype EmptyViewModel
    typealias ProviderViewState = ViewState<SuccessViewModel, FailureViewModel, LoadingViewModel, EmptyViewModel>
    typealias Response = (ProviderViewState) -> Void
    func requestViewStateModel(for context: Context, response: @escaping Response)
}

// MARK: - Defaults

/// Debugging tool
public struct DefaultViewModelProviderContext {
    public init() { }
}

/// Convenience for a standard `ViewModelProviding`.
public struct CustomSuccessViewModelProvider<SuccessViewModel>: ViewModelProviding {
    public static var key: Key { return "CustomSuccessViewModelProvider" }// note this may need to be more unique 
    public typealias Context = Void
    public typealias LoadingViewModel = DefaultLoadingViewController.ViewModel
    public typealias EmptyViewModel = DefaultEmptyViewController.ViewModel
    public typealias FailureViewModel = DefaultFailureViewController.ViewModel
    public typealias ViewStateType = ViewState<SuccessViewModel, FailureViewModel, LoadingViewModel, EmptyViewModel>
    public typealias ViewStateHandler = (Context) -> ViewStateType
    
    public let endpointResponder: EndpointResponder!
    private var viewStateHandler: ViewStateHandler
    
    public init(with endpointResponder: EndpointResponder!, handler viewStateHandler: @escaping ViewStateHandler) {
        self.endpointResponder = endpointResponder
        self.viewStateHandler = viewStateHandler
    }
    
    public func requestViewStateModel(for context: Void, response: Response) {
        fatalError()
    }

    public func viewStateModel(for context: Context) -> CustomSuccessViewState<SuccessViewModel> {
        return viewStateHandler(context)
    }
}
