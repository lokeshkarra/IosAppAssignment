

import SwiftUI

protocol LinkProtocol {
    func copied()
}

struct LinksTabView: View {
    @State var showingToast: Bool = false
    @ObservedObject var linksTabVM: LinksTabViewModel = LinksTabViewModel()
    @StateObject var lineChartViewModel = LineChartViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                // Navigation Bar
                HStack {
                    Text("Dashboard")
                        .font(.figtree(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(.settings)
                }
                .padding(.top, 50)
                .padding(.top)
                .padding()
                .background(Color.primaryBlue)
                
                VStack(alignment: .leading) {
                    GreetingsView()
                    
                    HStack {
                        Spacer()
                        LineChartView(viewModel: lineChartViewModel)
                        Spacer()
                    }
                    
                   // linksTabVM.fetchLinksData()
                    
                    if linksTabVM.isLoading {
                        HStack {
                            Spacer()
                            ProgressView().progressViewStyle(RingProgressView())
                                .padding()
                            Spacer()
                        }
                    } else {
                        if !linksTabVM.stats.isEmpty {
                            StatsView(stats: $linksTabVM.stats)
                        }
                        
                        if !linksTabVM.topLinks.isEmpty || !linksTabVM.recentLinks.isEmpty {
                            LinksView(topLinksList: $linksTabVM.topLinks, recentLinksList: $linksTabVM.recentLinks, delegate: self)
                        }
                    }
                    
                    HelpSection()
                    
                    Spacer(minLength: 100)
                }
                .background(Color.primaryBackground)
                .cornerRadius(16, corners: [.topLeft, .topRight])
            }
            .background(Color.primaryBlue)
        }
        .background(VStack {
            Color.primaryBlue
            Color.primaryBackground
        })
        .edgesIgnoringSafeArea(.vertical)
        .toast(isShowing: $showingToast, message: "Link Copied to Clipboard")
        .onAppear {
            print("View appeared")
            linksTabVM.fetchLinksData()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            print("App entering foreground")
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

#Preview {
    LinksTabView()
}
