//
//  DimensionesFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductDimensionesView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 5

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
            label: {
                HStack {
                    Text("Medidas")
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
        .navigationTitle("Medidas")
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
                    resultado.append("")
                    if superior != "" {
                        resultado.append("Fijo Sup.: \(superior) mm")
                    }
                    if inferior != "" {
                        resultado.append("Fijo Inf.: \(inferior) mm")
                    }
                    if izquierdo != "" {
                        resultado.append("Fijo Izq.: \(izquierdo) mm")
                    }
                    if derecho != "" {
                        resultado.append("Fijo Der.: \(derecho) mm")
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

struct ProductDimensionesSheetView: View {
    
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
            Button("Guardar") {
                
                var resultado: [String] = []
                
                if ancho != "" {
                    resultado.append("Ancho: \(ancho) mm")
                }
                
                if alto != "" {
                    resultado.append("Alto: \(alto) mm")
                }
                
                if fijos {
                    resultado.append("")
                    if superior != "" {
                        resultado.append("Fijo Sup.: \(superior) mm")
                    }
                    if inferior != "" {
                        resultado.append("Fijo Inf.: \(inferior) mm")
                    }
                    if izquierdo != "" {
                        resultado.append("Fijo Izq.: \(izquierdo) mm")
                    }
                    if derecho != "" {
                        resultado.append("Fijo Der.: \(derecho) mm")
                    }
                }
                
                productVM.dimensiones = resultado.joined(separator: "\n")
                
                if productVM.anotacion != "" {
                    productVM.dimensiones = productVM.dimensiones + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }.padding()

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
        .navigationTitle("Medidas")
    }
}
