//
//  CustomerHome.swift
//  Tap
//
//  Created by Michael Chen on 4/12/23.
//

import SwiftUI

public class CustomerInfo: ObservableObject {
    @Published var balance: Float = 50
}

// Stores a map representing the user's current order
class Order: ObservableObject {
    @Published var merchant = Merchant(name: "Starbucks", location: "Exeter", discountPercent: 5)
    @Published var items = [MenuItem: Int]()
    
    init() {}
    init(_merchant: Merchant, _items: [MenuItem: Int]) {
        merchant = _merchant
        items = _items
    }
    
    func getTotal() -> Float {
        var total: Float = 0
        for (menuItem, num) in items {
            total += menuItem.originalPrice * (1 - merchant.discountPercent / 100) * Float(num)
        }
        return total
    }
    func clearItems() {
        items = [MenuItem: Int]()
    }
    
}

public struct Merchant: Identifiable {
    let name: String
    let location: String
    let discountPercent: Float
    public var id: String { name + " - " + location }
}

struct CustomerHome: View {
    
    @ObservedObject var order = Order()
    @EnvironmentObject var customerInfo: CustomerInfo
    
    private let merchants: [Merchant] = [
        Merchant(name: "Starbucks", location: "Exeter, NH", discountPercent: 5),
        Merchant(name: "McDonald's", location: "Exeter, NH", discountPercent: 5),
    ]
    
    let starbucksMenu = [
        MenuItem(name: "Espresso", originalPrice: 5.50),
        MenuItem(name: "Havana Cappuccino", originalPrice: 3.40),
        MenuItem(name: "Caffe Latte", originalPrice: 6.00),
    ]
    let mcDonaldsMenu = [
        MenuItem(name: "Big Mac", originalPrice: 5.15),
        MenuItem(name: "Quarter Pounder", originalPrice: 3.99),
        MenuItem(name: "Chicken McNuggets (10 Pc.)", originalPrice: 4.49),
        MenuItem(name: "French Fries (Small)", originalPrice: 1.39),
    ]
        
    @State var selectedMerchant: Merchant = Merchant(name: "", location: "", discountPercent: 0);
    @State private var isMerchantSelected: Bool = false;
    @State private var showingDeposit = false;
    
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
                    Text("Balance: $\(customerInfo.balance, specifier: "%.2f")")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 36)
                        .padding(.bottom, 12)
                    HStack(spacing: 18) {
                        Button() {
                            showingDeposit.toggle()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Deposit")
                                    .font(Font.custom("Lexend-Bold", size: 18))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .frame(width: 120)
                        .padding()
                        .background(tapPurple)
                        .clipShape(Capsule())
                        Button() {
                            
                        } label: {
                            HStack {
                                Spacer()
                                Text("Transfer")
                                    .font(Font.custom("Lexend-Bold", size: 18))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        .frame(width: 120)
                        .padding()
                        .background(.white)
                        .clipShape(Capsule())
                    }
                    .sheet(isPresented: $showingDeposit) {
                        Deposit()
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isMerchantSelected) {
            PlaceOrder(shopName: selectedMerchant.name, discountPercent: selectedMerchant.discountPercent, order: order, menuItems: (selectedMerchant.name == "Starbucks") ? starbucksMenu : mcDonaldsMenu)
                .environmentObject(customerInfo)
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct CustomerHome_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CustomerHome()
                .environmentObject(CustomerInfo())
        }
    }
}
