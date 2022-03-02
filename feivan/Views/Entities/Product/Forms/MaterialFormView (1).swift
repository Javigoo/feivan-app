//
//  MaterialFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductMaterialView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        NavigationLink(
            destination: ProductMaterialFormView(productVM: productVM),
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

    var atributo = "Material"
    @State var opcion: String = ""
    @State var aluminio: String = ""
    @State var otro: String = ""
    @State var anotacion: String = ""
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $opcion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if opcion == "Aluminio" {
                    if productVM.showIf(equalTo: ["Correderas"]) {
                        Section(header: Text("Series")) {
                            Picker("Serie", selection: $aluminio) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Correderas"), id: \.self) { item in
                                    Text(item)
                                }
                            }
                        }
                    }
                    if productVM.showIf(equalTo: ["Practicables"]) {
                        Section(header: Text("Series")) {
                            Picker("Serie", selection: $aluminio) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Ventanas"), id: \.self) { item in
                                    Text(item)
                                }
                            }
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
            //productVM.getMaterial(aluminio: $aluminio)
            let resultado: [String] = productVM.material.components(separatedBy: "\n")
            
            for linea in resultado {
                if linea.contains(":") {
                    let atributo: String = linea.components(separatedBy: ":")[0]
                    let valor: String = linea.components(separatedBy: ":")[1]
                    
                    if atributo == "Serie" {
                        if aluminio == "" {
                            aluminio = valor.trimmingCharacters(in: .whitespaces)
                            print("Aluminio: \(aluminio)")
                        }
                    }
                    
                } else if linea.contains("\"") {
                    if otro == "" {
                        otro = linea.replacingOccurrences(of: "\"", with: "")
                        print("Otro: \(otro)")
                    }
                } else if linea.contains("(") && linea.contains(")") {
                    let first = linea.dropFirst()
                    let second = first.dropLast()
                    if anotacion == "" {
                        anotacion = String(second)
                        print("Anotación: \(anotacion)")
                    }
                } else {
                    if opcion == "" {
                        opcion = linea
                        print("Opción: \(opcion)")
                    }
                }
            }
        }
        .toolbar {
            Button("Guardar") {
                // Específico
                var resultado: [String] = []
                
                if opcion != "" {
                    resultado.append(opcion)
                }
                
                if opcion == "Aluminio" && aluminio != "" {
                    resultado.append("Serie: \(aluminio)")
                }
                
                productVM.material = resultado.joined(separator: "\n")
                
                // Otro
                if otro != "" {
                    productVM.material = "\""+otro+"\""
                }
                
                // Anotación
                if anotacion != "" {
                    productVM.material += "\n(\(anotacion))"
                }

                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

