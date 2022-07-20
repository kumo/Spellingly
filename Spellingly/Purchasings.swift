//
//  Purchasings.swift
//  Spellingly
//
//  Created by Robert Clarke on 19/07/22.
//

import Foundation
import SwiftUI
import RevenueCat

class IAPManager: ObservableObject {

    // MARK: - Propeties
    static let shared = IAPManager()

    @Published var packages: [Package] = []
    @Published var inPaymentProgress = false

    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_VTVDFlzWZUOrpPkLFLaSLGZZfLb")
        Purchases.shared.getOfferings { (offerings, _) in
            if let packages = offerings?.current?.availablePackages {
                self.packages = packages
            }
        }
    }

    func purchase(package: Package) {
        guard !inPaymentProgress else { return }
        inPaymentProgress = true
        Purchases.shared.purchase(package: package) { (_, purchaserInfo, _, _) in
            self.inPaymentProgress = false
        }
    }
}
