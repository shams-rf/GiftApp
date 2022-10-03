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
    
    var body: some View {
        
        VStack {
            
            Text("Add Product")
                .font(.largeTitle)
                .bold()
            
            Image("package")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
            
            Form {
                
                Section {
                    
                    TextField("Name", text: $name)
                    
                    TextField("Description", text: $description)
                    
                    TextField("Price", text: $price)
                }
                
                if errorMessage != nil {
                    
                    Section {
                        
                        Text(errorMessage!)
                    }
                }
                
                Button("Submit") {
                    
                    if(name != "" && description != "" && price != "") {
                        
                        model.addProduct(UID: currentBusinessUID, name: name, description: description, price: price)
                        
                        formShowing = false
                    }
                    else {
                        
                        errorMessage = "Missing field"
                    }
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
