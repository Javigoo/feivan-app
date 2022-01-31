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
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

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
                        Stepper("V\(ventana)", value: $ventana, in: 1...99)
                    }
                    if ventana_o_puerta == "Puerta" {
                        Stepper("P\(puerta)", value: $puerta, in: 1...99)
                    }
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $anotacion)
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
        
        if otraPosicion != "" {
            resultado.append(otraPosicion)
        } else if posicion != "" {
            resultado.append(posicion)
        }
        
        if ventana_o_puerta == "Ventana" {
            resultado.append("V\(ventana)")
        }
        if ventana_o_puerta == "Puerta" {
            resultado.append("P\(puerta)")
        }
        
        productVM.posicion = resultado.joined(separator: "\n")
        
        if anotacion != "" {
            productVM.posicion += "\n(\(anotacion))"
        }
        
        productVM.save()
    }
}
