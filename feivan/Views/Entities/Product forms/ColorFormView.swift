//
//  ColorFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductColorView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        NavigationLink(
            destination: ProductColorFormView(productVM: productVM),
            label: {
                HStack {
                    Text("Color")
                    Spacer()
                    Text(productVM.color)
                }
            }
        )
    }
}

struct ProductColorFormView: View {
    
    var atributo = "Color"
    @ObservedObject var productVM: ProductViewModel
    
    @State var opcion: String = ""
    @State var color: String = ""
    @State var bicolor: Bool = false
    @State var exterior: String = ""
    @State var interior: String = ""
    @State var texturado: Bool = false
    @State var mate: Bool = false
    @State var anotacion: String = ""

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker("Tipo de color", selection: $opcion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                }
                
                if opcion == "Ral" {
                    Section(header: Text("Ral")) {
                        TextField("Ral", text: $color)
                    }
                }
                if opcion == "Anonizados" {
                    Section(header: Text("Anonizados")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.optionsFor(attribute: "Anonizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if opcion == "Madera" {
                    Section(header: Text("Madera")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.optionsFor(attribute: "Madera"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if opcion == "Más utilizados" {
                    Section(header: Text("Más utilizados")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.optionsFor(attribute: "Más utilizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                
                Toggle("Bicolor", isOn: $bicolor)
                    .onChange(of: bicolor) { newValue in
                        setBicolor()
                    }
                
                if bicolor {
                    Section(header: Text("Color exterior")) {
                        TextField("Exterior", text: $exterior)
                    }
                    Section(header: Text("Color interior")) {
                        TextField("Interior", text: $interior)
                    }
                }
                
                Section(header: Text("Acabados")) {
                    Toggle("Texturado", isOn: $texturado)
                    Toggle("Mate", isOn: $mate)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            //productVM.getMaterial(aluminio: $aluminio)
            let resultado: [String] = productVM.color.components(separatedBy: "\n")
            
            for linea in resultado {
                if linea.contains(":") {
                    let atributo: String = linea.components(separatedBy: ":")[0]
                    let valor: String = linea.components(separatedBy: ":")[1]
                    
                    if atributo == "Exterior" {
                        bicolor = true
                        if exterior == "" {
                            exterior = valor.trimmingCharacters(in: .whitespaces)
                        }
                    }
                    
                    if atributo == "Interior" {
                        bicolor = true
                        if interior == "" {
                            interior = valor.trimmingCharacters(in: .whitespaces)
                        }
                    }
                    
                    if atributo == "Acabado" {
                        let acabado = valor.trimmingCharacters(in: .whitespaces)
                        
                        if acabado == "Texturado" {
                            texturado = true
                        }
                            
                        if acabado == "Mate" {
                            mate = true
                        }
                    }
                    
                } else if linea.contains("(") && linea.contains(")") {
                    let first = linea.dropFirst()
                    let second = first.dropLast()
                    if anotacion == "" {
                        anotacion = String(second)
                    }
                } else {
                    if color == "" {
                        color = linea
                        for tipoDeColor in productVM.optionsFor(attribute: "Color") {
                            for tipo in productVM.optionsFor(attribute: tipoDeColor) {
                                if tipo == color {
                                    opcion = tipoDeColor
                                }
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            Button("Guardar") {
                
                var resultado: [String] = []

                if color != "" {
                    resultado.append(color)
                }
                
                if bicolor {
                    if exterior != "" {
                        resultado.append("Exterior: \(exterior)")
                    }
                    if interior != "" {
                        resultado.append("Interior: \(interior)")
                    }
                }
                
                if texturado {
                    resultado.append("Acabado: Texturado")
                }
                
                if mate {
                    resultado.append("Acabado: Mate")
                }
                
                productVM.color = resultado.joined(separator: "\n")
                
                if anotacion != "" {
                    productVM.color += "\n(\(anotacion))"
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func setBicolor() {
        exterior = color
        interior = color
    }
    
}
