//
//  TabBarItemView.swift
//  CenterTabBar
//
//  Created by Satyadev Chauhan on 07/03/23.
//

import SwiftUI

struct TabBarItemView: View {
    
    @Binding var selected: Tab
    let tab: Tab
    
    let width, height: CGFloat
    
    var body: some View {
        VStack {
            Image(systemName: tab.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tab.rawValue)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture {
            selected = tab
        }
        .foregroundColor(selected == tab ? .black : .gray)
    }
}

struct TabBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItemView(selected: .constant(.link), tab: .link, width: 80, height: 80)
    }
}
