import Foundation
import SwiftUI
import Combine
import UIKit

public final class BezeledButton: UIView {
  public let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
  public let button = Button(frame: .zero)
  public let subButton = UIButton(frame: .zero)
  public let onAction = PassthroughSubject<BezeledButton, Never>()
  private var action: ((BezeledButton) -> Void)?
  
  public convenience init(title: String, action: @escaping (BezeledButton) -> Void) {
    self.init(frame: .zero)
    self.action = action
    button.setTitle(title, for: .normal)
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    addTopBorder()
    
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
    button.setTitleColor(AppStyle.background, for: .normal)
    button.setTitleColor(AppStyle.background2, for: .highlighted)
    button.addTarget(self, action: #selector(handleAction), for: .primaryActionTriggered)
    
    subButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
    subButton.setTitleColor(AppStyle.background, for: .normal)
    subButton.setTitleColor(AppStyle.background2, for: .highlighted)
    subButton.isHidden = true
    
    blurView.setContentCompressionResistancePriority(.required, for: .vertical)
    blurView.setContentCompressionResistancePriority(.required, for: .horizontal)
    blurView.setContentHuggingPriority(.required, for: .vertical)
    blurView.setContentHuggingPriority(.required, for: .horizontal)
    addSubview(blurView)
    blurView.activateConstraints(to: self)
    
    let stackView = UIStackView(arrangedSubviews: [button, subButton])
    stackView.axis = .vertical
    stackView.distribution = .fill//Proportionally
    blurView.contentView.addSubview(stackView)
    stackView.activateConstraints(toMarginsOf: blurView)
  }
  
  @objc
  private func handleAction() {
    self.onAction.send(self)
    self.action?(self)
  }
  
  //    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
  //        let convertedToButtonTouch = convert(point, to: button)
  //        let shouldForwardToButton = (button.point(inside: convertedToButtonTouch, with: event) && button.isUserInteractionEnabled)
  //        return shouldForwardToButton
  //    }
}

extension BezeledButton: UIViewRepresentable {
  public func makeUIView(context: Context) -> BezeledButton {
    return BezeledButton(frame: .zero)
  }
  
  public func updateUIView(_ uiView: BezeledButton, context: Context) {}
}
