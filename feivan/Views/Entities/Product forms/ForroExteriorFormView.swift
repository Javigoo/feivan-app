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

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                  
                Section(header: Text("Pletina")) {
                    Picker("Pletina", selection: $pletina) {
                        List(["40", "60"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Ángulo")) {
                    Picker("Ángulo", selection: $angulo) {
                        List(["30x30","40x20","40x40","60x40","80x40"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.wheel)
                }
                
                Toggle("Lama", isOn: $lama)

                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
                var resultado: [String] = []
                
                if pletina != "" {
                    resultado.append("Pletina: \(pletina)")
                }
                
                if angulo != "" {
                    resultado.append("Ángulo: \(angulo)")
                }
                
                if lama {
                    resultado.append("Con lama")
                }
                
                productVM.forro_exterior = resultado.joined(separator: "\n")
                
                if productVM.otro != "" {
                    productVM.forro_exterior = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.forro_exterior = productVM.forro_exterior + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
