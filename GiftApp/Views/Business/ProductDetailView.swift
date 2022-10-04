//
//  ProductDetailView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 03/10/2022.
//

import SwiftUI
import FirebaseStorage

struct ProductDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var product: Product
    var businessUID: String
    @State var image: UIImage?
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 10) {
                
                if let image = image {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                
                Text(product.name)
                    .font(.title)
                    .bold()
                    .padding(.leading)
                
                Text(product.description)
                    .padding(.leading)
                
                Text("€\(product.price)")
                    .padding(.leading)
            }
            
            Spacer()
            
            Button {
                
                
            } label: {
                
                ZStack(alignment: .center) {
                    
                    Rectangle()
                        .frame(width: 150, height: 60, alignment: .center)
                        .foregroundColor(.red)
                        .cornerRadius(30)
                        .shadow(color: .gray, radius: 10, x: 10, y: 10)
                    
                    Text("Edit")
                }
            }
            .tint(.white)
        }
        .onAppear {
            
            getImage(productID: product.id, businessUID: businessUID)
        }
    }
    
    func getImage(productID: String, businessUID: String) {
        
        let ref = Storage.storage().reference().child("\(businessUID)/\(productID)")
        
        ref.downloadURL { url, error in
            
            if error == nil && url != nil {
                
                let data = try! Data(contentsOf: url!)
                let image = UIImage(data: data as Data)
                self.image = image
            }
            else {
                
                print(error!.localizedDescription)
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(id: "", business: "", name: "Roses", description: "Red roses freshly picked", price: "4.99"), businessUID: "")
            .environmentObject(ContentModel())
    }
}
