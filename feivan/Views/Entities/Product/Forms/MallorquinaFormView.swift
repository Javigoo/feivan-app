//
//  MallorquinaFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductMallorquinaView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 16

    var body: some View {
        if productVM.showIf(equalTo: ["Persianas"]) {
            NavigationLink(
                destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
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
                
                Toggle("Tubo", isOn: $tubo)
                
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
                valor = productVM.getAttributeValue(attribute_data: productVM.persiana, select_atributte: "Valor")
            }
            if !tubo {
                tubo = Bool(productVM.getAttributeValue(attribute_data: productVM.persiana, select_atributte: "Con tubo")) ?? false
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.persiana, select_atributte: "Anotacion")
            }
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.persiana, select_atributte: "Otro")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !otro.isEmpty {
            productVM.persiana = "\""+otro+"\""
        } else {
            if !valor.isEmpty {
                resultado.append(valor)
            }
            
            if tubo {
                resultado.append("Con tubo")
            }
            
            if !anotacion.isEmpty {
                resultado.append("(\(anotacion))")
            }
            
            productVM.persiana = resultado.joined(separator: "\n")
        }

        productVM.save()
    }
}

