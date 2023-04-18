//
//  Deposit.swift
//  Tap
//
//  Created by Michael Chen on 4/17/23.
//

import SwiftUI

struct Deposit: View {
    
    @State private var amount: Float = 20
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var customerInfo: CustomerInfo
    @State private var depositConfirmed = false
    @State private var depositDisabled = false
    
    let formatter = {
        let moneyFormatter = NumberFormatter()
        moneyFormatter.numberStyle = .currency
        moneyFormatter.minimumFractionDigits = 2
        moneyFormatter.maximumFractionDigits = 2
        moneyFormatter.roundingMode = .halfUp
        
        return moneyFormatter
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Deposit")
                .font(Font.custom("Lexend-Bold", size: 24))
                .frame(maxWidth: .infinity)
                .padding(.top, 12)
                .padding(.bottom, 12)
            Rectangle()
                .fill(.black)
                .frame(width: UIScreen.screenWidth - 48, height: 0.75)
            Spacer()
            TextField("", value: $amount, formatter: formatter())
                .keyboardType(UIKeyboardType.decimalPad)
                .font(Font.custom("Lexend", size: 40))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
            HStack() {
                Button() {} label: {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Instant")
                                .font(Font.custom("Lexend-medium", size: 16))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .padding(.vertical, 12)
                .frame(width: 130, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.5))
                Button() {} label: {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("1-3 Biz Days")
                                .font(Font.custom("Lexend-medium", size: 16))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .padding(.vertical, 12)
                .frame(width: 130, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.5))
            }
            .padding(.bottom, 24)
            .padding(.horizontal, 16)
            Button() {
                depositDisabled = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    customerInfo.balance += amount
                    depositConfirmed = true
                }
            } label: {
                HStack {
                    Spacer()
                    Text("Confirm")
                        .font(Font.custom("Lexend-Bold", size: 18))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(width: 240)
            .padding()
            .background(tapPurple)
            .clipShape(Capsule())
            .padding(.bottom, 12)
            .disabled(depositDisabled)
            Button() {
                dismiss()
            } label: {
                HStack {
                    Spacer()
                    Text("Cancel")
                        .font(Font.custom("Lexend-Bold", size: 18))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(width: 240)
            .padding()
            .background(.gray)
            .clipShape(Capsule())
        }
        .sheet(isPresented: $depositConfirmed) {
            DepositConfirmed(amount: amount)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

struct Deposit_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Deposit()
                .environmentObject(CustomerInfo())
        }
    }
}
