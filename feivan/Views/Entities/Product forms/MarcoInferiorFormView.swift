//
//  MarcoInferiorFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductMarcoInferiorView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        if productVM.notShowIf(familias: ["Fijos", "Correderas"]) {
            NavigationLink(
                destination: ProductMarcoInferiorFormView(productVM: productVM),
                label: {
                    HStack {
                        Text("Marco inferior")
                        Spacer()
                        Text(productVM.marco_inferior)
                    }
                }
            )
        }
    }
}

struct ProductMarcoInferiorFormView: View {
    
    var atributo = "Marco inferior"
    @ObservedObject var productVM: ProductViewModel
    
    @State var empotrado: String = ""
    @State var canalRecogeAgua: Bool = false

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker("Marco Inferior", selection: $productVM.marco_inferior) {
                        if productVM.showIf(equalTo: ["Correderas"]) {
                            List(["Abierto", "Cerrado", "Solera", "Empotrado"], id: \.self) { item in Text(item) }
                        } else if productVM.showIf(equalTo: ["Practicables"]) {
                            List(["Abierto", "Cerrado", "Solera"], id: \.self) { item in Text(item) }
                        } else {
                            List(["Abierto", "Cerrado"], id: \.self) { item in Text(item) }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                if productVM.marco_inferior == "Empotrado" {
                    Section(header: Text("Empotrado")) {
                        Toggle("Canal recoge agua", isOn: $canalRecogeAgua)
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
                
                if canalRecogeAgua {
                    productVM.marco_inferior = productVM.marco_inferior + " con canal recoge agua"
                }
                
                if productVM.otro != "" {
                    productVM.marco_inferior = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.marco_inferior = productVM.marco_inferior + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
