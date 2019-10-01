import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
	@Binding public var isAnimating: Bool
	public let style: UIActivityIndicatorView.Style

	public init(style: UIActivityIndicatorView.Style = .medium, isAnimating: Binding<Bool>) {
		self.style = style
		_isAnimating = isAnimating
	}
	
	public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
		return UIActivityIndicatorView(style: style)
	}
	
	public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
		isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
	}
}
