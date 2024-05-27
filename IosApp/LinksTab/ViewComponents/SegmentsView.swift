//
//  SegmentsView.swift
//  ListedAssignment
//
//  Created by Suchith Nayaka on 22/05/24.
//

import SwiftUI

struct SegmentsView: View {
    @Binding var selectedIndex: Int
    var segments: [String]
    var body: some View {
        HStack {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selectedIndex = segments.firstIndex(of: segment) ?? 0
                } label: {
                    Text(segment)
                        .font(.figtree(size: 16, weight: .regular))
                        .foregroundColor(selectedIndex == segments.firstIndex(of: segment) ? Color.white : Color.secondaryForeground)
                        .fontWeight(.medium)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(selectedIndex == segments.firstIndex(of: segment) ? Color.primaryBlue : Color.clear)
                .cornerRadius(18)
            }
        }
        .background(Color.clear)
        .cornerRadius(5)
    }
}
