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
    
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var atributo = "Material"
    @State var valor: String = ""
    @State var serie: String = ""
    @State var otro: String = ""
    @State var anotacion: String = ""
    
    /*
    init() {
        _otro = State(initialValue: "")
    }
    */
    
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
                                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $otro)
                }
                
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            if valor == "" {
                valor = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Valor")
            }
            if serie == "" {
                serie = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Serie")
            }
            
            // El textfield no se actualiza y no se ve
            /*
            if otro == "" {
                otro = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Otro")
            }
            if anotacion == "" {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.material, select_atributte: "Anotacion")
            }
            */
        }.toolbar {
            Button("Guardar") {
                save()
                presentationMode.wrappedValue.dismiss()
            }
        }.onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if valor != "" {
            resultado.append(valor)
        }
        
        if valor == "Aluminio" && serie != "" {
            resultado.append("Serie: \(serie)")
        }
        
        if anotacion != "" {
            resultado.append("(\(anotacion))")
        }
        
        productVM.material = resultado.joined(separator: "\n")
        
        if otro != "" {
            productVM.material = "\""+otro+"\""
            if anotacion != "" {
                productVM.material += "\n(\(anotacion))"
            }
        }

        productVM.save()
    }
}


