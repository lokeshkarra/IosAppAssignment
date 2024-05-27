

import SwiftUI

struct NavBarView: View {
    var body: some View {
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
    }
}
