//
//  ForroExteriorFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductForroExteriorView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        if productVM.notShowIf(familias: ["Persiana"]) {
            NavigationLink(
                destination: ProductForroExteriorFormView(productVM: productVM),
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
    
    @State var lama: String = ""
    @State var angulo: String = ""
    @State var pletina: String = ""

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                            
                Section(header: Text("Lama")) {
                    Picker("Lama", selection: $lama) {
                        List(["40", "60"], id: \.self) { item in Text(item) }
                    }
                }
                
                Section(header: Text("Ángulo")) {
                    Picker("Ángulo", selection: $angulo) {
                        List(["30x30","40x20","40x40","60x40","80x40"], id: \.self) { item in Text(item) }
                    }
                }
                
                Section(header: Text("Pletina")) {
                    TextField("Pletina", text: $pletina)

                }

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
