//
//  ForroExteriorFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductForroExteriorView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 9

    var body: some View {
    
        if productVM.notShowIf(familias: ["Persiana"]) {
            NavigationLink(
                destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
                label: {
                    HStack {
                        Text("Forro exterior")
                        Spacer()
                        Text(productVM.forro_exterior)
                    }
                }
            )
        }
    }
}

struct ProductForroExteriorFormView: View {
    
    var atributo = "Forro exterior"
    @ObservedObject var productVM: ProductViewModel
    
    @State var angulo: String = ""
    @State var pletina: String = ""
    @State var lama: Bool = false
    
    @State var otro: String = ""
    @State var anotacion: String = ""

    var body: some View {
        VStack {
            Form{
                  
                Section(header: Text("Pletina")) {
                    Picker("Pletina", selection: $pletina) {
                        List(["40", "60"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                    .onTapGesture(count: 2) {
                        pletina = ""
                    }
                }
                
                Section(header: Text("Ángulo")) {
                    Picker("Ángulo", selection: $angulo) {
                        List(["", "30x30","40x20","40x40","60x40","80x40"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.wheel)
                }
                
                Toggle("Lama", isOn: $lama)

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
            if pletina.isEmpty {
                pletina = productVM.getAttributeValue(attribute_data: productVM.forro_exterior, select_atributte: "Pletina")
            }
            if angulo.isEmpty {
                angulo = productVM.getAttributeValue(attribute_data: productVM.forro_exterior, select_atributte: "Ángulo")
            }
            if !lama {
                lama = Bool(productVM.getAttributeValue(attribute_data: productVM.forro_exterior, select_atributte: "Con lama")) ?? false
            }
            
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.forro_exterior, select_atributte: "Anotacion")
            }
            
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.forro_exterior, select_atributte: "Otro")
            }
        }.onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !otro.isEmpty {
            productVM.forro_exterior = "\""+otro+"\""
        } else {
            if !pletina.isEmpty {
                resultado.append("Pletina: \(pletina)")
            }
            
            if !angulo.isEmpty {
                resultado.append("Ángulo: \(angulo)")
            }
            
            if lama {
                resultado.append("Con lama")
            }
            
            if !anotacion.isEmpty {
                resultado.append("(\(anotacion))")
            }
            
            productVM.forro_exterior = resultado.joined(separator: "\n")
        }
        
        productVM.save()
    }
}
