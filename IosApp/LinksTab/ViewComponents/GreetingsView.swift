//
//  GreetingsView.swift
//  ListedAssignment
//
//  Created by Suchith Nayaka on 22/05/24.
//

import SwiftUI

struct GreetingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(getGreetingBasedOnTime())
                .font(.figtree(size: 16, weight: .regular))
                .foregroundColor(Color.secondaryForeground)
            HStack {
                Text("Ajay Manva")
                    .font(.figtree(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.vertical, 4)
                Image(.wave)
                Spacer()
            }
        }
        .padding()
    }
    
    func getGreetingBasedOnTime() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        
        if hour >= 0 && hour < 6 {
            return "Good Night"
        } else if hour >= 6 && hour < 12 {
            return "Good Morning"
        } else if hour >= 12 && hour < 18 {
            return "Good Afternoon"
        } else {
            return "Good Evening"
        }
    }
}
