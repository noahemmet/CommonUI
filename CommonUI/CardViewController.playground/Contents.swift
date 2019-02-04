import CommonUI
import PlaygroundSupport

let cornerRadius: CGFloat = 8

// container
let container = UIView(frame: CGRect(width: 400, height: 500))
container.backgroundColor = #colorLiteral(red: 0.8976886334, green: 0.8976886334, blue: 0.8976886334, alpha: 1)
container.layoutMargins.left = 40

let cardViewController = CardViewController.fromStoryboard()
container.addSubview(cardViewController.view)
cardViewController.view.activateConstraints(toMarginsOf: container)
cardViewController.titleView.layoutMargins.left = Layout.spacing + Layout.spacingSmall
cardViewController.titleView.layoutMargins.right = Layout.spacing + Layout.spacingSmall
cardViewController.titleView.layoutMargins.top = Layout.spacing
cardViewController.titleView.layoutMargins.bottom = Layout.spacing

PlaygroundPage.current.liveView = container

cardViewController.titleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
cardViewController.titleView.layer.cornerRadius = cornerRadius
cardViewController.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
cardViewController.contentView.layer.cornerRadius = cornerRadius
//cardViewController.contentView.backgroundColor = .blue

// border
cardViewController.view.layer.borderColor = #colorLiteral(red: 0.7855610427, green: 0.7855610427, blue: 0.7855610427, alpha: 1).cgColor
cardViewController.view.layer.borderWidth = 2
cardViewController.view.layer.cornerRadius = cornerRadius
// shadow
cardViewController.view.layer.shadowOffset = CGSize(width: 0, height: 4)
cardViewController.view.layer.shadowOpacity = 1
cardViewController.view.layer.shadowRadius = 8
cardViewController.view.layer.shadowColor = cardViewController.view.layer.borderColor
