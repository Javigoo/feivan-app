//
//  ColorFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductColorView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 3

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
            label: {
                HStack {
                    Text("Color")
                    Spacer()
                    Text(productVM.color)
                }
            }
        )
    }
}

struct ProductColorFormView: View {
    
    var atributo = "Color"
    @ObservedObject var productVM: ProductViewModel
    
    @State var opcion: String = "Más utilizados"
    @State var tono: String = ""
    @State var color: String = ""
    @State var bicolor: Bool = false
    @State var exterior: String = ""
    @State var interior: String = ""
    @State var texturado: Bool = false
    @State var mate: Bool = false
    @State var liso: Bool = false
    @State var herrajes: Bool = false
    @State var anotacion: String = ""

    @State var tonos_ral: [String] = ["Amarillos", "Naranjas", "Rojos", "Violetas", "Azules", "Verdes", "Grises", "Marrones", "Blancos y negros"]

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Tipo de color")) {
                    Picker("Tipo de color", selection: $opcion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }.pickerStyle(.wheel)
                }
                
                if opcion == "Ral" {
                    Section(header: Text("Color ")) {
                        
                        Picker("Tonos", selection: $tono) {
                            List(tonos_ral, id: \.self) { item in Text(item) }
                        }
                        
                        let tone_code = productVM.getToneCode(tone: tono)
                        
                        ForEach(productVM.getRalCodes(), id: \.self) { code in
                            
                            let ral_code = productVM.getRalCode(ral: code)
                            if tone_code == ral_code {
                            
                                let red = productVM.getRalColor(code: code, color: "r")/255
                                let green = productVM.getRalColor(code: code, color: "g")/255
                                let blue = productVM.getRalColor(code: code, color: "b")/255
                                ZStack {
                                    HStack {
                                        Text("\(code)")
                                        Spacer()
                                        Text("\(productVM.getRalName(code: code))")
                                        Spacer()
                                        Rectangle()
                                            .fill(Color(red: red, green: green, blue: blue))
                                            .frame(width: 50, height: 50)
                                    }.onTapGesture(perform: {
                                        color = "Ral \(code)"
                                    })
                                    
                                    if color == "Ral \(code)" {
                                        HStack {
                                            Spacer()
                                            Rectangle()
                                                .stroke(Color.red, lineWidth: 5)
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
    
                if opcion == "Anonizados" {
                    Section(header: Text("Color")) {
                        Picker("Anonizado", selection: $color) {
                            List(productVM.optionsFor(attribute: "Anonizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if opcion == "Madera" {
                    Section(header: Text("Color")) {
                        Picker("Madera", selection: $color) {
                            List(productVM.optionsFor(attribute: "Madera"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if opcion == "Más utilizados" {
                    Section(header: Text("Color")) {
                        Picker("Opción", selection: $color) {
                            List(productVM.optionsFor(attribute: "Más utilizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                
                Section(header: Text("Acabados")) {
                    if opcion != "Madera" {
                        if opcion != "Anonizados" {
                            Toggle("Texturado", isOn: $texturado)
                                .onChange(of: texturado){ _ in
                                    if texturado {
                                        mate = false
                                        liso = false
                                    }
                                }
                        }
                        Toggle("Mate", isOn: $mate)
                            .onChange(of: mate){ _ in
                                if mate {
                                    texturado = false
                                    liso = false
                                }
                            }
                    } else {
                        Toggle("Liso", isOn: $liso)
                            .onChange(of: liso){ _ in
                                if liso {
                                    mate = false
                                    texturado = false
                                }
                            }
                    }
                }
                
                Section(header: Text("Extras")) {
                    Toggle("Bicolor", isOn: $bicolor)
                        .onChange(of: bicolor) { _ in
                            setBicolor()
                        }
                }
                
                if bicolor {
                    Section(header: Text("Color exterior")) {
                        TextField("Exterior", text: $exterior)
                    }
                    Section(header: Text("Color interior")) {
                        TextField("Interior", text: $interior)
                    }
                }
                
                Section(header: Text("Herrajes específicos")) {
                    Toggle("Mismo color", isOn: $herrajes)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            let resultado: [String] = productVM.color.components(separatedBy: "\n")
            
            for linea in resultado {
                if linea.contains(":") {
                    let atributo: String = linea.components(separatedBy: ":")[0]
                    let valor: String = linea.components(separatedBy: ":")[1]
                    
                    if atributo == "Exterior" {
                        bicolor = true
                        if exterior == "" {
                            exterior = valor.trimmingCharacters(in: .whitespaces)
                        }
                    }
                    
                    if atributo == "Interior" {
                        bicolor = true
                        if interior == "" {
                            interior = valor.trimmingCharacters(in: .whitespaces)
                        }
                    }
                    
                    if atributo == "Acabado" {
                        let acabado = valor.trimmingCharacters(in: .whitespaces)
                        
                        if acabado == "Texturado" {
                            texturado = true
                        }
                            
                        if acabado == "Mate" {
                            mate = true
                        }
                        
                        if acabado == "Liso" {
                            liso = true
                        }
                    }
                    
                    if atributo == "Herrajes" {
                        herrajes = true
                    }
                    
                } else if linea.contains("(") && linea.contains(")") {
                    let first = linea.dropFirst()
                    let second = first.dropLast()
                    if anotacion == "" {
                        anotacion = String(second)
                    }
                } else {
                    if color == "" {
                        color = linea
                        externaLoop: for tipoDeColor in productVM.optionsFor(attribute: "Color") {
                            for tipo in productVM.optionsFor(attribute: tipoDeColor) {
                                if tipo == color {
                                    opcion = tipoDeColor
                                    break externaLoop
                                }
                            }
                        }
                    }
                }
            }
        }.toolbar {
            Button("Guardar") {
                save()
                presentationMode.wrappedValue.dismiss()
            }
        }.onDisappear {
            save()
        }
    }
    
    func setBicolor() {
        exterior = color
        interior = color
    }
    
    func save() {
        var resultado: [String] = []

        if color != "" {
            resultado.append(color)
        }
        
        if bicolor {
            if exterior != "" {
                resultado.append("Exterior: \(exterior)")
            }
            if interior != "" {
                resultado.append("Interior: \(interior)")
            }
        }
        
        if texturado {
            resultado.append("Acabado: Texturado")
        }
        
        if mate {
            resultado.append("Acabado: Mate")
        }
        
        if liso {
            resultado.append("Acabado: Liso")
        }
        
        if herrajes {
            resultado.append("Herrajes: Mismo color")
        }
        
        productVM.color = resultado.joined(separator: "\n")
        
        if anotacion != "" {
            productVM.color += "\n(\(anotacion))"
        }
        
        productVM.save()
    }
    
}
