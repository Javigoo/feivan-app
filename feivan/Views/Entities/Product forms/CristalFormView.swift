//
//  CristalFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductCristalView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        if productVM.notShowIf(familias: ["Persiana"]) {
            NavigationLink(
                destination: ProductCristalFormView(productVM: productVM),
                label: {
                    HStack {
                        Text("Cristal")
                        Spacer()
                        Text(productVM.cristal)
                    }
                }
            )
        }
    }
}

struct ProductCristalFormView: View {
    
    var atributo = "Cristal"
    @ObservedObject var productVM: ProductViewModel
    
    @State var opcion: String = ""
    
    @State var camaras: String = ""
    @State var seguridad: String = ""
    
    @State var tonalidad: String = ""
    
    @State var silence: Bool = false
    @State var acustico: Bool = false
    @State var templado: Bool = false

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker("Opciones", selection: $opcion) {
                        List(["Cámaras", "Seguridad"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if opcion == "Cámaras" {
                    Section(header: Text("Cámaras")) {
                        Picker("Cámaras", selection: $camaras) {
                            List(["4/?/4", "4/?/6", "6/?/6", "4/?/3+3", "6/?/3+3", "4/?/4+4", "6/?/4+4", "3+3/?/3+3", "4+4/?/4+4"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.wheel)
                    }
                } else if opcion == "Seguridad" {
                    Section(header: Text("Seguridad")) {
                        Picker("Seguridad", selection: $seguridad) {
                            List(["3+3", "4+4", "5+5", "6+6", "8+8"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                
                Section(header: Text("Tonalidad del vidrio")) {
                    Picker("Tonalidad del vidrio", selection: $tonalidad) {
                        List(["Mate", "Carglass"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Composición")) {
                    Toggle("Silence", isOn: $silence)
                    Toggle("Guardian sun", isOn: $acustico)
                    Toggle("Templado", isOn: $templado)
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
                
                var resultado: [String] = []

                if opcion == "Cámaras" {
                    resultado.append("Cámaras: \(camaras)")
                }
                
                if opcion == "Seguridad" {
                    resultado.append("Seguridad: \(seguridad)")
                }
                
                if tonalidad != "" {
                    resultado.append("Tonalidad: \(tonalidad)")
                }
                
                if silence || acustico || templado {
                    resultado.append("Composición:")
                    
                    if silence {
                        resultado.append("Silence")
                    }
                    if acustico {
                        resultado.append("Guardian sun")
                    }
                    if templado {
                        resultado.append("Templado")
                    }
                }
                    
                productVM.cristal = resultado.joined(separator: "\n")

                if productVM.otro != "" {
                    productVM.cristal = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.cristal = productVM.cristal + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
