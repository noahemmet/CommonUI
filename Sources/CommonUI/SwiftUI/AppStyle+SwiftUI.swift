import Foundation
import SwiftUI

public extension View {
	func appStyle() -> some View {
		ModifiedContent(content: self, modifier: AppStyleModifier())
	}
}

struct AppStyleModifier: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.foregroundColor(Color(AppStyle.primaryText))
			.accentColor(Color(AppStyle.tint))
	}
}
