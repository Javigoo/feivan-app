//
//  CompactoFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductCompactoView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 7

    var body: some View {
        if productVM.showIf(equalTo: ["Correderas", "Practicables"]) {
            NavigationLink(
                destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
                label: {
                    HStack {
                        Text("Compacto")
                        Spacer()
                        Text(productVM.compacto)
                    }
                }
            )
        }
    }
}

struct ProductCompactoFormView: View {
    
    var atributo = "Compacto"
    @ObservedObject var productVM: ProductViewModel
    
    @State var compacto: String = ""
    @State var mando: Bool = false
    @State var huella: String = ""
    @State var numeroPanos: Int = 0
    @State var motor: Bool = false
    @State var control: String = ""
    @State var recogedor: String = ""
    @State var mismoColor: Bool = false
    @State var colorExterior: String = ""
    @State var colorLama: String = ""
    @State var cajon18: Bool = false
    @State var detallaObra: String = ""
    @State var anotacion: String = ""

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Tipo")) {
                    Picker(atributo, selection: $compacto) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                    .onTapGesture(count: 2) {
                        compacto = ""
                    }
                }
                
                
                Section(header: Text("Huella")) {
                    TextField("0 mm", text: $huella)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Paños")) {
                    Stepper("Número de paños:  \(numeroPanos)", value: $numeroPanos, in: 0...99)
                }
                
                Section(header: Text("Motor")) {
                    Toggle("Motor", isOn: $motor)
                        .onChange(of: motor) { _ in
                            if motor {
                                recogedor = ""
                            }
                        }
                    Toggle("Mando", isOn: $mando)
                }
                
                if motor {
                    Section(header: Text("Cables control")) {
                        Picker("Control", selection: $control) {
                            List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                        .onTapGesture(count: 2) {
                            control = ""
                        }
                    }
                }
                
                if !motor {
                    Section(header: Text("Recogedor")) {
                        Picker("Recogedor", selection: $recogedor) {
                            List(["Izquierdo", "Derecho"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                        .onTapGesture(count: 2) {
                            recogedor = ""
                        }
                    }
                }
                
                Section(header: Text("Color")) {
                    Toggle("Mismo color", isOn: $mismoColor)
                        .onChange(of: mismoColor) { _ in
                            if mismoColor {
                                colorExterior = ""
                                colorLama = ""
                            }
                        }
                    
                    if !mismoColor {
                        TextField("Exterior", text: $colorExterior)
                        TextField("Lama", text: $colorLama)
                    }
                }
                
                Section(header: Text("Cajón")) {
                    Toggle("Cajón de 18", isOn: $cajon18)
                }
                
                Section(header: Text("Detalles obra")) {
                    Picker("Detalles obra", selection: $detallaObra) {
                        if productVM.showIf(equalTo: ["Persianas enrollables"]) {
                            List(["Sobre muro", "Tipo compacto", "Persiana enrollable"], id: \.self) { item in Text(item) }
                        } else {
                            List(["Sobre muro", "Tipo compacto"], id: \.self) { item in Text(item) }
                        }
                    }
                    .pickerStyle(.segmented)
                    .onTapGesture(count: 2) {
                        detallaObra = ""
                    }
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            if compacto.isEmpty {
                compacto = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Valor")
            }
            if huella.isEmpty {
                huella = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Huella").components(separatedBy: " ")[0]
            }
            if numeroPanos == 0 {
                numeroPanos = Int(productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Paños")) ?? 0
            }
            if recogedor.isEmpty {
                recogedor = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Recogedor")
            }
            if !motor {
                motor = Bool(productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Con motor")) ?? false
            }
            if control.isEmpty {
                control = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Cables control")
            }
            if !mando {
                mando = Bool(productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Con mando")) ?? false
            }
            if !mismoColor {
                mismoColor = Bool(productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Mismo color")) ?? false
            }
            if colorExterior.isEmpty {
                colorExterior = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Color exterior")
            }
            if colorLama.isEmpty {
                colorLama = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Color lama")
            }
            if !cajon18 {
                cajon18 = Bool(productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Con cajón de 18")) ?? false
            }
            if detallaObra.isEmpty {
                detallaObra = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Detalles de obra")
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.compacto, select_atributte: "Anotacion")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !compacto.isEmpty {
            resultado.append(compacto)
        }
        
        if !huella.isEmpty {
            resultado.append("Huella: \(huella) mm")
        }
        
        if numeroPanos != 0 {
            resultado.append("Paños: \(numeroPanos)")
        }
        
        if !recogedor.isEmpty {
            resultado.append("Recogedor: \(recogedor)")
        }
        
        if motor {
            resultado.append("Con motor")
            if control != "" {
                resultado.append("Cables control: \(control)")
            }
        }
        
        if mando {
            resultado.append("Con mando")
        }
        
        if mismoColor {
            resultado.append("Mismo color")
        } else {
            if !colorExterior.isEmpty {
                resultado.append("Color exterior: \(colorExterior)")
            }
            
            if !colorLama.isEmpty {
                resultado.append("Color lama: \(colorLama)")
            }
        }
        
        if cajon18 {
            resultado.append("Con cajón de 18")
        }
        
        if !detallaObra.isEmpty {
            resultado.append("Detalles de obra: \(detallaObra)")
        }
        
        if !anotacion.isEmpty {
            resultado.append("(\(anotacion))")
        }
        
        productVM.compacto = resultado.joined(separator: "\n")
        
        productVM.save()
    }
}

