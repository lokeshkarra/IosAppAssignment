

import SwiftUI

protocol LinkProtocol {
    func copied()
}

struct LinksTabView: View {
    @State var showingToast: Bool = false
    @ObservedObject var linksTabVM: LinksTabViewModel = LinksTabViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavBarView()
            VStack(alignment: .leading) {
                GreetingsView()
                HStack {
                    Spacer()
                    SampleLineChartView()
                    Spacer()
                }
                if linksTabVM.stats.isEmpty || linksTabVM.topLinks.isEmpty || linksTabVM.recentLinks.isEmpty {
                    HStack {
                        Spacer()
                    ProgressView().progressViewStyle(RingProgressViewStyle())
                            .padding()
                        Spacer()
                    }
                }
                if !linksTabVM.stats.isEmpty {
                    StatsView(stats:  $linksTabVM.stats)
                }
                if !linksTabVM.topLinks.isEmpty || !linksTabVM.recentLinks.isEmpty {
                    LinksView(topLinksList: $linksTabVM.topLinks, recentLinksList: $linksTabVM.recentLinks, delegate: self)
                }
                HelpSectionView()
                Spacer(minLength: 100)
            }
            .background(Color.primaryBackground)
            .cornerRadius(16, corners: [.topLeft, .topRight])
        }
        .background(VStack {
            Color.primaryBlue
            Color.primaryBackground
        })
        .edgesIgnoringSafeArea(.vertical)
        .toast(isShowing: $showingToast, message: "Link Copied to Clipboard")
        .onAppear {
            linksTabVM.fetchLinksData()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            linksTabVM.fetchLinksData()
        }
    }
}

extension LinksTabView: LinkProtocol {
    func copied() {
        showingToast = true
    }
}

#Preview {
    LinksTabView()
}
