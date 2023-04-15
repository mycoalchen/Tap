//
//  PlaceOrder.swift
//  Tap
//
//  Created by Michael Chen on 4/13/23.
//

import SwiftUI

struct PlaceOrder: View {
    var shopName: String
    var balance: Float
    var body: some View {
        Text(shopName)
    }
    struct MenuItem: Identifiable {
        let name: String
        let price: Float
        var amount: Int { 0 }
        var id: String { name }
    }
    
    private let menuItems: [MenuItem] = [
        MenuItem(name: "Whole Wheat Bread", price: 2.00),
    ]
    
}

struct PlaceOrder_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrder(shopName: "Chipotle", balance: 66)
    }
}
