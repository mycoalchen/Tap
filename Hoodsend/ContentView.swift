//
//  ContentView.swift
//  Hoodsend
//
//  Created by Michael Chen on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10)
            {
            Text("Welcome to Hoodsend!")
                .font(.system(size: 40))
                .multilineTextAlignment(.center)
                .padding([.bottom], 40)
            Text("I'm a...")
                .font(.system(size: 30))
                .padding([.bottom], 20)
            HStack {
                Button(action: {print("Merchant")}) {
                    Text("Merchant")
                        .foregroundColor(Color(red: 1, green: 1, blue: 1))
                        .font(.system(size: 25))
                }
                .padding()
                .background(Color(red: 0.5, green: 0.0, blue: 0.5))
                .clipShape(Capsule())
                Button(action: {print("Cusomter")}) {
                    Text("Customer")
                        .font(.system(size: 25))
                        .foregroundColor(Color(red: 1, green: 1, blue: 1))
                }
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 0))
                .clipShape(Capsule())
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
