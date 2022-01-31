//
//  ManetasFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductManetasView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 12

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
            label: {
                HStack {
                    Text("Manetas")
                    Spacer()
                    Text(productVM.manetas)
                }
            }
        )
    }
}

struct ProductManetasFormView: View {
    
    var atributo = "Manetas"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.manetas) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                save()
                presentationMode.wrappedValue.dismiss()
            }
        }.onDisappear {
            save()
        }
    }
    
    func save() {
        if productVM.otro != "" {
            productVM.manetas = productVM.otro
            productVM.otro = ""
        }
        
        if productVM.anotacion != "" {
            productVM.manetas = productVM.manetas + " (\(productVM.anotacion))"
            productVM.anotacion = ""
        }
        
        productVM.save()
    }
}
