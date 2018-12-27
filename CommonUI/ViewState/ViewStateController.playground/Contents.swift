import UIKit
import CommonUI
import PlaygroundSupport

struct ColorViewModel {
    let color: UIColor
}

class SuccessViewController: UIViewController, ViewModelConfigurable {
    func configure(with viewModel: ColorViewModel) {
        view.backgroundColor = viewModel.color
    }
}

var index = 0
let viewStateController = CustomSuccessViewStateController<SuccessViewController>() {
    defer { index += 1; index %= 4 }
//    sleep(0.1)
    if index == 0 {
        print("success")
        let viewModel = ColorViewModel(color: .green)
        return .success(viewModel)
    } else if index == 1 {
        print("failure")
        let viewModel = DefaultFailureViewController.ViewModel.loadFailed
        return .failure(viewModel)
    } else if index == 2 {
        print("loading")
        let viewModel = DefaultLoadingViewController.ViewModel()
        return .loading(viewModel)
    } else {
        print("empty")
        let viewModel = DefaultEmptyViewController.ViewModel()
        return .empty(viewModel)
    }
}

PlaygroundPage.current.liveView = viewStateController

class Responder: NSObject {
    @objc
    func handleTap() {
        viewStateController.load(animated: true, completion: nil)
    }
}

let responder = Responder()
let tap = UITapGestureRecognizer(target: responder, action: #selector(Responder.handleTap))
viewStateController.view.addGestureRecognizer(tap)
