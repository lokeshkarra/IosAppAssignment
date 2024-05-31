

import Foundation
import SwiftUI


public struct RingProgressView: ProgressViewStyle {
  private let defaultSize: CGFloat = 36
  private let lineWidth: CGFloat = 6
  private let defaultProgress = 0.2 // CHANGE

  
  @State private var fillRotationAngle = Angle.degrees(-90) // ADD

  public func makeBody(configuration: ProgressViewStyleConfiguration) -> some View {
    VStack {
      configuration.label
      progressCircleView(fractionCompleted: configuration.fractionCompleted ?? defaultProgress,
               isIndefinite: configuration.fractionCompleted == nil)
        configuration.currentValueLabel
    }
  }

  private func progressCircleView(fractionCompleted: Double,
                              isIndefinite: Bool) -> some View {
     
    Circle()
      .strokeBorder(Color.gray.opacity(0.5), lineWidth: lineWidth, antialiased: true)
      .overlay(fillView(fractionCompleted: fractionCompleted, isIndefinite: isIndefinite)) // UPDATE
      .frame(width: defaultSize, height: defaultSize)
  }

  private func fillView(fractionCompleted: Double,
                              isIndefinite: Bool) -> some View { // UPDATE
    Circle() // the fill view is also a circle
      .trim(from: 0, to: CGFloat(fractionCompleted))
      .stroke(Color.primaryBlue, lineWidth: lineWidth)
      .frame(width: defaultSize - lineWidth, height: defaultSize - lineWidth)
      .rotationEffect(fillRotationAngle) // UPDATE
      // triggers the infinite rotation animation for indefinite progress views
      .onAppear {
        if isIndefinite {
          withAnimation(.easeInOut(duration: 1).repeatForever()) {
            fillRotationAngle = .degrees(360)
          }
        }
      }
  }
}
