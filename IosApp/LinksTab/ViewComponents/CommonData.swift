//
//  CommonData.swift
//  ListedAssignment
//
//  Created by Suchith Nayaka on 23/05/24.
//

import Foundation

class CommonData {
    static var sharedVariables = SharedVariables()
    public static var userDefaults: UserDefaults = UserDefaults(suiteName: "group.listed")!
}

class SharedVariables: ObservableObject {
    var whatsappNumber: String {
        set {
            CommonData.userDefaults.set(newValue, forKey: "whatsappNumber")
        } get {
            return CommonData.userDefaults.string(forKey: "whatsappNumber") ?? ""
        }
    }
}
