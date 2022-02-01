//
//  CurvasFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductCurvasView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 1
    
    var body: some View {
        if productVM.showIf(equalTo: ["Curvas"]) {
            NavigationLink(
                destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
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
            print(anotacion)
            if valor.isEmpty {
                valor = productVM.getAttributeValue(attribute_data: productVM.curvas, select_atributte: "Valor")
            }
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.curvas, select_atributte: "Otro")
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.curvas, select_atributte: "Anotacion")
                print(anotacion)
            }
        }.onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !valor.isEmpty {
            resultado.append(valor)
        }
        
        if !anotacion.isEmpty {
            resultado.append("(\(anotacion))")
        }
        
        productVM.curvas = resultado.joined(separator: "\n")
        
        if !otro.isEmpty {
            productVM.curvas = "\""+otro+"\""
            if !anotacion.isEmpty {
                productVM.curvas += "\n(\(anotacion))"
            }
        }

        productVM.save()
    }
}
