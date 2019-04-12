import CommonUI
import PlaygroundSupport

class WrappedViewController: UIViewController, ViewModelConfigurable {
	struct ViewModel { }
	func configure(with vm: ViewModel) { }
}

let cornerRadius: CGFloat = 8

// container
let container = UIView(frame: CGRect(width: 400, height: 500))
container.backgroundColor = #colorLiteral(red: 0.8976886334, green: 0.8976886334, blue: 0.8976886334, alpha: 1)

let wrappedVC = WrappedViewController(nibName: nil, bundle: nil)
wrappedVC.view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

let cardViewController = CardViewController(wrapping: wrappedVC)
container.addSubview(cardViewController.view)
cardViewController.view.activateConstraints(toMarginsOf: container)

PlaygroundPage.current.liveView = container
let colorTheme = CardView.ColorTheme(title: .black,
									 titleBackground: #colorLiteral(red: 0.9102776878, green: 0.9102776878, blue: 0.9102776878, alpha: 1),
									 contentBackground: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
									 outerBorder: #colorLiteral(red: 0.6595522474, green: 0.6595522474, blue: 0.6595522474, alpha: 1))
let contentViewModel = WrappedViewController.ViewModel()
let cardViewModel = CardView.CardViewModel<WrappedViewController>.init(title: .init(string: "Title"), content: contentViewModel)
//let viewModel = CardView<UIView>.CardViewModel(colorTheme: colorTheme,
//							title: .init(string: "hi"),
//							content: contentViewModel)
//let viewModel = CardViewController<WrappedViewController, UIView>.ViewModel(colorTheme: colorTheme, title: .init(string: "Title"), content: contentViewModel)
cardViewController.configure(with: cardViewModel)
