//
//  TapajuntasFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductTapajuntasView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 4

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
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
    
    @State var valor: String = ""
    @State var tapajuntas_inferior: Bool = false

    @State var especificos: Bool = false
    
    @State var superior: Double = 0
    @State var inferior: Double = 0
    @State var izquierdo: Double = 0
    @State var derecho: Double = 0
    
    @State var otro: String = ""
    @State var anotacion: String = ""

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones"), footer: Text("Unidad de medida: mm")) {
                    Picker(atributo, selection: $valor) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                    .onChange(of: valor) { _ in
                        setTapajuntasEspecificos()
                    }
                }
                
                Section(header: Text("Tapajuntas")) {
                    Toggle("Sin tapajuntas inferior", isOn: $tapajuntas_inferior)
                        .onChange(of: tapajuntas_inferior) { _ in
                            if tapajuntas_inferior {
                                inferior = 0
                            } else {
                                inferior = Double(valor) ?? 0
                            }
                        }
                    
                    Toggle("Específicos", isOn: $especificos)
                        .onChange(of: especificos) { _ in
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
            if valor.isEmpty {
                valor = productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Valor").components(separatedBy: " ")[0]
            }
            
            if !tapajuntas_inferior {
                tapajuntas_inferior = Bool(productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Sin tapajuntas inferior")) ?? false
            }
            
            if superior == 0 {
                superior = Double(productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Superior").components(separatedBy: " ")[0]) ?? 0
                if superior != 0 {
                    especificos = true
                }
            }
            
            if inferior == 0 {
                inferior = Double(productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Inferior").components(separatedBy: " ")[0]) ?? 0
                if inferior != 0 {
                    especificos = true
                }
            }
            
            if izquierdo == 0 {
                izquierdo = Double(productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Izquierdo").components(separatedBy: " ")[0]) ?? 0
                if izquierdo != 0 {
                    especificos = true
                }
            }
            
            if derecho == 0 {
                derecho = Double(productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Derecho").components(separatedBy: " ")[0]) ?? 0
                if derecho != 0 {
                    especificos = true
                }
            }
                        
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Anotacion")
            }
            
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.tapajuntas, select_atributte: "Otro")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func setTapajuntasEspecificos() {
        if superior == 0 {
            superior = Double(valor) ?? 0
        }
        if inferior == 0 {
            inferior = Double(valor) ?? 0
        }
        if izquierdo == 0 {
            izquierdo = Double(valor) ?? 0
        }
        if derecho == 0 {
            derecho = Double(valor) ?? 0
        }
    }
    
    func save(){
        var resultado: [String] = []
        
        if !otro.isEmpty {
            productVM.tapajuntas = "\""+otro+"\""
        } else {
            if !valor.isEmpty {
                resultado.append("\(valor) mm")
            }
            if especificos {
                if (superior != 0 && Double(valor) != superior){
                    resultado.append("Superior: \(String(format: "%.0f", superior)) mm")
                }
                if (inferior != 0 && !tapajuntas_inferior && Double(valor) != inferior){
                    resultado.append("Inferior: \(String(format: "%.0f", inferior)) mm")
                }
                if (izquierdo != 0 && Double(valor) != izquierdo){
                    resultado.append("Izquierdo: \(String(format: "%.0f", izquierdo)) mm")
                }
                if (derecho != 0 && Double(valor) != derecho){
                    resultado.append("Derecho: \(String(format: "%.0f", derecho)) mm")
                }
            }
            
            if tapajuntas_inferior {
                resultado.append("Sin tapajuntas inferior")
            }
            
            if !anotacion.isEmpty {
                resultado.append("(\(anotacion))")
            }
            
            productVM.tapajuntas = resultado.joined(separator: "\n")
        }

        productVM.save()
    }
}
