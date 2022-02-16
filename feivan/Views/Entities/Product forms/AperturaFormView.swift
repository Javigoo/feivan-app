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
    
    @State var marco_inferior: String = ""
    @State var canal_recoge_agua: Bool = false
    
    @State var otro: String = ""
    @State var anotacion: String = ""

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
                
                Section(header: Text("Corredera")) {
                    Picker("Corredera", selection: $corredera) {
                        List(["Primera hoja izquierda", "Primera hoja derecha"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                    .onTapGesture(count: 2) {
                        corredera = ""
                    }
                }
                
                if productVM.notShowIf(familias: ["Correderas", "Fijos"]) && corredera.isEmpty {
                    if !oscilobatiente {
                        Section(header: Text("Vista")) {
                            Picker("Vista", selection: $vista) {
                                List(["Dentro", "Fuera"], id: \.self) { item in Text(item) }
                            }
                            .pickerStyle(.segmented)
                            .onTapGesture(count: 2) {
                                vista = ""
                            }
                        }
                    
                        Section(header: Text("Abre")) {
                            Picker("Abre", selection: $abre) {
                                List(["Interior", "Exterior"], id: \.self) { item in Text(item) }
                            }
                            .pickerStyle(.segmented)
                            .onTapGesture(count: 2) {
                                abre = ""
                            }
                        }
                    }
                
                    Section(header: Text("Mano")) {
                        Picker("Mano", selection: $mano) {
                            List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                        .onTapGesture(count: 2) {
                            mano = ""
                        }
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
                        .onTapGesture(count: 2) {
                            marco_inferior = ""
                        }
                        
                        if marco_inferior == "Empotrado" {
                            Toggle("Canal recoge agua", isOn: $canal_recoge_agua)
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
                    
            if !oscilobatiente {
                oscilobatiente = Bool(productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Oscilobatiente")) ?? false
            }
            
            if vista.isEmpty {
                vista = productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Vista")
            }
            
            if abre.isEmpty {
                abre = productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Abre")
            }
            
            if mano.isEmpty {
                mano = productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Mano")
            }
            
            if corredera.isEmpty {
                if !productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Primera hoja izquierda").isEmpty {
                    corredera = "Primera hoja izquierda"
                }
                if !productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Primera hoja derecha").isEmpty {
                    corredera = "Primera hoja derecha"
                }
            }
            
            if marco_inferior.isEmpty {
                marco_inferior = productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Marco inferior")
            }
            
            if !canal_recoge_agua {
                canal_recoge_agua = Bool(productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Con canal recoge agua")) ?? false
            }
            
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Anotacion")
            }
            
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.apertura, select_atributte: "Otro")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !otro.isEmpty {
            productVM.apertura = "\""+otro+"\""
        } else {
            if oscilobatiente {
                resultado.append("Oscilobatiente")
            }
            
            if !vista.isEmpty {
                resultado.append("Vista: \(vista)")
            }
            
            if !abre.isEmpty {
                resultado.append("Abre: \(abre)")
            }
            
            if !mano.isEmpty {
                resultado.append("Mano: \(mano)")
            }
            
            if !corredera.isEmpty {
                print(corredera)
                resultado.append(corredera)
            }
            
            // Marco inferior
            if !marco_inferior.isEmpty {
                resultado.append("Marco inferior: " + marco_inferior)
            }
            
            if canal_recoge_agua {
                resultado.append("Con canal recoge agua")
            }
            
            if !anotacion.isEmpty {
                resultado.append("(\(anotacion))")
            }
            
            productVM.apertura = resultado.joined(separator: "\n")
        }
        
        productVM.save()
    }
}
