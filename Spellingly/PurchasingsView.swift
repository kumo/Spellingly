//
//  PurchasingsView.swift
//  Spellingly
//
//  Created by Robert Clarke on 19/07/22.
//

import SwiftUI
import RevenueCat

struct PurchasingsView: View {
    private var subscriptionManager: IAPManager = IAPManager.shared
    
    var body: some View {
        VStack {
            Text("Tip Jar")
                .font(.largeTitle)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("If you like this app, please consider leaving a tip to show you appreciation and help cover development costs! Any tip at all helps a lot!")
                    .fontWeight(.semibold)
            }
            .padding()
            
            ScrollView {
                ForEach(subscriptionManager.packages, id: \.identifier) { package in
                    Button(action: {
                        subscriptionManager.purchase(package: package)
                    }) {
                        IAPRow(package: package)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct IAPRow: View {
    var package: Package
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(package.storeProduct.localizedTitle).bold()
                Text(package.storeProduct.localizedDescription)
            }
            
            Spacer()
            
            Text(package.localizedPriceString).bold()
        }
        .foregroundColor(.primary)
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
struct PurchasingsView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasingsView()
    }
}
