//
//  PlaceOrder.swift
//  Tap
//
//  Created by Michael Chen on 4/13/23.
//

import SwiftUI

struct Cart: View {
    @ObservedObject var order: Order
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(order.merchant.name)
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
                ForEach(order.items.indices.sorted(by: <), id: \.self) { index in
                    HStack() {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(order.items[index].0.name).foregroundColor(.black).font(Font.custom("Lexend", size: 16))
                            Text(String(format: "$%.2f", order.items[index].0.originalPrice)).foregroundColor(.black).font(Font.custom("Lexend", size: 16)).strikethrough(true) + Text(String(format: " $%.2f", order.items[index].0.originalPrice * (1 - order.merchant.discountPercent / 100))).font(Font.custom("Lexend", size: 16)).foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                        }
                        Spacer()
                        Text(String(order.items[order.items[index].0] ?? 0))
                            .font(Font.custom("Lexend", size: 14)).foregroundColor(.black)
                    }
                    .padding([.leading, .trailing], 16)
                    .padding(.trailing, 8)
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
                    Text(String(format: "Total: $%.2f", order.getTotal()))
                        .font(Font.custom("Lexend-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 36)
                        .padding(.bottom, 12)
                    Button() {} label: {
                        Text("Pay")
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

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart(order: Order(
            _merchant: Merchant(name: "Bread Bank", location: "Exeter", discountPercent: 6), _items: [
                MenuItem(name: "Tortilla", originalPrice: 1.50): 1,
                MenuItem(name: "Crackers", originalPrice: 0.99): 3,
            ]))
    }
}
