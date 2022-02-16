//
//  InstalacionFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductInstalacionView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 15

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
            label: {
                HStack {
                    Text("Instalación")
                    Spacer()
                    Text(productVM.instalacion)
                }
            }
        )
    }
}

struct ProductInstalacionFormView: View {
    
    var atributo = "Instalación"
    @ObservedObject var productVM: ProductViewModel
    
    @State var valor: String = ""
    @State var otro: String = ""
    @State var anotacion: String = ""
    
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $valor) {
                        List([""]+productVM.optionsFor(attribute: atributo), id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $anotacion)
                }
                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $otro)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            if valor.isEmpty {
                valor = productVM.getAttributeValue(attribute_data: productVM.instalacion, select_atributte: "Valor")
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.instalacion, select_atributte: "Anotacion")
            }
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.instalacion, select_atributte: "Otro")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !otro.isEmpty {
            productVM.instalacion = "\""+otro+"\""
        } else {
            if !valor.isEmpty {
                resultado.append(valor)
            }
            
            if !anotacion.isEmpty {
                resultado.append("(\(anotacion))")
            }
            
            productVM.instalacion = resultado.joined(separator: "\n")
        }

        productVM.save()
    }
}
