//
//  MaterialFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductMaterialView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 2

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
            label: {
                HStack {
                    Text("Material")
                    Spacer()
                    Text(productVM.material)
                }
            }
        )
    }
}

struct ProductMaterialFormView: View {
    
    var atributo = "Material"
    @ObservedObject var productVM: ProductViewModel

    @State var valor: String = ""
    @State var serie: String = ""
    
    @State var otro: String = ""
    @State var anotacion: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Opciones")) {
                    Picker("Opciones", selection: $valor) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if valor == "Aluminio" {
                    if productVM.showIf(equalTo: ["Correderas"]) {
                        Section(header: Text("Series")) {
                            Picker("Serie", selection: $serie) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Correderas"), id: \.self) { item in
                                    Text(item)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                    if productVM.showIf(equalTo: ["Practicables"]) {
                        Section(header: Text("Series")) {
                            Picker("Serie", selection: $serie) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Ventanas"), id: \.self) { item in
                                    Text(item)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
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
                valor = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Valor")
            }
            if serie.isEmpty {
                serie = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Serie")
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Anotacion")
            }
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Otro")
            }
        }.onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !otro.isEmpty {
            productVM.material = "\""+otro+"\""
        } else {
            if !valor.isEmpty {
                resultado.append(valor)
            }
            
            if valor == "Aluminio" && !serie.isEmpty {
                resultado.append("Serie: \(serie)")
            }
            
            if !anotacion.isEmpty {
                resultado.append("(\(anotacion))")
            }
            
            productVM.material = resultado.joined(separator: "\n")
        }

        productVM.save()
    }
}


