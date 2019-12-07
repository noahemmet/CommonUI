import Foundation
import SwiftUI

public struct IfLet<T, Out: View>: View {
  let value: T?
  let produce: (T) -> Out

  public init(_ value: T?, produce: @escaping (T) -> Out) {
    self.value = value
    self.produce = produce
  }

  public var body: some View {
    Group {
      if value != nil {
        produce(value!)
      }
    }
  }
}
