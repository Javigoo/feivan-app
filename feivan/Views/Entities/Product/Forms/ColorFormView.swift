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

    var body: some View {
        VStack {
            Form {
                
                Section(header: Text("Tipo de color")) {
                    Picker("Tipo de color", selection: $opcion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                if opcion == "Ral" {
                    Section(header: Text("Color ")) {
                        TextField("Ral", text: $color)
                        NavigationLink(
                            destination: ProductColorRalView(productVM: productVM, color_seleccionado: $color),
                            label: {
                                HStack {
                                    Text("Carta Ral")
                                    Spacer()
                                    Text(color)
                                }
                            }
                        )
                    }
                }
    
                if opcion == "Anonizados" {
                    Section(header: Text("Color")) {
                        Picker("Anonizado", selection: $color) {
                            List(productVM.optionsFor(attribute: "Anonizados"), id: \.self) { item in
                                Text(item)
                            }
                        }
                    }
                }
                
                if opcion == "Madera" {
                    Section(header: Text("Color")) {
                        Picker("Madera", selection: $color) {
                            List(productVM.optionsFor(attribute: "Madera"), id: \.self) { item in
                                Text(item)
                            }
                        }
                    }
                }
                
                if opcion == "Más utilizados" {
                    Section(header: Text("Color")) {
                        Picker("Opción", selection: $color) {
                            List(productVM.optionsFor(attribute: "Más utilizados"), id: \.self) { item in
                                Text(item)
                            }
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
                    
                    if atributo == "Ral" {
                        opcion = "Ral"
                        color = linea
                    }
                    
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

struct ProductColorRalView: View {
    @ObservedObject var productVM: ProductViewModel
    @Binding var color_seleccionado: String

    @State var tono: String = "Todos"
    @State var tonos_ral: [String] = ["Todos", "Amarillos", "Naranjas", "Rojos", "Violetas", "Azules", "Verdes", "Grises", "Marrones", "Blancos y negros"]
    
    @State var ral_color: String = ""
    @State var name_color: String = ""
    @State var rgb_color: Color = Color.white
    
    @State var colores: [RalColor] = []

    var body: some View {
        VStack {
            Form {
                if !name_color.isEmpty {
                    Section(header: Text("Color seleccionado")) {
                        NavigationLink(destination: {
                            ProductColorRalFullView(color: rgb_color)
                        }, label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(name_color)
                                        .font(.title)
                                        .lineLimit(1)
                                        .fixedSize()
                                    Text(ral_color)
                                        .font(.body)
                                }
                                Spacer()
                                Circle()
                                    .fill(rgb_color)
                            }
                        })
                    }
                }
                
                Section(header: Text("Tonos")) {

                    Picker("Tonos", selection: $tono) {
                        List(tonos_ral, id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: nil, height: 100, alignment: .center)
                }
                
                Section(header: Text("Colores")) {
                
                    let tone_code = productVM.getToneCode(tone: tono)
                    let columns = [
                            GridItem(.adaptive(minimum: 50))
                        ]
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(colores, id: \.self) { color in
                                let index = color.ral.index(color.ral.startIndex, offsetBy: 0)
                                if tone_code == String(color.ral[index]) || tono == "Todos" {
                                    let color_r_g_b = Color(red: color.r/255, green: color.g/255, blue: color.b/255)
                                    Circle()
                                        .fill(color_r_g_b)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture(perform: {
                                            name_color = color.nombre
                                            ral_color = color.ral
                                            rgb_color = color_r_g_b
                                            color_seleccionado = "Ral: \(ral_color)"
                                        })
                                }
                            }
                        }.padding()
                    }
                    .frame(maxHeight: 300)
                }
            }
        }
        .navigationTitle("Ral")
        .onAppear {
            colores = productVM.getRalColors()
//            ral_color = productVM.getAttributeValue(attribute_data: productVM.color , select_atributte: "Valor")
//            for current_color in colores {
//                if current_color.ral == ral_color {
//                    name_color = current_color.nombre
//                    rgb_color = Color(red: current_color.r/255, green: current_color.g/255, blue: current_color.b/255)
//                }
//            }
        }
    }
}

struct ProductColorRalFullView: View {
    @State var color: Color
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        if #available(iOS 15.0, *) {
            VStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
            .navigationBarBackButtonHidden(true)

        } else {
            VStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
            .navigationBarBackButtonHidden(true)

        }
    }
}


struct RalColor: Hashable {
    var nombre: String = ""
    var ral: String = ""
    var r: Double = 0.0
    var g: Double = 0.0
    var b: Double = 0.0
}
