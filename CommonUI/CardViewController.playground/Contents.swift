import CommonUI
import PlaygroundSupport

let cornerRadius: CGFloat = 8

// container
let container = UIView(frame: CGRect(width: 400, height: 500))
container.backgroundColor = #colorLiteral(red: 0.8976886334, green: 0.8976886334, blue: 0.8976886334, alpha: 1)

let wrapped = UIView(frame: .zero)
wrapped.backgroundColor = .red

let cardViewController = CardViewController(wrapping: wrapped)
container.addSubview(cardViewController.view)
cardViewController.view.activateConstraints(toMarginsOf: container)

PlaygroundPage.current.liveView = container
