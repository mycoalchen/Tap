//
//  MerchantHome.swift
//  Hoodsend
//
//  Created by Michael Chen on 4/12/23.
//

import SwiftUI

struct MerchantHome: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Merchant Home")
                .font(.system(size: 36))
                .fontWeight(.black)
                .underline(true)
                .padding(.bottom, 24)
            
            Text("Your QR Code:")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.bottom, 24)
            Image("Fake QR Code")
                .resizable()
                .frame(width: 300, height: 300)
                .border(.black, width: 4)
                .padding(.bottom, 24)
            
            Text("Orders:")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
    }
}

struct MerchantHome_Previews: PreviewProvider {
    static var previews: some View {
        MerchantHome()
    }
}
