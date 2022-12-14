//
//  AddProductView.swift
//  GiftApp
//
//  Created by Shamsuddin Refaei on 03/10/2022.
//

import SwiftUI
import FirebaseAuth

struct AddProductView: View {
    
    @Binding var formShowing: Bool
    
    @EnvironmentObject var model: ContentModel
    
    @State private var name = ""
    @State private var description = ""
    @State private var price = ""
    @State private var errorMessage: String?
    
    var currentBusinessUID = Auth.auth().currentUser?.uid ?? ""
    
    @State var showImagePicker = false
    @State var image: UIImage?
    
    var body: some View {
        
        VStack {
            
            Text("Add Product")
                .font(Font.custom("Comfortaa-Bold", size: 30))
            
            Image("package")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Form {
                
                Section {
                    
                    if let image = self.image {
                        
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(5)
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                    
                    Button(action: {
                        
                        showImagePicker = true
                    }, label: {
                        
                        Text("Add Image")
                            .font(Font.custom("Comfortaa-Bold", size: 15))
                    })
                    .sheet(isPresented: $showImagePicker, onDismiss: nil) {
                        
                        ImagePicker(image: $image)
                    }
                }
                
                Section {
                    
                    TextField("Name", text: $name)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                    
                    TextField("Description", text: $description)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                    
                    TextField("Price", text: $price)
                        .font(Font.custom("Comfortaa-Regular", size: 15))
                }
                
                if errorMessage != nil {
                    
                    Section {
                        
                        Text(errorMessage!)
                            .font(Font.custom("Comfortaa-Regular", size: 15))
                    }
                }
                
                Button {
                    
                    if(name != "" && description != "" && price != "" && image != nil) {
                        
                        model.addProduct(UID: currentBusinessUID, name: name, description: description, price: price, image: image!)
                        
                        formShowing = false
                    }
                    else {
                        
                        errorMessage = "Missing field"
                    }
                } label: {
                    
                    Text("Submit")
                        .font(Font.custom("Comfortaa-Bold", size: 15))
                }
            }
            .cornerRadius(10)
        }
        .padding()
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView(formShowing: .constant(Bool(true)))
            .environmentObject(ContentModel())
    }
}
