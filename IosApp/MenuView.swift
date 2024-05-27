//
//  MenuView.swift
//  CenterTabBar
//
//  Created by Satyadev Chauhan on 07/03/23.
//

import SwiftUI

struct MenuView: View {
    
    let widthAndHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                NavigationLink(destination: Text("Camera"), label: {
                    MenuItemView(image: "camera", color: .accentColor, widthAndHeight: widthAndHeight)
                })   
            }
            ZStack {
                NavigationLink(destination: Text("Camera"), label: {
                    MenuItemView(image: "photo", color: .accentColor, widthAndHeight: widthAndHeight)
                })
            }
        }
        .transition(.scale)
    }
}

struct PlusMenu_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView(widthAndHeight: 100)
        }
    }
}
