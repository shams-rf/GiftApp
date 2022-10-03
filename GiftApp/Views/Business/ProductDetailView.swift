//
//  ProductDetailView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 03/10/2022.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(product.name)
                .font(.title)
                .bold()
            
            Text(product.description)
            
            Text("€\(product.price)")
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(id: "", business: "", name: "Roses", description: "Red roses freshly picked", price: "4.99"))
    }
}
