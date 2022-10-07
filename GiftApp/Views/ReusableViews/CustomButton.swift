//
//  CustomButton.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 30/09/2022.
//

import SwiftUI

struct CustomButton: View {
    var body: some View {
        
        Rectangle()
            .frame(width: 250, height: 60)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 10, y: 10)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
