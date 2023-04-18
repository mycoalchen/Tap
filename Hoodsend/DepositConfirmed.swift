//
//  depositconfirmed.swift
//  Tap
//
//  Created by Michael Chen on 4/18/23.
//

import SwiftUI

struct DepositConfirmed: View {
    @State var amount: Float
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.green)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                Text("Deposit Successful!")
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

struct DepositoConfirmed_Previews: PreviewProvider {
    static var previews: some View {
        DepositConfirmed(amount: 20)
    }
}
