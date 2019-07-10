import SwiftUI
import Common

extension Common.Color {
	public var asSwiftColor: SwiftUI.Color {
		return SwiftUI.Color(red: red, green: green, blue: blue)
	}
}
