//
//  DimensionesFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductDimensionesView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        NavigationLink(
            destination: ProductDimensionesFormView(productVM: productVM),
            label: {
                HStack {
                    Text("Dimensiones")
                    Spacer()
                    Text(productVM.dimensiones)
                }
            }
        )
    }
}

struct ProductDimensionesFormView: View {
    
    var atributo = "Dimensiones"
    @ObservedObject var productVM: ProductViewModel
    
    @State var ancho: String = ""
    @State var alto: String = ""
    @State var fijos: Bool = false
    @State var superior: String = ""
    @State var inferior: String = ""
    @State var izquierdo: String = ""
    @State var derecho: String = ""
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Dimensiones"), footer: Text("Unidad de medida: mm")) {
                    HStack {
                        TextField("Ancho", text: $ancho)
                        Divider()
                        TextField("Alto", text: $alto)
                    }
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                }
                
                Toggle("Fijos", isOn: $fijos)
                
                if fijos {
                    Section(header: Text("Dimensiones fijo"), footer: Text("Unidad de medida: mm")) {
                        TextField("Superior", text: $superior)
                        TextField("Inferior", text: $inferior)
                        TextField("Izquierdo", text: $izquierdo)
                        TextField("Derecho", text: $derecho)
                    }.keyboardType(.numberPad)
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
                
                if ancho != "" {
                    resultado.append("Ancho: \(ancho) mm")
                }
                
                if alto != "" {
                    resultado.append("Alto: \(alto) mm")
                }
                
                if fijos {
                    resultado.append("Con fijos")
                    if superior != "" {
                        resultado.append("Superior: \(superior) mm")
                    }
                    if inferior != "" {
                        resultado.append("Inferior: \(inferior) mm")
                    }
                    if izquierdo != "" {
                        resultado.append("Izquierdo: \(izquierdo) mm")
                    }
                    if derecho != "" {
                        resultado.append("Derecho: \(derecho) mm")
                    }
                }
                
                productVM.dimensiones = resultado.joined(separator: "\n")
                
                if productVM.anotacion != "" {
                    productVM.dimensiones = productVM.dimensiones + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
