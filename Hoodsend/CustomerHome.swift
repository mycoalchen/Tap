//
//  CustomerHome.swift
//  Hoodsend
//
//  Created by Michael Chen on 4/12/23.
//

import SwiftUI

// Stores a map representing the user's current order
class Order: ObservableObject {
    @Published var items = [MenuItem: Int]()
}

struct CustomerHome: View {
    struct Merchant: Identifiable {
        let name: String
        let location: String
        let discountPercent: Float
        var id: String { name + " - " + location }
    }
    
    @ObservedObject var order = Order()
    
    private let merchants: [Merchant] = [
        Merchant(name: "Peet's Coffee", location: "Exeter, NH", discountPercent: 5),
        Merchant(name: "McDonald's", location: "Exeter, NH", discountPercent: 5),
        Merchant(name: "Bread Bank", location: "Exeter, NH", discountPercent: 6),
    ]
        
    @State var selectedMerchant: Merchant = Merchant(name: "", location: "", discountPercent: 0);
    @State var isMerchantSelected: Bool = false;
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Shops")
                    .font(Font.custom("Lexend-Bold", size: 24))
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
                                Text(merchant.name).foregroundColor(.black).font(Font.custom("Lexend", size: 16))
                                Text(merchant.location).foregroundColor(.black).font(Font.custom("Lexend", size: 16))
                            }
                            Spacer()
                            Text("\(merchant.discountPercent, specifier: "%.2f")% off")
                                .foregroundColor(Color(red: 0.8, green: 0, blue: 0)).font(Font.custom("Lexend-Bold", size: 16))
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
            ZStack {
                Rectangle()
                    .fill(Color(red: 0.933, green: 0.933, blue: 0.933))
                    .frame(height: UIScreen.screenHeight / 5)
                    .padding(.all, 0)
                VStack {
                    Text("Balance: $50.00")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 36)
                        .padding(.bottom, 12)
                    HStack(spacing: 18) {
                        Button() {} label: {
                            Text("Deposit")
                                .font(Font.custom("Lexend-Bold", size: 18))
                                .foregroundColor(.white)
                        }
                        .frame(width: 120)
                        .padding()
                        .background(tapPurple)
                        .clipShape(Capsule())
                        Button() {
                            print(order.items)
                        } label: {
                            Text("Transfer")
                                .font(Font.custom("Lexend-Bold", size: 18))
                                .foregroundColor(.black)
                        }
                        .frame(width: 120)
                        .padding()
                        .background(.white)
                        .clipShape(Capsule())
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isMerchantSelected) {
            PlaceOrder(shopName: selectedMerchant.name, discountPercent: selectedMerchant.discountPercent, order: order)
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct CustomerHome_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CustomerHome()
        }
    }
}
