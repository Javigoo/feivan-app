//
//  AperturaFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductAperturaView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 6

    var body: some View {
        if productVM.notShowIf(familias: ["Fijos"]) {
            NavigationLink(
                destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
                label: {
                    HStack {
                        Text("Apertura")
                        Spacer()
                        Text(productVM.apertura)
                    }
                }
            )
        }
    }
}

struct ProductAperturaFormView: View {
    
    var atributo = "Apertura"
    @ObservedObject var productVM: ProductViewModel
    
    @State var vista: String = ""
    @State var abre: String = ""
    @State var mano: String = ""
    @State var corredera: String = ""
    @State var oscilobatiente: Bool = false
    
    // Marco inferior
    @State var marco_inferior: String = ""
    @State var canal_recogeAgua: Bool = false

    var body: some View {
        VStack {
            Form{
                if productVM.showIf(equalTo: ["Practicables", "Puertas"]) {
                    Section(header: Text("Tipo de apertura")) {
                        Toggle("Oscilobatiente", isOn: $oscilobatiente)
                            .onChange(of: oscilobatiente) { _ in
                                if oscilobatiente {
                                    vista = ""
                                    abre = ""
                                }
                            }
                    }
                }
                
                if productVM.notShowIf(familias: ["Correderas", "Fijos"]) {
                    if !oscilobatiente {
                        Section(header: Text("Vista")) {
                            Picker("Vista", selection: $vista) {
                                List(["Dentro", "Fuera"], id: \.self) { item in Text(item) }
                            }
                            .pickerStyle(.segmented)
                        }
                    
                        Section(header: Text("Abre")) {
                            Picker("Abre", selection: $abre) {
                                List(["Interior", "Exterior"], id: \.self) { item in Text(item) }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                
                    Section(header: Text("Mano")) {
                        Picker("Mano", selection: $mano) {
                            List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                if productVM.showIf(equalTo: ["Correderas"]) {
                    Section(header: Text("Corredera")) {
                        Picker("Corredera", selection: $corredera) {
                            List(["Primera hoja izquierda", "Primera hoja derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                if productVM.notShowIf(familias: ["Fijos"]) {
                    Section(header: Text("Marco inferior")) {
                        Picker("Marco Inferior", selection: $marco_inferior) {
                            if productVM.showIf(equalTo: ["Correderas"]) {
                                List(["Abierto", "Cerrado", "Solera", "Empotrado"], id: \.self) { item in Text(item) }
                            } else if productVM.showIf(equalTo: ["Practicables"]) {
                                List(["Abierto", "Cerrado", "Solera"], id: \.self) { item in Text(item) }
                            } else {
                                List(["Abierto", "Cerrado"], id: \.self) { item in Text(item) }
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        if productVM.marco_inferior == "Empotrado" {
                            Toggle("Canal recoge agua", isOn: $canal_recogeAgua)
                        }
                    }
                }
                                            
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if oscilobatiente {
            resultado.append("Oscilobatiente")
        }
        
        if vista != "" {
            resultado.append("Vista: \(vista)")
        }
        
        if abre != "" {
            resultado.append("Abre: \(abre)")
        }
        
        if mano != "" {
            resultado.append("Mano: \(mano)")
        }
        
        if corredera != "" {
            resultado.append(corredera)
        }
        
        // Marco inferior
        if marco_inferior != "" {
            if canal_recogeAgua {
                resultado.append("Marco inferior " + marco_inferior.lowercased() + " con canal recoge agua")
            } else {
                resultado.append("Marco inferior " + marco_inferior.lowercased())
            }
        }
        
        productVM.apertura = resultado.joined(separator: "\n")
        
        if productVM.otro != "" {
            productVM.apertura = productVM.otro
            productVM.otro = ""
        }
        
        if productVM.anotacion != "" {
            productVM.apertura = productVM.apertura + "\n(\(productVM.anotacion))"
            productVM.anotacion = ""
        }
        
        productVM.save()
    }
}
