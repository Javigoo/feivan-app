//
//  MallorquinaFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductMallorquinaView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        if productVM.showIf(equalTo: ["Persianas"]) {
            NavigationLink(
                destination: ProductMallorquinaFormView(productVM: productVM),
                label: {
                    HStack {
                        Text("Mallorquina")
                        Spacer()
                        Text(productVM.persiana)
                    }
                }
            )
        }
    }
}

struct ProductMallorquinaFormView: View {
    
    var atributo = "Mallorquina"
    @ObservedObject var productVM: ProductViewModel
    
    @State var tubo: Bool = false
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.persiana) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.wheel)
                }
                
                Toggle("Tubo", isOn: $tubo)
                
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
                
                if tubo {
                    productVM.persiana = productVM.persiana + " con tubo"
                }
                
                if productVM.otro != "" {
                    productVM.persiana = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.persiana = productVM.persiana + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

