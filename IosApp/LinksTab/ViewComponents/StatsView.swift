//
//  StatsView.swift
//  ListedAssignment
//
//  Created by Suchith Nayaka on 22/05/24.
//

import SwiftUI

enum Stats: String, CaseIterable, Codable {
    case clicks = "Today's Clicks"
    case topLocation = "Top Location"
    case topSource = "Top Source"
    
    var image: ImageResource {
        switch self {
        case .clicks:
            return .clicks
        case .topLocation:
            return .topLocation
        case .topSource:
            return .topSource
        }
    }
}

struct StatsView: View {
    @Binding var stats: [StatsData]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach($stats, id:\.self) { each in
                    StatsCardView(stat: each)
                        .padding(.vertical)
                }
            }
            .padding(.horizontal)
        }
        CustomButtonView(bindedVariable: .constant(false), button: ButtonModel(image: .analytics, name: "View Analytics"))
            .padding(.horizontal)
    }
}

struct StatsCardView: View {
    @Binding var stat: StatsData
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(stat.type.image)
            Spacer()
            Text(stat.value)
                .font(.figtree(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(.vertical, 8)
            HStack {
                Text(stat.type.rawValue)
                    .font(.figtree(size: 14, weight: .regular))
                    .foregroundColor(Color.secondaryForeground)
                Spacer()
            }
        }
        .lineLimit(1)
        .padding()
        .background(.white)
        .cornerRadius(10)
        .frame(width: 140)
        .fixedSize()
    }
}
