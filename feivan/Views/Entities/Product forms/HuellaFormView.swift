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
    
    @State var valor: String = ""
    @State var anotacion: String = ""

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Huella"), footer: Text("Unidad de medida: mm")) {
                    TextField("Huella", text: $valor)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            if valor.isEmpty {
                valor = productVM.getAttributeValue(attribute_data: productVM.huella, select_atributte: "Valor").components(separatedBy: " ")[0]
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.huella, select_atributte: "Anotacion")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !valor.isEmpty {
            resultado.append("\(valor) mm")
        }
        
        if !anotacion.isEmpty {
            resultado.append("(\(anotacion))")
        }
        
        productVM.huella = resultado.joined(separator: "\n")
        
        productVM.save()
    }
}
