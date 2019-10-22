import SwiftUI

public extension View {
  func fixedLineLimit(_ limit: Int? = nil) -> some View {
    ModifiedContent(content: self, modifier: FixedLineLimitModifier(limit: limit))
  }
}

struct FixedLineLimitModifier: ViewModifier {
  let limit: Int?
  init(limit: Int? = nil) {
    self.limit = limit
  }
  func body(content: Content) -> some View {
    content
      .lineLimit(2)
      .fixedSize(horizontal: false, vertical: true)
  }
}
