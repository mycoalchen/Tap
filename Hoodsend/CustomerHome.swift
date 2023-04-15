//
//  CustomerHome.swift
//  Hoodsend
//
//  Created by Michael Chen on 4/12/23.
//

import SwiftUI

struct CustomerHome: View {
    struct Merchant: Identifiable {
        let name: String
        let location: String
        let balance: Float
        var id: String { name + " - " + location }
    }
    
    private let merchants: [Merchant] = [
        Merchant(name: "Lexie's", location: "Exeter", balance: 60.50),
        Merchant(name: "Szechuan Taste", location: "Exeter", balance: 40.32),
        Merchant(name: "Romero's Pizza", location: "Exeter", balance: 50.00),
    ]
    
    @State var selectedMerchant: Merchant = Merchant(name: "", location: "", balance: 0);
    @State var isMerchantSelected: Bool = false;
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("Shops")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 36)
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                    ZStack {
                        Circle()
                            .stroke(tapPurple, lineWidth: 0)
                            .background(Circle().foregroundColor(tapPurple))
                        Text("ME")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding(.all, 8)
                    }
                    .padding(.trailing, 60)
                    .frame(width: 35, height: 35)
                }
                Rectangle()
                    .fill(.black)
                    .frame(width: UIScreen.screenWidth - 48, height: 0.75)
                Spacer(minLength: 12)
                ScrollView {
                    ForEach(merchants) { merchant in
                        Button() {
                            selectedMerchant = merchant
                            isMerchantSelected = true
                        } label: {
                            HStack() {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(merchant.name).foregroundColor(.black).fontWeight(.bold)
                                    Text(merchant.location).foregroundColor(.black)
                                }
                                Spacer()
                                Text("$\(merchant.balance, specifier: "%.2f")")
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                Spacer(minLength: 24)
                Button() {} label: {
                    Text("Add Merchant")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 1, green: 1, blue: 1))
                }
                .padding()
                .background(tapPurple)
                .clipShape(Capsule())
                Spacer()
            }
            .navigationDestination(isPresented: $isMerchantSelected) {
                PlaceOrder(shopName: selectedMerchant.name, balance: selectedMerchant.balance)
            }
        }
    }
}

struct CustomerHome_Previews: PreviewProvider {
    static var previews: some View {
        CustomerHome()
    }
}
