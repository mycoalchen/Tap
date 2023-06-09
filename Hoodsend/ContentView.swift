//
//  ContentView.swift
//  Tap
//
//  Created by Michael Chen on 4/11/23.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

var tapPurple: Color = Color(red:0.6, green: 0, blue: 1)

struct ContentView: View {
    @State var customer: Bool = false
    @State var merchant: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("Welcome to Tap!")
                    .font(Font.custom("Lexend-Bold", size: 36))
                    .multilineTextAlignment(.center)
                    .padding([.bottom], 18)
                Text("I'm a...")
                    .font(Font.custom("Lexend", size: 30))
                    .padding([.bottom], 18)
                VStack {
                    Button() { customer = true } label: {
                        Text("Customer")
                            .font(Font.custom("Lexend-Medium", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 1, green: 1, blue: 1))
                    }
                    .padding()
                    .background(tapPurple)
                    .clipShape(Capsule())
                    Button() { merchant = true } label: {
                        Text("Merchant")
                            .font(Font.custom("Lexend-Medium", size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 1, green: 1, blue: 1))
                    }
                    .padding()
                    .background(.gray)
                    .clipShape(Capsule())
                }
            }
            .padding()
            .navigationDestination(isPresented: $customer) {
                CustomerHome()
                    .environmentObject(CustomerInfo())
            }
            .navigationDestination(isPresented: $merchant) {
                MerchantHome()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
