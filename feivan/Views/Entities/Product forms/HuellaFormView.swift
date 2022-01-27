//
//  HuellaFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductHuellaView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 8

    var body: some View {
    
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
            label: {
                HStack {
                    Text("Huella")
                    Spacer()
                    Text(productVM.huella)
                }
            }
        )
    }
}

struct ProductHuellaFormView: View {
    
    var atributo = "Huella"
    @ObservedObject var productVM: ProductViewModel
    
    @State var huella: String = ""
     
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Huella"), footer: Text("Unidad de medida: mm")) {
                    TextField("Huella", text: $huella)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
                productVM.huella = huella + " mm"
                
                if productVM.anotacion != "" {
                    productVM.huella = productVM.huella + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
