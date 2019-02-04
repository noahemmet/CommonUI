import CommonUI
import PlaygroundSupport

class WrappedView: UIView, ViewModelConfigurable {
	func configure(with nothing: Void) { }
}

let cornerRadius: CGFloat = 8

// container
let container = UIView(frame: CGRect(width: 400, height: 500))
container.backgroundColor = #colorLiteral(red: 0.8976886334, green: 0.8976886334, blue: 0.8976886334, alpha: 1)

let wrapped = WrappedView(frame: .zero)
wrapped.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

let cardViewController = CardViewController(wrapping: wrapped)
container.addSubview(cardViewController.view)
cardViewController.view.activateConstraints(toMarginsOf: container)

PlaygroundPage.current.liveView = container
let colorTheme = CardView<WrappedView>.ColorTheme(title: .black,
															titleBackground: #colorLiteral(red: 0.9102776878, green: 0.9102776878, blue: 0.9102776878, alpha: 1),
															contentBackground: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
															outerBorder: #colorLiteral(red: 0.6595522474, green: 0.6595522474, blue: 0.6595522474, alpha: 1))
let viewModel = CardViewController<WrappedView>.ViewModel(colorTheme: colorTheme, title: .init(string: "Title"), content: ())
cardViewController.configure(with: viewModel)

