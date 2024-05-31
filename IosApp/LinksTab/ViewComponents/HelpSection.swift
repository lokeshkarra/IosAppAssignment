


import SwiftUI

enum HelpTypes: String, CaseIterable {
    case talkWithUs = "Talk with us"
    case faq = "Frequently Asked Questions"
    
    var image: ImageResource {
        switch self {
        case .talkWithUs:
            return .talkWithUs
        case .faq:
            return .faq
        }
    }
    
    var bgColor: Color {
        switch self {
        case .talkWithUs:
            return Color.primaryGreen.opacity(0.1)
        case .faq:
            return Color.secondaryBlue
        }
    }
    
    var borderColor: Color {
        switch self {
        case .talkWithUs:
            return Color.primaryGreen
        case .faq:
            return Color.primaryBlue
        }
    }
    
    var baseURL: String {
        switch self {
        case .talkWithUs:
            return "https://wa.me/+91\(CommonData.sharedVariables.whatsappNumber)"
        case .faq:
            return "https://openinapp.com/faq"
        }
    }
}
struct HelpSection: View {
 
    var body: some View {
        ForEach(HelpTypes.allCases, id:\.self) { each in
            HelpCardView(helpType: each)
                .padding(.vertical, 6)
            Spacer()
        }
    }
}

struct HelpCardView: View {
    @State var helpType: HelpTypes
    
    var body: some View {
        Button {
            openURL()
        } label: {
            HStack {
                Image(helpType.image)
                Text(helpType.rawValue)
                    .font(.figtree(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .padding(.vertical, 8)
            .background(helpType.bgColor)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(helpType.borderColor, lineWidth: 1))
        }
        .padding(.horizontal)
    }
    
    func openURL() {
        guard let url = URL(string: helpType.baseURL) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
