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
                        Text("Curva")
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
    
    @State var valor: String = ""
    @State var otro: String = ""
    @State var anotacion: String = ""

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Tipo")) {
                    Picker("Tipo", selection: $valor) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear{
            if valor == "" {
                valor = productVM.getAttributeValue(attribute_data: productVM.curvas, select_atributte: "Valor")
            }
        }.toolbar {
            Button("Guardar") {
                var resultado: [String] = []
                
                if valor != "" {
                    resultado.append(valor)
                }
                
                if anotacion != "" {
                    resultado.append("(\(anotacion))")
                }
                
                productVM.curvas = resultado.joined(separator: "\n")
                
                if otro != "" {
                    productVM.curvas = "\""+otro+"\""
                    if anotacion != "" {
                        productVM.curvas += "\n(\(anotacion))"
                    }
                }

                productVM.save()
                presentationMode.wrappedValue.dismiss()
                
            }
        }
    }
}
