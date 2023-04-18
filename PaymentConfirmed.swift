//
//  PaymentConfirmed.swift
//  Tap
//
//  Created by Michael Chen on 4/18/23.
//

import SwiftUI

struct PaymentConfirmed: View {
    @State var amount: Float
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.green)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                Text("Payment Successful!")
                    .foregroundColor(.white)
                    .font(Font.custom("Lexend-bold", size: 40))
                    .padding(.horizontal, 16)
                    .multilineTextAlignment(.center)
                Text("\nAmount: $\(amount, specifier: "%.2f")")
                    .foregroundColor(.white)
                    .font(Font.custom("Lexend-bold", size: 32))
                    .padding(.horizontal, 16)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct PaymentConfirmed_Previews: PreviewProvider {
    static var previews: some View {
        PaymentConfirmed(amount: 20)
    }
}
