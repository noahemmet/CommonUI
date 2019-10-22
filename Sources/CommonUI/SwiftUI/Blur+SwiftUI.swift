import Foundation
import SwiftUI

public extension View {
  func blurBackground(style: UIBlurEffect.Style = .systemMaterial) -> some View {
		ModifiedContent(content: self, modifier: BackgroundBlurModifier(style: style))
	}
}

struct BackgroundBlurModifier: ViewModifier {
  let style: UIBlurEffect.Style
	func body(content: Content) -> some View {
		ZStack(alignment: .center) {
      BlurView(style: style)
			content.layoutPriority(1)
		}
	}
}


struct BlurView: UIViewRepresentable {
  
  let style: UIBlurEffect.Style
  
  func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    let blurEffect = UIBlurEffect(style: style)
    let blurView = UIVisualEffectView(effect: blurEffect)
    view.insertSubview(blurView, at: 0)
    blurView.activateConstraints(to: view)
    return view
  }
  
  func updateUIView(_ uiView: UIView,
                    context: UIViewRepresentableContext<BlurView>) {
    
  }
  
}
