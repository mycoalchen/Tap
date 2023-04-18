//
//  Transfer.swift
//  Tap
//
//  Created by Michael Chen on 4/13/23.
//

import SwiftUI

public struct TapUser: Identifiable, Hashable {
    let name: String
    let username: String
    public var id: String { username }
}

struct Transfer: View {
    @EnvironmentObject var customerInfo: CustomerInfo
    
    @State private var friends: [TapUser] = [
        TapUser(name: "Alice", username: "alice111"),
        TapUser(name: "Bob", username: "b0b"),
        TapUser(name: "Eve", username: "muhuhahaha"),
    ]
        
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Transfer")
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
                ForEach(friends.indices, id: \.self) { index in
                    Text(friends[index].name + " - " + friends[index].username)
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

struct Transfer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Transfer()
                .environmentObject(CustomerInfo())
        }
    }
}
