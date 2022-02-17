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
    
    @State var anotacion: String = ""
    
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
                    TextField("Añade una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle("Medidas")
        .onAppear {
            if ancho.isEmpty {
                ancho = productVM.getAttributeValue(attribute_data: productVM.dimensiones, select_atributte: "Ancho").components(separatedBy: " ")[0]
            }
            if alto.isEmpty {
                alto = productVM.getAttributeValue(attribute_data: productVM.dimensiones, select_atributte: "Alto").components(separatedBy: " ")[0]
            }
            if superior.isEmpty {
                superior = productVM.getAttributeValue(attribute_data: productVM.dimensiones, select_atributte: "Fijo Sup").components(separatedBy: " ")[0]
                if !superior.isEmpty {
                    fijos = true
                }
            }
            if inferior.isEmpty {
                inferior = productVM.getAttributeValue(attribute_data: productVM.dimensiones, select_atributte: "Fijo Inf").components(separatedBy: " ")[0]
                if !inferior.isEmpty {
                    fijos = true
                }
            }
            if izquierdo.isEmpty {
                izquierdo = productVM.getAttributeValue(attribute_data: productVM.dimensiones, select_atributte: "Fijo Izq").components(separatedBy: " ")[0]
                if !izquierdo.isEmpty {
                    fijos = true
                }
            }
            if derecho.isEmpty {
                derecho = productVM.getAttributeValue(attribute_data: productVM.dimensiones, select_atributte: "Fijo Der").components(separatedBy: " ")[0]
                if !derecho.isEmpty {
                    fijos = true
                }
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.dimensiones, select_atributte: "Anotacion")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []
        
        if !ancho.isEmpty {
            resultado.append("Ancho: \(ancho) mm")
        }
        
        if !alto.isEmpty {
            resultado.append("Alto: \(alto) mm")
        }
        
        if fijos {
            resultado.append("")
            if superior != "" {
                resultado.append("Fijo Sup: \(superior) mm")
            }
            if inferior != "" {
                resultado.append("Fijo Inf: \(inferior) mm")
            }
            if izquierdo != "" {
                resultado.append("Fijo Izq: \(izquierdo) mm")
            }
            if derecho != "" {
                resultado.append("Fijo Der: \(derecho) mm")
            }
        }
        
        if !anotacion.isEmpty {
            resultado.append("(\(anotacion))")
        }
        
        productVM.dimensiones = resultado.joined(separator: "\n")
        productVM.save()
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
    
    @State var anotacion: String = ""
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Button("Guardar") {
                var resultado: [String] = []
                
                if !ancho.isEmpty {
                    resultado.append("Ancho: \(ancho) mm")
                }
                
                if !alto.isEmpty {
                    resultado.append("Alto: \(alto) mm")
                }
                
                if fijos {
                    resultado.append("")
                    if superior != "" {
                        resultado.append("Fijo Sup: \(superior) mm")
                    }
                    if inferior != "" {
                        resultado.append("Fijo Inf: \(inferior) mm")
                    }
                    if izquierdo != "" {
                        resultado.append("Fijo Izq: \(izquierdo) mm")
                    }
                    if derecho != "" {
                        resultado.append("Fijo Der: \(derecho) mm")
                    }
                }
                
                if !anotacion.isEmpty {
                    resultado.append("(\(anotacion))")
                }
                
                productVM.dimensiones = resultado.joined(separator: "\n")
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
                    TextField("Añade una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle("Medidas")
    }
}
