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
    @State var cable: String = ""
    @State var control: String = ""
    @State var recogedor: String = ""
    @State var mismoColor: Bool = false
    @State var colorExterior: String = ""
    @State var colorLama: String = ""
    @State var cajon18: Bool = false
    @State var detallaObra: String = ""

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Tipo")) {
                    Picker(atributo, selection: $compacto) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                Section(header: Text("Huella")) {
                    TextField("0 mm", text: $huella)
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
                    }
                }
                
                if !motor {
                    Section(header: Text("Recogedor")) {
                        Picker("Recogedor", selection: $recogedor) {
                            List(["Izquierdo", "Derecho"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
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
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
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
        
        if compacto != "" {
            resultado.append(compacto)
        }
        
        if huella != "" {
            resultado.append("Huella: \(huella) mm")
        }
        
        if numeroPanos != 0 {
            resultado.append("Paños: \(numeroPanos)")
        }
        
        if recogedor != "" {
            resultado.append("Recogedor: \(recogedor)")
        }
        
        if motor {
            resultado.append("Con motor")
            if cable != "" {
                resultado.append("Cables motor: \(cable)")
            }
            if control != "" {
                resultado.append("Cables control: \(control)")
            }
        }
        
        if colorLama != "" {
            resultado.append("Color lama: \(colorLama)")
        }
        
        if colorExterior != "" {
            resultado.append("Color exterior: \(colorExterior)")
        }
        
        if cajon18 {
            resultado.append("Con cajón de 18")
        }
        
        if detallaObra != "" {
            resultado.append("Detalles de obra: \(detallaObra)")
        }
        
        productVM.compacto = resultado.joined(separator: "\n")
        
        if productVM.anotacion != "" {
            productVM.compacto = productVM.compacto + "\n(\(productVM.anotacion))"
            productVM.anotacion = ""
        }
        
        productVM.save()
    }
}

