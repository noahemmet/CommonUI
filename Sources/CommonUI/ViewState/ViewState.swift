//
//  ViewState.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/21/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation
//import UIKit
import Common

// MARK: - ViewState

public typealias CustomSuccessViewState<SuccessViewModel> = ViewState<
  SuccessViewModel,
  CustomSuccessViewStateError,
  DefaultLoadingViewController.ViewModel,
  DefaultEmptyViewController.ViewModel
>

public enum ViewState<SuccessViewModel, E: Error, LoadingViewModel, EmptyViewModel> {
  case success(SuccessViewModel)
  case failure(E)
  case loading(LoadingViewModel)
  case empty(EmptyViewModel)
  
  public init(_ successViewModel: SuccessViewModel) {
    self = .success(successViewModel)
  }
  
  public init(_ error: E) {
    self = .failure(error)
  }
  
  public var successViewModel: SuccessViewModel? {
    if case .success(let viewModel) = self {
      return viewModel
    } else {
      return nil
    }
  }
  
  public var isSuccess: Bool {
    return successViewModel != nil
  }
  
  public var error: E? {
    if case .failure(let error) = self {
      return error
    } else {
      return nil
    }
  }
  
  public var isError: Bool {
    return error != nil
  }
  
  public var loadingViewModel: LoadingViewModel? {
    if case .loading(let viewModel) = self {
      return viewModel
    } else {
      return nil
    }
  }
  
  public var isLoading: Bool {
    return loadingViewModel != nil
  }
  
  public var emptyViewModel: EmptyViewModel? {
    if case .empty(let viewModel) = self {
      return viewModel
    } else {
      return nil
    }
  }
  
  public var isEmpty: Bool {
    return emptyViewModel != nil
  }
}

// MARK: - Error

public enum CustomSuccessViewStateError: Error {
  case loadFailed(Error)
}

public extension ViewState where E == CustomSuccessViewStateError {
  init(_ handler: () throws -> ViewState<SuccessViewModel, E, LoadingViewModel, EmptyViewModel>) {
    do {
      self = try handler()
    } catch let error as E {
      self.init(error)
    } catch let error {
      self.init(error)
    }
  }
  
  init(_ error: Error) {
    let viewStateError = CustomSuccessViewStateError.loadFailed(error)
    self.init(viewStateError)
  }
}
