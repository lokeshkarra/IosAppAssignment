

import SwiftUI

struct CustomButtonView: View {
    @Binding var bindedVariable: Bool
    @State var button: ButtonModel
    
    var body: some View {
        Button {
            bindedVariable.toggle()
        } label: {
            HStack {
                Image(button.image)
                Text(button.name)
                    .font(.figtree(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color.primaryBackground)
        .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(Color.borderColor, lineWidth: 3))
        .cornerRadius(8)
        .padding(.vertical, 8)
    }
}
