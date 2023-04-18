//
//  PlaceOrder.swift
//  Tap
//
//  Created by Michael Chen on 4/13/23.
//

import SwiftUI

public struct MenuItem: Identifiable, Hashable {
    let name: String
    let originalPrice: Float
    public var id: String { name }
}

struct PlaceOrder: View {
    var shopName: String
    var discountPercent: Float
    @ObservedObject var order: Order
    @EnvironmentObject var customerInfo: CustomerInfo
    
    @State private var menuItems: [MenuItem] = [
        MenuItem(name: "Gluten-Free White Bread", originalPrice: 3.00),
        MenuItem(name: "Potato Bread", originalPrice: 2.50),
        MenuItem(name: "Tortilla", originalPrice: 1.50),
        MenuItem(name: "Crackers", originalPrice: 0.99),
    ]
    
    @State var isReadyToCheckout: Bool = false;
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(shopName)
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
                ForEach(menuItems.indices, id: \.self) { index in
                    Button() {
                        if let num = order.items[menuItems[index]] {
                            order.items.updateValue(num+1, forKey: menuItems[index])
                        } else {
                            order.items.updateValue(1, forKey: menuItems[index])
                        }
                    } label: {
                        HStack() {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(menuItems[index].name).foregroundColor(.black).font(Font.custom("Lexend", size: 16))
                                Text(String(format: "$%.2f", menuItems[index].originalPrice)).foregroundColor(.black).font(Font.custom("Lexend", size: 16)).strikethrough(true) + Text(String(format: " $%.2f", menuItems[index].originalPrice * (1 - discountPercent / 100))).font(Font.custom("Lexend", size: 16)).foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            }
                            Spacer()
                            HStack() {
                                Button() {
                                    if let num = order.items[menuItems[index]] {
                                        if (num > 0) {
                                            order.items.updateValue(num-1, forKey: menuItems[index])
                                        }
                                    }
                                } label: {
                                    Text("-")
                                        .font(Font.custom("Lexend", size: 16)).foregroundColor(.black)
                                }
                                Text(String(order.items[menuItems[index]] ?? 0))
                                    .font(Font.custom("Lexend", size: 14)).foregroundColor(.black)
                                Button() {
                                    if let num = order.items[menuItems[index]] {
                                        order.items.updateValue(num+1, forKey: menuItems[index])
                                    } else {
                                        order.items.updateValue(1, forKey: menuItems[index])
                                    }
                                } label: {
                                    Text("+")
                                        .font(Font.custom("Lexend", size: 16)).foregroundColor(.black)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .frame(width: 64)
                                    .shadow(color: .black, radius: 1)
                            )
                        }
                        .padding([.leading, .trailing], 16)
                        .padding(.trailing, 8)
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
                    Button() {
                        isReadyToCheckout = true
                    } label: {
                        Text("Checkout")
                            .font(Font.custom("Lexend-Bold", size: 18))
                            .foregroundColor(.white)
                    }
                    .frame(width: 240)
                    .padding()
                    .background(tapPurple)
                    .clipShape(Capsule())
                }
            }
        }
        .navigationDestination(isPresented: $isReadyToCheckout) {
            Cart(order: order)
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

struct PlaceOrder_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PlaceOrder(shopName: "Bread Bank", discountPercent: 6, order: Order())
                .environmentObject(CustomerInfo())
        }
    }
}
