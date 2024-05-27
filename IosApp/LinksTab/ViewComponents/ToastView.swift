//
//  ToastView.swift
//  ListedAssignment
//
//  Created by Suchith Nayaka on 23/05/24.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.subheadline)
            .font(.figtree(size: 14, weight: .regular))
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
            .shadow(radius: 10)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: 1)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                ToastView(message: message)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String) -> some View {
        self.modifier(ToastModifier(isShowing: isShowing, message: message))
    }
}
