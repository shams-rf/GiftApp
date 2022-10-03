//
//  ProductSection.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 03/10/2022.
//

import SwiftUI

struct ProductSection: View {
    
    var product: Product
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .frame(height: 50)
                .foregroundColor(.gray)
                .cornerRadius(10)
            
            HStack {
                
                Image(systemName: "house")
                
                Text(product.name)
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

struct ProductSection_Previews: PreviewProvider {
    static var previews: some View {
        ProductSection(product: Product(id: "", business: "", name: "Roses", description: "", price: ""))
    }
}
