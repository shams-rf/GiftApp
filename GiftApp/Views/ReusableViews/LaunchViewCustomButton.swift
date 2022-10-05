//
//  LaunchViewCustomButton.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 05/10/2022.
//

import SwiftUI

struct LaunchViewCustomButton: View {
    var body: some View {
        
        Rectangle()
            .foregroundColor(.blue)
            .frame(width: 150, height: 60)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10, x: 10, y: 10)
    }
}

struct LaunchViewCustomButton_Previews: PreviewProvider {
    static var previews: some View {
        LaunchViewCustomButton()
    }
}
