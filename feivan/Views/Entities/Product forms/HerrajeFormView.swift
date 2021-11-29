//
//  HerrajeFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductHerrajeView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        NavigationLink(
            destination: ProductHerrajeFormView(productVM: productVM),
            label: {
                HStack {
                    Text("Herraje")
                    Spacer()
                    Text(productVM.herraje)
                }
            }
        )
    }
}

struct ProductHerrajeFormView: View {
    
    var atributo = "Herraje"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State var selections: [String] = []
    
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    List {
                        ForEach(productVM.optionsFor(attribute: atributo), id: \.self) { item in
                            MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                                if self.selections.contains(item) {
                                    self.selections.removeAll(where: { $0 == item })
                                }
                                else {
                                    self.selections.append(item)
                                }
                            }
                        }
                    }
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
                
                productVM.herraje = selections.joined(separator: "\n")
                
                if productVM.otro != "" {
                    productVM.herraje = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.herraje = productVM.herraje + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
