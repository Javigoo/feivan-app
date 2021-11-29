//
//  CurvasFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductCurvasView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        if productVM.showIf(equalTo: ["Curvas"]) {
            NavigationLink(
                destination: ProductCurvasFormView(productVM: productVM),
                label: {
                    HStack {
                        Text("Curvas")
                        Spacer()
                        Text(productVM.curvas)
                    }
                }
            )
        }
    }
}

struct ProductCurvasFormView: View {
    
    var atributo = "Curva"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.curvas) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                }
                                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                if productVM.especifico != "" {
                    productVM.curvas = productVM.especifico
                    productVM.especifico = ""
                }
                
                if productVM.otro != "" {
                    productVM.curvas = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.curvas = productVM.curvas + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
