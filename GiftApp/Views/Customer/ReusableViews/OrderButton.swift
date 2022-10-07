//
//  OrderButton.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 06/10/2022.
//

import SwiftUI

struct OrderButton: View {
    var body: some View {
        
        Rectangle()
            .frame(width: 150, height: 60, alignment: .center)
            .foregroundColor(.blue)
            .cornerRadius(30)
            .shadow(color: .gray, radius: 10, x: 10, y: 10)
    }
}

struct OrderButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderButton()
    }
}
