//
//  Fonts+Extension.swift
//  ListedAssignment
//
//  Created by Suchith Nayaka on 22/05/24.
//

import Foundation
import SwiftUI
    
extension Font {

    enum FigtreeWeight: String {
        case bold = "Figtree-Bold"
        case medium = "Figtree-Medium"
        case regular = "Figtree-Regular"
        case semibold = "Figtree-SemiBold"
    }

    static func figtree(size: CGFloat, weight: FigtreeWeight) -> Font {
        let availableFigtreeFonts = UIFont.fontNames(forFamilyName: "Figtree")
        //print("Available Figtree font names: \(availableFigtreeFonts)")

        if availableFigtreeFonts.contains(weight.rawValue) {
            return Font(UIFont(name: weight.rawValue, size: size)!)
        } else if availableFigtreeFonts.contains(FigtreeWeight.regular.rawValue) {
            return Font.figtree(size: size, weight: .regular)
        } else {
            //print("Error: No Figtree fonts available. Using system font.")
            return Font.system(size: size) // Fallback to a system font if none are available
        }
    }
}
