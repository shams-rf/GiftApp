//
//  ProductSection.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 03/10/2022.
//

import SwiftUI
import FirebaseStorage

struct ProductSection: View {
    
    @EnvironmentObject var model:ContentModel
    
    var product: Product
    var businessUID: String
    @State var image: UIImage?
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(Constants.pastelRed)
                .cornerRadius(10)
            
            HStack {
                
                Text(product.name)
                    .font(Font.custom("Comfortaa-Regular", size: 15))
                
                Spacer()
                
                if let image = image {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .frame(height: 80)
        .onAppear(perform: {
            
            getImage(productID: product.id, businessUID: businessUID)
        })
    }
    
    func getImage(productID: String, businessUID: String) {
        
        let ref = Storage.storage().reference().child("\(businessUID)/\(productID)")
        
        ref.downloadURL { url, error in
            
            if error == nil && url != nil {
                
                do {
                    
                    let data = try Data(contentsOf: url!)
                    let image = UIImage(data: data as Data)
                    self.image = image
                }
                catch {
                    
                    print(error.localizedDescription)
                }
            }
            else {
                
                print(error!.localizedDescription)
            }
        }
    }
}

struct ProductSection_Previews: PreviewProvider {
    static var previews: some View {
        ProductSection(product: Product(id: "", business: "", name: "Roses", description: "", price: ""), businessUID: "")
            .environmentObject(ContentModel())
    }
}
