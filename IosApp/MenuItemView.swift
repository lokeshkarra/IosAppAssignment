//
//  MenuItemView.swift
//  CenterTabBar
//
//  Created by Satyadev Chauhan on 07/03/23.
//

import SwiftUI

struct MenuItemView: View {
    
    let image: String
    let color: Color
    let widthAndHeight: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: widthAndHeight, height: widthAndHeight)
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(15)
                .frame(width: widthAndHeight, height: widthAndHeight)
                .foregroundColor(.white)
        }
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(image: "folder", color: .accentColor, widthAndHeight: 100)
    }
}
