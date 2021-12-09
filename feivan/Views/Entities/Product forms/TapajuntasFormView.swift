//
//  TapajuntasFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductTapajuntasView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        NavigationLink(
            destination: ProductTapajuntasFormView(productVM: productVM),
            label: {
                HStack {
                    Text("Tapajuntas")
                    Spacer()
                    Text(productVM.tapajuntas)
                }
            }
        )
    }
}

struct ProductTapajuntasFormView: View {
    
    var atributo = "Tapajuntas"
    @ObservedObject var productVM: ProductViewModel
    
    @State var especificos: Bool = false
    @State var superior: Double = 0
    @State var inferior: Double = 0
    @State var izquierdo: Double = 0
    @State var derecho: Double = 0
    @State var tapajuntas_inferior: Bool = false

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones"), footer: Text("Unidad de medida: mm")) {
                    Picker(atributo, selection: $productVM.tapajuntas) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in
                            Text(item)
                        }
                    }.pickerStyle(.wheel)
                    .onChange(of: productVM.tapajuntas) { newValue in
                        setTapajuntasEspecificos()
                    }
            
                }
                
                Section(header: Text("Tapajuntas")) {
                    Toggle("Sin tapajuntas inferior", isOn: $tapajuntas_inferior)
                        .onChange(of: tapajuntas_inferior) { _ in
                            if tapajuntas_inferior {
                                inferior = 0
                            } else {
                                inferior = Double(productVM.tapajuntas) ?? 0
                            }
                        }
                    
                    Toggle("Específicos", isOn: $especificos)
                        .onAppear {
                            setTapajuntasEspecificos()
                        }
                
                    if especificos {
                        HStack {
                            Text("Superior\t")
                            Text(String(format: "%.0f", superior))
                            Slider(value: $superior, in: 0...100, step: 5)
                        }
                        if !tapajuntas_inferior {
                            HStack {
                                Text("Inferior\t\t")
                                Text(String(format: "%.0f", inferior))
                                Slider(value: $inferior, in: 0...100, step: 5)
                            }
                        }
                        HStack {
                            Text("Izquierdo\t")
                            Text(String(format: "%.0f", izquierdo))
                            Slider(value: $izquierdo, in: 0...100, step: 5)
                        }
                        HStack {
                            Text("Derecho\t")
                            Text(String(format: "%.0f", derecho))
                            Slider(value: $derecho, in: 0...100, step: 5)
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
        .toolbar {
            Button("Guardar") {

                var resultado: [String] = []

                if especificos {
                    if (superior != 0){
                        resultado.append("Superior: \(String(format: "%.0f", superior)) mm")
                    }
                    if (inferior != 0){
                        resultado.append("Inferior: \(String(format: "%.0f", inferior)) mm")
                    }
                    if (izquierdo != 0){
                        resultado.append("Izquierdo: \(String(format: "%.0f", izquierdo)) mm")
                    }
                    if (derecho != 0){
                        resultado.append("Derecho: \(String(format: "%.0f", derecho)) mm")
                    }
                    productVM.tapajuntas = resultado.joined(separator: "\n")
                } else {
                    if tapajuntas_inferior {
                        productVM.tapajuntas = productVM.tapajuntas + "\nSin tapajuntas inferior"
                    }
                }
                
                if productVM.otro != "" {
                    productVM.tapajuntas = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.tapajuntas = productVM.tapajuntas + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func setTapajuntasEspecificos() {
        superior = Double(productVM.tapajuntas) ?? 0
        inferior = Double(productVM.tapajuntas) ?? 0
        izquierdo = Double(productVM.tapajuntas) ?? 0
        derecho = Double(productVM.tapajuntas) ?? 0
    }
}
