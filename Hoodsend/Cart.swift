//
//  PlaceOrder.swift
//  Tap
//
//  Created by Michael Chen on 4/13/23.
//

import SwiftUI

struct Cart: View {
    var shopName: String
    var balance: Float
    
    struct MenuItem: Identifiable {
        let name: String
        let originalPrice: Float
        var amount: Int { 0 }
        var id: String { name }
    }
    
    private let menuItems: [MenuItem] = [
        MenuItem(name: "Gluten-Free White Bread", originalPrice: 3.00),
        MenuItem(name: "Potato Bread", originalPrice: 2.50),
        MenuItem(name: "Tortilla", originalPrice: 1.50),
        MenuItem(name: "Crackers", originalPrice: 0.99),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Cart")
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
                ForEach(menuItems) { menuItem in
                    Button() {
                        
                    } label: {
                        HStack() {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(menuItem.name).foregroundColor(.black).font(Font.custom("Lexend", size: 16))
                                Text(String(menuItem.originalPrice)).foregroundColor(.black).font(Font.custom("Lexend", size: 16))
                            }
                            Spacer()
                            Text("Hoes mad")
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
                    Text("Total: $10.00")
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 36)
                        .padding(.bottom, 12)
                    
                }
            }
        }
        .ignoresSafeArea(edges: [.bottom])
    }
    
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart(shopName: "Chipotle", balance: 66)
    }
}
