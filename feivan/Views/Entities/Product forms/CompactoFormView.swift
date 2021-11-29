//
//  CompactoFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductCompactoView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        NavigationLink(
            destination: ProductCompactoFormView(productVM: productVM),
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

struct ProductCompactoFormView: View {
    
    var atributo = "Compacto"
    @ObservedObject var productVM: ProductViewModel
    
    @State var compacto: String = ""
    @State var huella: String = ""
    @State var numeroPanos: Int = 0
    @State var motor: Bool = false
    @State var cable: String = ""
    @State var control: String = ""
    @State var recogedor: String = ""
    @State var exterior: Bool = false
    @State var colorExterior: String = ""
    @State var colorLama: String = ""
    @State var tamanoCajon: Bool = false
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
                }
                
                if motor {
                    Section(header: Text("Cables")) {
                        Picker("Cables", selection: $cable) {
                            List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }

                    Section(header: Text("Cables control")) {
                        Picker("Control", selection: $control) {
                            List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section(header: Text("Recogedor")) {
                    Picker("Recogedor", selection: $recogedor) {
                        List(["Izquierdo", "Derecho"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                    Toggle("Exterior", isOn: $exterior)
                }
                
                Section(header: Text("Color")) {
                    TextField("Exterior", text: $colorExterior)
                    TextField("Lama", text: $colorLama)
                }
                
                Section(header: Text("Cajón")) {
                    Toggle("Tamaño cajón", isOn: $tamanoCajon)
                }
                
                Picker("Detalles obra", selection: $detallaObra) {
                    if productVM.showIf(equalTo: ["Mini"]) {
                        List(["Sobre muro", "Tipo compacto", "Mini"], id: \.self) { item in Text(item) }
                    } else {
                        List(["Sobre muro", "Tipo compacto"], id: \.self) { item in Text(item) }
                    }
                }
                .pickerStyle(.segmented)
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
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
                    if exterior {
                        resultado.append("Recogedor: \(recogedor) exterior")
                    } else {
                        resultado.append("Recogedor: \(recogedor)")
                    }
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
                
                if tamanoCajon {
                    resultado.append("Con tamaño cajón")
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
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
