//
//  PosicionFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductPosicionView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 14

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
            label: {
                HStack {
                    Text("Posición")
                    Spacer()
                    Text(productVM.posicion)
                }
            }
        )
    }
}

struct ProductPosicionFormView: View {
    
    var atributo = "Posición"
    @ObservedObject var productVM: ProductViewModel
    
    @State var posicion: String = ""
    @State var otraPosicion: String = ""
    @State var anotacion: String = ""

    @State var ventana_o_puerta: String = ""
    @State var ventana: Int = 1
    @State var puerta: Int = 1
    
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Zonas")) {
                    Picker(atributo, selection: $posicion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.wheel)
                }
                
                Section(header: Text("Otra zona")) {
                    TextField("Introduce otra opción", text: $otraPosicion)
                }
                
                Section(header: Text("Ubicación")) {
                    Picker(atributo, selection: $ventana_o_puerta) {
                        List(["Ventana", "Puerta"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                    
                    if ventana_o_puerta == "Ventana" {
                        Stepper("V\(ventana)", value: $ventana, in: 0...99)
                    }
                    if ventana_o_puerta == "Puerta" {
                        Stepper("P\(puerta)", value: $puerta, in: 0...99)
                    }
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            if posicion.isEmpty {
                posicion = productVM.getAttributeValue(attribute_data: productVM.posicion, select_atributte: "Valor")
            }
    
            if otraPosicion.isEmpty {
                otraPosicion = productVM.getAttributeValue(attribute_data: productVM.posicion, select_atributte: "Otro")
            }
            
            
            ventana = Int(productVM.getAttributeValue(attribute_data: productVM.posicion, select_atributte: "V")) ?? 0
            if ventana != 0 {
                ventana_o_puerta = "Ventana"
            }
            
            puerta = Int(productVM.getAttributeValue(attribute_data: productVM.posicion, select_atributte: "P")) ?? 0
            if puerta != 0 {
                ventana_o_puerta = "Puerta"
            }
           
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.posicion, select_atributte: "Anotacion")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !otraPosicion.isEmpty {
            resultado.append("\""+otraPosicion+"\"")
        } else if !posicion.isEmpty {
            resultado.append(posicion)
        }
        
        if ventana_o_puerta == "Ventana" {
            resultado.append("V:\(ventana)")
        }
        if ventana_o_puerta == "Puerta" {
            resultado.append("P:\(puerta)")
        }
        
        productVM.posicion = resultado.joined(separator: "\n")
        
        if !anotacion.isEmpty {
            productVM.posicion += "\n(\(anotacion))"
        }
        
        productVM.save()
    }
}
