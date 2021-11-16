//
//  ProductView.swift
//  Feivan
//
//  Created by javigo on 23/10/21.
//

import SwiftUI

struct ProductView: View {
    var body: some View {
        Text("ProductView")
    }
}

struct ProductCreateView: View {
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Guardar") {
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductAddView: View {
    @StateObject var productVM = ProductViewModel()
    @ObservedObject var projectVM: ProjectViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Guardar") {
                productVM.addProject(projectVM: projectVM)
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle(Text("Información proyecto"))
    }
}

struct ProductAddMoreView: View {
    @StateObject var productVM = ProductViewModel()
    @ObservedObject var originalProductVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Guardar") {
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }.onAppear(perform: {
            productVM.setProductVMAddMore(productVM: originalProductVM)
        })
        .navigationTitle(Text("Información proyecto"))
    }
}


struct ProductFormView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        
        NavigationLink(
            destination: ProductFamiliaFormView(productVM: productVM),
            label: {
                if productVM.familia == "" {
                    Text("Familia")
                        .font(.title)
                } else {
                    Text(productVM.getSingularFamilia(name: productVM.familia))
                        .font(.title)
                }
            }
        )
            
        NavigationLink(
            destination: ProductNombreFormView(productVM: productVM),
            label: {
                if productVM.nombre == "" {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } else {
                    Image(productVM.nombre)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
            }
        )
        
        Form {
            Group {
                if productVM.showIf(familias: ["Curvas"]) {
                    NavigationLink(
                        destination: ProductCurvasFormView(productVM: productVM),
                        label: {
                            HStack {
                                Text("Curvas")
                                Spacer()
                                Text(productVM.curvas)
                            }
                        }
                    )
                }
                
                NavigationLink(
                    destination: ProductMaterialFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Material")
                            Spacer()
                            Text(productVM.material)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductColorFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Color")
                            Spacer()
                            Text(productVM.color)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductTapajuntasFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Tapajuntas")
                            Spacer()
                            Text(productVM.tapajuntas)
                        }
                    }
                )
                
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
                
                NavigationLink(
                    destination: ProductAperturaFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Apertura")
                            Spacer()
                            Text(productVM.apertura)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductCompactoFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Compacto")
                            Spacer()
                            Text(productVM.compacto)
                        }
                    }
                )
            }
            
            Group {
                if productVM.notShowIf(familias: ["Fijos", "Correderas"]) {
                    NavigationLink(
                        destination: ProductMarcoInferiorFormView(productVM: productVM),
                        label: {
                            HStack {
                                Text("Marco inferior")
                                Spacer()
                                Text(productVM.marco_inferior)
                            }
                        }
                    )
                }
                
                NavigationLink(
                    destination: ProductHuellaFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Huella")
                            Spacer()
                            Text(productVM.huella)
                        }
                    }
                )
                
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
                
                if productVM.notShowIf(familias: ["Persiana"]) {
                    NavigationLink(
                        destination: ProductCristalFormView(productVM: productVM),
                        label: {
                            HStack {
                                Text("Cristal")
                                Spacer()
                                Text(productVM.cristal)
                            }
                        }
                    )
                }
                
                NavigationLink(
                    destination: ProductCerradurasFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Cerraduras")
                            Spacer()
                            Text(productVM.cerraduras)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductManetasFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Manetas")
                            Spacer()
                            Text(productVM.manetas)
                        }
                    }
                )
                
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
                
                NavigationLink(
                    destination: ProductPosicionFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Posición")
                            Spacer()
                            Text(productVM.posicion)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductInstalacionFormView(productVM: productVM),
                    label: {
                        HStack {
                            Text("Instalación")
                            Spacer()
                            Text(productVM.instalacion)
                        }
                    }
                )
                
                if productVM.showIf(familias: ["Persiana"]) {
                    NavigationLink(
                        destination: ProductMallorquinaFormView(productVM: productVM),
                        label: {
                            HStack {
                                Text("Mallorquina")
                                Spacer()
                                Text(productVM.persiana)
                            }
                        }
                    )
                }
            }
            
            Group {
                Section(header: Text("Extras")) {
                    Toggle(isOn: $productVM.remates_albanileria) {
                        Text("Remates Albañilería")
                    }
                    Toggle(isOn: $productVM.medidas_no_buenas) {
                        Text("Medidas no buenas")
                    }
                    Stepper("Copias:  \(productVM.copias)", value: $productVM.copias, in: 1...99)
                }
                
                NavigationLink(
                    destination:
                        ProductAddMoreView(originalProductVM: productVM),
                    label: {
                        Text("Añadir más")
                            .font(.body)
                    }
                )
            }
        }
    }
}


// Product form views
struct ProductFamiliaFormView: View {
    
    var atributo = "Familia"
    @ObservedObject var productVM: ProductViewModel
    @State private var isShowingNextView = false
    //@Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            NavigationLink(destination: ProductNombreFormView(productVM: productVM), isActive: $isShowingNextView) { EmptyView() }
            
            ForEach(productVM.optionsFor(attribute: "Familias"), id: \.self) { familia in
                Button(
                    action: {
                        productVM.familia = familia
                        productVM.save()
                        isShowingNextView = true
                        //presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text(familia)
                            .textStyle(NavigationLinkStyle())
                    }
                )
            }
        }
        .navigationTitle(Text("Familias"))
    }
}

struct ProductNombreFormView: View {
    @ObservedObject var productVM: ProductViewModel
    
    var body: some View {
        treeView(optionSelect: productVM.familia, productVM: productVM)
    }
}

struct ProductMaterialFormView: View {
    
    var atributo = "Material"
    @ObservedObject var productVM: ProductViewModel
    
    @State var opcion: String = ""
    @State var aluminio: String = ""
    @State var otro: String = ""
    @State var anotacion: String = ""
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $opcion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if opcion == "Aluminio" {
                    if productVM.showIf(familias: ["Correderas"]) {
                        Section(header: Text("Aluminio")) {
                            Picker("Aluminio", selection: $aluminio) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Correderas"), id: \.self) { item in Text(item) }
                            }
                        }
                    }
                    if productVM.showIf(familias: ["Practicables"]) {
                        Section(header: Text("Aluminio")) {
                            Picker("Aluminio", selection: $aluminio) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Ventanas"), id: \.self) { item in Text(item) }
                            }
                        }
                    }
                }
                                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            //productVM.getMaterial(aluminio: $aluminio)
            let resultado: [String] = productVM.material.components(separatedBy: "\n")
            
            for linea in resultado {
                if linea.contains(":") {
                    let atributo: String = linea.components(separatedBy: ":")[0]
                    let valor: String = linea.components(separatedBy: ":")[1]
                    
                    if atributo == "Tipo" {
                        if aluminio == "" {
                            aluminio = valor.trimmingCharacters(in: .whitespaces)
                            print("Aluminio: \(aluminio)")
                        }
                    }
                    
                } else if linea.contains("\"") {
                    if otro == "" {
                        otro = linea.replacingOccurrences(of: "\"", with: "")
                        print("Otro: \(otro)")
                    }
                } else if linea.contains("(") && linea.contains(")") {
                    let first = linea.dropFirst()
                    let second = first.dropLast()
                    if anotacion == "" {
                        anotacion = String(second)
                        print("Anotación: \(anotacion)")
                    }
                } else {
                    if opcion == "" {
                        opcion = linea
                        print("Opción: \(opcion)")
                    }
                }
            }
        }
        .toolbar {
            Button("Guardar") {
                // Específico
                var resultado: [String] = []
                
                if opcion != "" {
                    resultado.append(opcion)
                }
                
                if opcion == "Aluminio" && aluminio != "" {
                    resultado.append("Tipo: \(aluminio)")
                }
                
                productVM.material = resultado.joined(separator: "\n")
                
                // Otro
                if otro != "" {
                    productVM.material = "\""+otro+"\""
                }
                
                // Anotación
                if anotacion != "" {
                    productVM.material += "\n(\(anotacion))"
                }

                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductCurvasFormView: View {
    
    var atributo = "Curva"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.curvas) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                }
                                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                if productVM.especifico != "" {
                    productVM.curvas = productVM.especifico
                    productVM.especifico = ""
                }
                
                if productVM.otro != "" {
                    productVM.curvas = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.curvas = productVM.curvas + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductColorFormView: View {
    
    var atributo = "Color"
    @ObservedObject var productVM: ProductViewModel
    
    @State var opcion: String = ""
    @State var color: String = ""
    @State var bicolor: Bool = false
    @State var exterior: String = ""
    @State var interior: String = ""
    @State var texturado: Bool = false
    @State var mate: Bool = false
    @State var anotacion: String = ""

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $opcion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                }
                
                if opcion == "Ral" {
                    Section(header: Text("Ral")) {
                        TextField("Ral", text: $color)
                    }
                }
                if opcion == "Anonizados" {
                    Section(header: Text("Anonizados")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.optionsFor(attribute: "Anonizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if opcion == "Madera" {
                    Section(header: Text("Madera")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.optionsFor(attribute: "Madera"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if opcion == "Más utilizados" {
                    Section(header: Text("Más utilizados")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.optionsFor(attribute: "Más utilizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                
                Toggle("Bicolor", isOn: $bicolor)
                    .onChange(of: bicolor) { newValue in
                        setBicolor()
                    }
                
                if bicolor {
                    Section(header: Text("Color exterior")) {
                        TextField("Exterior", text: $exterior)
                    }
                    Section(header: Text("Color interior")) {
                        TextField("Interior", text: $interior)
                    }
                }
                
                Section(header: Text("Acabados")) {
                    Toggle("Texturado", isOn: $texturado)
                    Toggle("Mate", isOn: $mate)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
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
                
                productVM.color = resultado.joined(separator: "\n")
                
                if anotacion != "" {
                    productVM.color += "\n(\(anotacion))"
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func setBicolor() {
        exterior = color
        interior = color
    }
    
}

struct ProductTapajuntasFormView: View {
    
    var atributo = "Tapajuntas"
    @ObservedObject var productVM: ProductViewModel
    
    @State var especificos: Bool = false
    @State var superior: Double = 0
    @State var inferior: Double = 0
    @State var izquierdo: Double = 0
    @State var derecho: Double = 0

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.tapajuntas) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }.onChange(of: productVM.tapajuntas) { newValue in
                        setTapajuntasEspecificos()
                    }
            
                }
                
                Toggle("Tapajuntas específicos", isOn: $especificos)
                    .onAppear {
                        setTapajuntasEspecificos()
                    }
                
                if especificos {
                    HStack {
                        Text("Superior\t")
                        Text(String(format: "%.0f", superior))
                        Slider(value: $superior, in: 0...100, step: 5)
                    }
                    HStack {
                        Text("Inferior\t\t")
                        Text(String(format: "%.0f", inferior))
                        Slider(value: $inferior, in: 0...100, step: 5)
                    }
                    HStack {
                        Text("Izquierdo\t")
                        Text(String(format: "%.0f", izquierdo))
                        Slider(value: $izquierdo, in: 0...100, step: 5)
                    }
                    HStack {
                        Text("Derecho\t")
                        Text(String(format: "%.0f", derecho))
                        Slider(value: $derecho, in: 0...100, step: 5)
                    }
                }

                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {

                var resultado: [String] = []

                if especificos {
                    if (superior != 0){
                        resultado.append("Superior: \(String(format: "%.0f", superior)) mm")
                    }
                    if (inferior != 0){
                        resultado.append("Inferior: \(String(format: "%.0f", inferior)) mm")
                    }
                    if (izquierdo != 0){
                        resultado.append("Izquierdo: \(String(format: "%.0f", izquierdo)) mm")
                    }
                    if (derecho != 0){
                        resultado.append("Derecho: \(String(format: "%.0f", derecho)) mm")
                    }
                    productVM.tapajuntas = resultado.joined(separator: "\n")
                }
                
                if productVM.otro != "" {
                    productVM.tapajuntas = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.tapajuntas = productVM.tapajuntas + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func setTapajuntasEspecificos() {
        superior = Double(productVM.tapajuntas) ?? 0
        inferior = Double(productVM.tapajuntas) ?? 0
        izquierdo = Double(productVM.tapajuntas) ?? 0
        derecho = Double(productVM.tapajuntas) ?? 0
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

struct ProductAperturaFormView: View {
    
    var atributo = "Apertura"
    @ObservedObject var productVM: ProductViewModel
    
    @State var vista: String = ""
    @State var abre: String = ""
    @State var mano: String = ""
    @State var corredera: String = ""
    @State var oscilobatiente: Bool = false
    @State var piven: Bool = false

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Tipo de apertura")) {
                    
                    if productVM.showIf(familias: ["Practicables", "Puertas"]) {
                        Toggle("Oscilobatiente", isOn: $oscilobatiente)
                    }
                    Toggle("Piven", isOn: $piven)
                }
                
                if productVM.notShowIf(familias: ["Correderas", "Fijos"]) {
                    if !piven {
                        Section(header: Text("Vista")) {
                            Picker("Vista", selection: $vista) {
                                List(["Dentro", "Fuera"], id: \.self) { item in Text(item) }
                            }
                            .pickerStyle(.segmented)
                        }
                    
                        Section(header: Text("Abre")) {
                            Picker("Abre", selection: $abre) {
                                List(["Interior", "Exterior"], id: \.self) { item in Text(item) }
                            }
                            .pickerStyle(.segmented)
                        }
                    
                        Section(header: Text("Mano")) {
                            Picker("Mano", selection: $mano) {
                                List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                }
                
                if productVM.showIf(familias: ["Correderas"]) {
                    Section(header: Text("Corredera")) {
                        Picker("Corredera", selection: $corredera) {
                            List(["Primera hoja izquierda", "Primera hoja derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                                            
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
                productVM.apertura = "Vista: \(vista)\nAbre: \(abre)\nMano: \(mano)"
                
                if oscilobatiente {
                    productVM.apertura = "Oscilobatiente"
                }
                
                if piven {
                    productVM.apertura = "Piven"
                }
                
                if corredera != "" {
                    productVM.apertura = corredera
                }
                
                if productVM.otro != "" {
                    productVM.apertura = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.apertura = productVM.apertura + "\n(\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductCompactoFormView: View {
    
    var atributo = "Compacto"
    @ObservedObject var productVM: ProductViewModel
    
    @State var compacto: String = ""
    @State var huella: String = ""
    @State var numeroPanos: Int = 0
    @State var motor: Bool = false
    @State var cable: String = ""
    @State var control: String = ""
    @State var recogedor: String = ""
    @State var exterior: Bool = false
    @State var colorExterior: String = ""
    @State var colorLama: String = ""
    @State var tamanoCajon: Bool = false
    @State var detallaObra: String = ""

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Tipo")) {
                    Picker(atributo, selection: $compacto) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Huella")) {
                    TextField("0 mm", text: $huella)
                }

                Section(header: Text("Paños")) {
                    Stepper("Número de paños:  \(numeroPanos)", value: $numeroPanos, in: 0...99)
                }
                
                Section(header: Text("Motor")) {
                    Toggle("Motor", isOn: $motor)
                }
                
                if motor {
                    Section(header: Text("Cables")) {
                        Picker("Cables", selection: $cable) {
                            List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }

                    Section(header: Text("Cables control")) {
                        Picker("Control", selection: $control) {
                            List(["Izquierda", "Derecha"], id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section(header: Text("Recogedor")) {
                    Picker("Recogedor", selection: $recogedor) {
                        List(["Izquierdo", "Derecho"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                    Toggle("Exterior", isOn: $exterior)
                }
                
                Section(header: Text("Color")) {
                    TextField("Exterior", text: $colorExterior)
                    TextField("Lama", text: $colorLama)
                }
                
                Section(header: Text("Cajón")) {
                    Toggle("Tamaño cajón", isOn: $tamanoCajon)
                }
                
                Picker("Detalles obra", selection: $detallaObra) {
                    if productVM.showIf(familias: ["Mini"]) {
                        List(["Sobre muro", "Tipo compacto", "Mini"], id: \.self) { item in Text(item) }
                    } else {
                        List(["Sobre muro", "Tipo compacto"], id: \.self) { item in Text(item) }
                    }
                }
                .pickerStyle(.segmented)
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
                var resultado: [String] = []
                
                if compacto != "" {
                    resultado.append(compacto)
                }
                
                if huella != "" {
                    resultado.append("Huella: \(huella) mm")
                }
                
                if numeroPanos != 0 {
                    resultado.append("Paños: \(numeroPanos)")
                }
                
                if recogedor != "" {
                    if exterior {
                        resultado.append("Recogedor: \(recogedor) exterior")
                    } else {
                        resultado.append("Recogedor: \(recogedor)")
                    }
                }
                
                if motor {
                    resultado.append("Con motor")
                    if cable != "" {
                        resultado.append("Cables motor: \(cable)")
                    }
                    if control != "" {
                        resultado.append("Cables control: \(control)")
                    }
                }
                
                if colorLama != "" {
                    resultado.append("Color lama: \(colorLama)")
                }
                
                if colorExterior != "" {
                    resultado.append("Color exterior: \(colorExterior)")
                }
                
                if tamanoCajon {
                    resultado.append("Con tamaño cajón")
                }
                
                if detallaObra != "" {
                    resultado.append("Detalles de obra: \(detallaObra)")
                }
                
                productVM.compacto = resultado.joined(separator: "\n")
                
                if productVM.anotacion != "" {
                    productVM.compacto = productVM.compacto + "\n(\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductMarcoInferiorFormView: View {
    
    var atributo = "Marco inferior"
    @ObservedObject var productVM: ProductViewModel
    
    @State var empotrado: String = ""
    @State var canalRecogeAgua: Bool = false

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker("Marco Inferior", selection: $productVM.marco_inferior) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if productVM.marco_inferior == "Empotrado" {
                    Section(header: Text("Empotrado")) {
                        Toggle("Canal recoge agua", isOn: $canalRecogeAgua)
                    }
                }
                                            
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $productVM.otro)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
                if canalRecogeAgua {
                    productVM.marco_inferior = productVM.marco_inferior + " con canal recoge agua"
                }
                
                if productVM.otro != "" {
                    productVM.marco_inferior = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.marco_inferior = productVM.marco_inferior + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductHuellaFormView: View {
    
    var atributo = "Huella"
    @ObservedObject var productVM: ProductViewModel
    
    @State var huella: String = ""
     
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Huella"), footer: Text("Unidad de medida: mm")) {
                    TextField("Huella", text: $huella)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Guardar") {
                
                productVM.huella = huella + " mm"
                
                if productVM.anotacion != "" {
                    productVM.huella = productVM.huella + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
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

struct ProductCristalFormView: View {
    
    var atributo = "Cristal"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.cristal) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
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
                
                if productVM.otro != "" {
                    productVM.cristal = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.cristal = productVM.cristal + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductCerradurasFormView: View {
    
    var atributo = "Cerraduras"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.cerraduras) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
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
                
                if productVM.otro != "" {
                    productVM.cerraduras = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.cerraduras = productVM.cerraduras + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductManetasFormView: View {
    
    var atributo = "Manetas"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.manetas) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
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
                
                if productVM.otro != "" {
                    productVM.manetas = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.manetas = productVM.manetas + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
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
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductInstalacionFormView: View {
    
    var atributo = "Instalación"
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.instalacion) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
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
                
                if productVM.otro != "" {
                    productVM.instalacion = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.instalacion = productVM.instalacion + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductMallorquinaFormView: View {
    
    var atributo = "Mallorquina"
    @ObservedObject var productVM: ProductViewModel
    
    @State var tubo: Bool = false
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.persiana) {
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                }
                
                Toggle("Tubo", isOn: $tubo)
                
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
                
                if tubo {
                    productVM.persiana = productVM.persiana + " con tubo"
                }
                
                if productVM.otro != "" {
                    productVM.persiana = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.persiana = productVM.persiana + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}


// Detail Views
struct ProductDetailView: View {
    @ObservedObject var productVM: ProductViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                if productVM.copias == 1 {
                    Text(productVM.getSingularFamilia(name: productVM.familia))
                        .font(.title)
                        .lineLimit(1)
                } else {
                    Text(String(productVM.copias)+" "+productVM.getFamilia())
                        .font(.title)
                        .lineLimit(1)
                }
                Text(productVM.material)
                    .font(.subheadline)
                Text(productVM.color)
                    .font(.subheadline)
                Text(productVM.getDimensiones(option: "ancho x alto"))
                    .font(.subheadline)
            }
            Spacer()
            
            if productVM.nombre == "" {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else {
                Image(productVM.nombre)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
                
        }
    }
}

struct ProductDetailAllView: View {
    @ObservedObject var productVM: ProductViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                
                HStack {
                    Text("Familia")
                    Spacer()
                    Text(productVM.familia)
                }
                .font(.subheadline)
                
                HStack {
                    Text("Nombre")
                    Spacer()
                    Text(productVM.nombre)
                }
                .font(.subheadline)

                HStack {
                    Text("Material")
                    Spacer()
                    Text(productVM.material)
                }
                .font(.subheadline)

                HStack {
                    Text("Color")
                    Spacer()
                    Text(productVM.color)
                }
                .font(.subheadline)
                
                HStack {
                    Text("Tapajuntas")
                    Spacer()
                    Text(productVM.tapajuntas)
                }
                .font(.subheadline)

                HStack {
                    Text("Dimensiones")
                    Spacer()
                    Text(productVM.dimensiones)
                }
                .font(.subheadline)

                HStack {
                    Text("Apertura")
                    Spacer()
                    Text(productVM.apertura)
                }
                .font(.subheadline)

                HStack {
                    Text("Marco inferior")
                    Spacer()
                    Text(productVM.marco_inferior)
                }
                .font(.subheadline)

                HStack {
                    Text("Huella")
                    Spacer()
                    Text(productVM.huella)
                }
                .font(.subheadline)

            }

            Group {
                HStack {
                    Text("Forro exterior")
                    Spacer()
                    Text(productVM.forro_exterior)
                }
                .font(.subheadline)

                HStack {
                    Text("Cristal")
                    Spacer()
                    Text(productVM.cristal)
                }
                .font(.subheadline)

                HStack {
                    Text("Mallorquina")
                    Spacer()
                    Text(productVM.persiana)
                }
                .font(.subheadline)

                HStack {
                    Text("Cerraduras")
                    Spacer()
                    Text(productVM.cerraduras)
                }
                .font(.subheadline)

                HStack {
                    Text("Manetas")
                    Spacer()
                    Text(productVM.manetas)
                }
                .font(.subheadline)

                HStack {
                    Text("Herraje")
                    Spacer()
                    Text(productVM.herraje)
                }
                .font(.subheadline)

                HStack {
                    Text("Posición")
                    Spacer()
                    Text(productVM.posicion)
                }
                .font(.subheadline)

                HStack {
                    Text("Instalación")
                    Spacer()
                    Text(productVM.instalacion)
                }
                .font(.subheadline)
                
                HStack {
                    Text("Remates albañilería")
                    Spacer()
                    if productVM.remates_albanileria {
                        Text("Si")
                    } else {
                        Text("No")
                    }
                }
                .font(.subheadline)
                
                HStack {
                    Text("Medidas No Buenas")
                    Spacer()
                    if productVM.medidas_no_buenas {
                        Text("Si")
                    } else {
                        Text("No")
                    }
                }
                .font(.subheadline)
                
            }
        }
    }
}


// Otros
struct treeView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        ScrollView {
            ProductSelectDirectoryListView(optionSelect: optionSelect, productVM: productVM)
            ProductSelectListView(optionSelect: optionSelect, productVM: productVM)
        }.navigationTitle(Text(optionSelect))
    }
}

struct ProductSelectDirectoryListView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel
    
    @State private var seleccion = ""
    @State private var isShowingNextView = false
    
    var body: some View {
        NavigationLink(destination: treeView(optionSelect: seleccion, productVM: productVM), isActive: $isShowingNextView) { EmptyView() }

        ForEach(productVM.optionsFor(attribute: "Directorio \(optionSelect)"), id: \.self) { nombre in

            Button(
                action: {
                    seleccion = nombre
                    isShowingNextView = true
                },
                label: {
                    VStack {
                        Text(nombre)
                            .textStyle(NavigationLinkStyle())
                    }
                }
            )
        }
    }
}

struct ProductSelectListView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30)), count: 2), spacing: 10){
            ForEach(productVM.optionsFor(attribute: optionSelect), id: \.self) { nombre in
                Button(
                    action: {
                        productVM.nombre = nombre
                        productVM.save()
                    },
                    label: {
                        VStack {
                            Image(nombre)
                                .resizable()
                                .scaledToFit()
                                //.shadow(radius: 3)
                        }
                    }
                )
            }
        }
        .padding()
    }
}

struct ProductListView: View {
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        List {
            ForEach(productVM.productos){ producto in
                NavigationLink(destination: ProductCreateView(productVM: ProductViewModel(product: producto)), label: {
                    ProductDetailView(productVM: ProductViewModel(product: producto))
                })
            }
            .onDelete(perform: deleteProduct)
        }
        .onAppear(perform: productVM.getAllProducts)
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: productVM.productos)
        }
    }
}
