//
//  LinksHistoryView.swift
//  ListedAssignment
//
//  Created by Suchith Nayaka on 22/05/24.
//

import SwiftUI

struct LinksView: View {
    @Binding var topLinksList: [LinkItemModel]
    @Binding var recentLinksList: [LinkItemModel]
    var delegate: LinkProtocol? = nil
    @State var linkTypes: [String] = ["Top Links", "Recent Links"]
    @State var selectedListViewType: Int = 0
    @State private var showAllTopLinks: Bool = false
    var displayedTopResults: [LinkItemModel] {
        showAllTopLinks ? topLinksList : Array(topLinksList.prefix(4))
    }
    @State private var showAllRecentLinks: Bool = false
    var displayedRecentResults: [LinkItemModel] {
        showAllRecentLinks ? recentLinksList : Array(recentLinksList.prefix(4))
    }
    
    var body: some View {
        VStack {
            HStack {
                SegmentsView(selectedIndex: $selectedListViewType, segments: linkTypes)
                Spacer()
                Image(.search)
            }
            .padding(.bottom, 32)
            if selectedListViewType == 0 {
                ForEach(displayedTopResults, id:\.self) { each in
                    LinkItemView(linkItem: each, delegate: delegate)
                }
                if !showAllTopLinks {
                    CustomButtonView(bindedVariable: $showAllTopLinks, button: ButtonModel(image: .link, name: "View all Links"))
                }
            }
            else {
                ForEach(displayedRecentResults, id:\.self) { each in
                    LinkItemView(linkItem: each, delegate: delegate)
                }
                if !showAllRecentLinks {
                    CustomButtonView(bindedVariable: $showAllRecentLinks, button: ButtonModel(image: .link, name: "View all Links"))
                }
            }
        }
        .padding()
    }
}

struct LinkItemView: View {
    @State var linkItem: LinkItemModel
    var delegate: LinkProtocol? = nil
    
    var body: some View {
        Button {
            openURL()
        } label: {
            VStack {
                HStack {
                    UrlImageView(urlString: linkItem.originaImage ?? "")
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(linkItem.title)
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(.black)
                        Text(linkItem.displayDate)
                            .font(.figtree(size: 12, weight: .regular))
                            .foregroundColor(Color.secondaryForeground)
                    }
                    Spacer()
                    VStack(spacing: 5) {
                        Text("\(linkItem.totalClicks)")
                            .font(.figtree(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        Text("Clicks")
                            .font(.figtree(size: 12, weight: .regular))
                            .foregroundColor(Color.secondaryForeground)
                    }
                }
                .padding(8)
                Button {
                    delegate?.copied()
                    UIPasteboard.general.string = linkItem.linkURL
                } label: {
                    HStack {
                        Text(linkItem.linkURL)
                            .font(.figtree(size: 14, weight: .regular))
                            .foregroundColor(Color.primaryBlue)
                        Spacer()
                        Image(.copy)
                    }
                    .padding()
                    .background(Color.secondaryBlue)
                    .overlay(RoundedCorner(radius: 10, corners: [.bottomLeft, .bottomRight])
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                        .foregroundColor(Color.primaryBlue))
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .lineLimit(1)
            .background(.white)
            .cornerRadius(10)
            .padding(.vertical, 8)
        }
    }
    
    func openURL() {
        guard let url = URL(string: linkItem.linkURL) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


