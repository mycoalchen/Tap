//
//  PlaceOrder.swift
//  Tap
//
//  Created by Michael Chen on 4/13/23.
//

import SwiftUI

struct PlaceOrder: View {
    var shopName: String
    var discountPercent: Float
    
    struct MenuItem: Identifiable {
        let name: String
        let originalPrice: Float
        var amount: Int
        var id: String { name }
        
        mutating func increment() {
            amount += 1
        }
        mutating func decrement() {
            if (amount > 0) { amount -= 1 }
        }
    }
    
    @State private var menuItems: [MenuItem] = [
        MenuItem(name: "Gluten-Free White Bread", originalPrice: 3.00, amount: 0),
        MenuItem(name: "Potato Bread", originalPrice: 2.50, amount: 0),
        MenuItem(name: "Tortilla", originalPrice: 1.50, amount: 0),
        MenuItem(name: "Crackers", originalPrice: 0.99, amount: 0),
    ]
    
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
                        
                    } label: {
                        HStack() {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(menuItems[index].name).foregroundColor(.black).font(Font.custom("Lexend", size: 16))
                                Text(String(format: "%.2f", menuItems[index].originalPrice)).foregroundColor(.black).font(Font.custom("Lexend", size: 16)).strikethrough(true) + Text(String(format: " %.2f", menuItems[index].originalPrice * (1 - discountPercent / 100))).font(Font.custom("Lexend", size: 16)).foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            }
                            Spacer()
                            HStack() {
                                Button() {
                                    menuItems[index].decrement()
                                } label: {
                                    Text("-")
                                        .font(Font.custom("Lexend", size: 16)).foregroundColor(.black)
                                }
                                Text(String(menuItems[index].amount))
                                    .font(Font.custom("Lexend", size: 14)).foregroundColor(.black)
                                Button() {
                                    menuItems[index].increment()
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
                    Text("Balance: $50.00")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 36)
                        .padding(.bottom, 12)
                    Button() {} label: {
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
        .ignoresSafeArea(edges: [.bottom])
    }
    
}

struct PlaceOrder_Previews: PreviewProvider {
    static var previews: some View {
        PlaceOrder(shopName: "Bread Bank", discountPercent: 6)
    }
}
