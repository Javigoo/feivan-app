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

struct ProductNewView: View {
    
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        Text("ProductNewView")
        //ProductFamiliaFormView(productVM: productVM)
            //.navigationTitle(Text("Nuevo producto"))
    }
}

struct ProductCreateView: View {

    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        VStack {
            Form {
                //ProductFormView(productVM: productVM)

                Button("Guardar") {
                    productVM.save()
                }
            }
        }
    }
}

struct ProductUpdateView: View {
    
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(producto: producto, productVM: productVM)
        }.onAppear {
            productVM.getProduct(producto: producto)
        }.toolbar {
            Button("Actualizar") {
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductFormView: View {
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    var body: some View {
    
        VStack {
                
            NavigationLink(
                destination: ProductFamiliaFormView(producto: producto, productVM: productVM),
                label: {
                    if productVM.familia == "" {
                        Text("Familia")
                            .font(.title)
                    } else {
                        Text(productVM.getFormattedName(name: productVM.familia))
                            .font(.title)
                    }
                }
            )
                
            NavigationLink(
                destination: ProductNombreFormView(producto: producto, productVM: productVM),
                label: {
                    if productVM.nombre == "" {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(productVM.nombre)
                            .resizable()
                            .scaledToFit()
                    }
                }
            )
        }
        
        
        Form {
            Group {
                NavigationLink(
                    destination: ProductCurvasFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Curvas")
                            Spacer()
                            Text(productVM.curvas)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductMaterialFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Material")
                            Spacer()
                            Text(productVM.material)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductColorFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Color")
                            Spacer()
                            Text(productVM.color)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductTapajuntasFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Tapajuntas")
                            Spacer()
                            Text(productVM.tapajuntas)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductDimensionesFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Dimensiones")
                            Spacer()
                            Text(productVM.dimensiones)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductAperturaFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Apertura")
                            Spacer()
                            Text(productVM.apertura)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductMarcoInferiorFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Marco inferior")
                            Spacer()
                            Text(productVM.marcoInferior)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductHuellaFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Huella")
                            Spacer()
                            Text(productVM.huella)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductForroExteriorFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Forro exterior")
                            Spacer()
                            Text(productVM.forroExterior)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductCristalFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Cristal")
                            Spacer()
                            Text(productVM.cristal)
                        }
                    }
                )
            }
            
            Group {
                NavigationLink(
                    destination: ProductCerradurasFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Cerraduras")
                            Spacer()
                            Text(productVM.cerraduras)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductManetasFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Manetas")
                            Spacer()
                            Text(productVM.manetas)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductHerrajeFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Herraje")
                            Spacer()
                            Text(productVM.herraje)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductPosicionFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Posición")
                            Spacer()
                            Text(productVM.posicion)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductInstalacionFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Instalación")
                            Spacer()
                            Text(productVM.instalacion)
                        }
                    }
                )
                
                NavigationLink(
                    destination: ProductMallorquinaFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Mallorquina")
                            Spacer()
                            Text(productVM.mallorquina)
                        }
                    }
                )
                
                Section(header: Text("Extras")) {
                    Toggle(isOn: $productVM.rematesAlbanileria) {
                        Text("Remates Albañilería")
                    }
                    Toggle(isOn: $productVM.medidasNoBuenas) {
                        Text("Medidas no buenas")
                    }
                }
            }
        }
    }
}



// Product form views
struct ProductFamiliaFormView: View {
    
    var atributo = "Familia"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @State private var isShowingNextView = false
    //@Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            NavigationLink(destination: ProductNombreFormView(producto: producto, productVM: productVM), isActive: $isShowingNextView) { EmptyView() }
            
            ForEach(productVM.listOf(option: "directorios Estructuras ordenadas"), id: \.self) { familia in
                Button(
                    action: {
                        productVM.familia = familia
                        productVM.update(producto: producto)
                        isShowingNextView = true
                        //presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text(productVM.getFormattedName(name: familia))
                            .font(.title)
                    }
                )
            }
        }
    }
}

struct ProductNombreFormView: View {
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    var body: some View {
        treeView(optionSelect: productVM.familia, producto: producto, productVM: productVM)
    }
}

struct ProductMaterialFormView: View {
    
    var atributo = "Material"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.material) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if productVM.material == "Aluminio" {
                    Section(header: Text("Aluminio")) {
                        Picker("Aluminio", selection: $productVM.especifico) {
                            List(productVM.listOf(option: "Material Aluminio"), id: \.self) { item in Text(item) }
                        }
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
            Button("Aceptar") {
                if productVM.especifico != "" {
                    productVM.material = productVM.especifico
                    productVM.especifico = ""
                }
                
                if productVM.otro != "" {
                    productVM.material = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.material = productVM.material + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductCurvasFormView: View {
    
    var atributo = "Curvas"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.curvas) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
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
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductColorFormView: View {
    
    var atributo = "Color"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    @State var color: String = ""
    @State var bicolor: Bool = false
    @State var exterior: String = ""
    @State var interior: String = ""
    @State var texturado: Bool = false
    @State var mate: Bool = false

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.color) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
                    }
                }
                
                if productVM.color == "Ral" {
                    Section(header: Text("Ral")) {
                        TextField("Ral", text: $color)
                    }
                }
                if productVM.color == "Anonizados" {
                    Section(header: Text("Anonizados")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.listOf(option: "Anonizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if productVM.color == "Madera" {
                    Section(header: Text("Madera")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.listOf(option: "Madera"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if productVM.color == "Más utilizados" {
                    Section(header: Text("Más utilizados")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.listOf(option: "Más utilizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                
                Toggle("Bicolor", isOn: $bicolor)
                    .onChange(of: bicolor) { newValue in
                        setBicolor()
                    }
                
                if bicolor {
                    TextField("Exterior", text: $exterior)
                    TextField("Interior", text: $interior)
                }
                
                Section(header: Text("Acabados")) {
                    Toggle("Texturado", isOn: $texturado)
                    Toggle("Mate", isOn: $mate)
                }
                
                Section(header: Text("Anotación")) {
                    TextField("Introduce una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Aceptar") {
                
                productVM.color = color
                
                if bicolor {
                    productVM.color = "Exterior: " + exterior + ", Interior: " + interior
                }
                
                if texturado {
                    productVM.color = color + " (Texturado)"
                }
                
                if mate {
                    productVM.color = color + " (Mate)"
                }
                
                if productVM.anotacion != "" {
                    productVM.color = color + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
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
    @ObservedObject var producto: Producto
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
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
                if especificos {
                    var valoresEspecificos: [String] = []
                    if (superior != 0){
                        valoresEspecificos.append("Superior: \(String(format: "%.0f", superior))")
                    }
                    if (inferior != 0){
                        valoresEspecificos.append("Inferior: \(String(format: "%.0f", inferior))")
                    }
                    if (izquierdo != 0){
                        valoresEspecificos.append("Izquierdo: \(String(format: "%.0f", izquierdo))")
                    }
                    if (derecho != 0){
                        valoresEspecificos.append("Derecho: \(String(format: "%.0f", derecho))")
                    }
                    productVM.tapajuntas = valoresEspecificos.joined(separator: ", ")
                }
                
                if productVM.otro != "" {
                    productVM.tapajuntas = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.tapajuntas = productVM.tapajuntas + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
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
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    @State var ancho: String = ""
    @State var alto: String = ""
    
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
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $productVM.anotacion)
                }
            }
        }
        .navigationTitle(atributo)
        .toolbar {
            Button("Aceptar") {
                
                productVM.dimensiones = "\(ancho)x\(alto) mm"
                
                if productVM.anotacion != "" {
                    productVM.dimensiones = productVM.dimensiones + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductAperturaFormView: View {
    
    var atributo = "Apertura"
    @ObservedObject var producto: Producto
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
                    Toggle("Oscilobatiente", isOn: $oscilobatiente)
                    Toggle("Piven", isOn: $piven)
                }
                
                if !oscilobatiente && !piven {
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
                
                Section(header: Text("Corredera")) {
                    Picker("Corredera", selection: $corredera) {
                        List(["Primera hoja izquierda", "Primera hoja derecha"], id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
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
            Button("Aceptar") {
                
                productVM.apertura = "Vista: \(vista), Abre: \(abre), Mano: \(mano)"
                
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
                    productVM.apertura = productVM.apertura + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductMarcoInferiorFormView: View {
    
    var atributo = "Marco inferior"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    @State var empotrado: String = ""
    @State var canalRecogeAgua: Bool = false

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker("Marco Inferior", selection: $productVM.marcoInferior) {
                        List(productVM.listOf(option: "MarcoInferior"), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if productVM.marcoInferior == "Empotrado" {
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
            Button("Aceptar") {
                
                if canalRecogeAgua {
                    productVM.marcoInferior = productVM.marcoInferior + " con canal recoge agua"
                }
                
                if productVM.otro != "" {
                    productVM.marcoInferior = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.marcoInferior = productVM.marcoInferior + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductHuellaFormView: View {
    
    var atributo = "Huella"
    @ObservedObject var producto: Producto
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
            Button("Aceptar") {
                
                productVM.huella = huella + " mm"
                
                if productVM.anotacion != "" {
                    productVM.huella = productVM.huella + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductForroExteriorFormView: View {
    
    var atributo = "Forro exterior"
    @ObservedObject var producto: Producto
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
            Button("Aceptar") {
                
                
                if productVM.otro != "" {
                    productVM.forroExterior = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.forroExterior = productVM.forroExterior + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductCristalFormView: View {
    
    var atributo = "Cristal"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.cristal) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
                
                if productVM.otro != "" {
                    productVM.cristal = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.cristal = productVM.cristal + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductCerradurasFormView: View {
    
    var atributo = "Cerraduras"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.cerraduras) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
                
                if productVM.otro != "" {
                    productVM.cerraduras = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.cerraduras = productVM.cerraduras + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductManetasFormView: View {
    
    var atributo = "Manetas"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.manetas) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
                
                if productVM.otro != "" {
                    productVM.manetas = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.manetas = productVM.manetas + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductHerrajeFormView: View {
    
    var atributo = "Herraje"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.herraje) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
                
                if productVM.otro != "" {
                    productVM.herraje = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.herraje = productVM.herraje + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductPosicionFormView: View {
    
    var atributo = "Posición"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    @State var ventana: Int = 0
    @State var puerta: Int = 0
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Zonas")) {
                    Picker(atributo, selection: $productVM.posicion) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
                    }
                }
                
                Section(header: Text("Ubicación")) {
                    Stepper("Ventana V\(ventana)", value: $ventana, in: 0...99)
                    Stepper("Puerta V\(puerta)", value: $puerta, in: 0...99)
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
            Button("Aceptar") {
                
                if productVM.otro != "" {
                    productVM.posicion = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.posicion = productVM.posicion + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductInstalacionFormView: View {
    
    var atributo = "Instalación"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.instalacion) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
                
                if productVM.otro != "" {
                    productVM.instalacion = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.instalacion = productVM.instalacion + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductMallorquinaFormView: View {
    
    var atributo = "Mallorquina"
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    @State var tubo: Bool = false
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Picker(atributo, selection: $productVM.mallorquina) {
                        List(productVM.listOf(option: atributo), id: \.self) { item in Text(item) }
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
            Button("Aceptar") {
                
                if tubo {
                    productVM.mallorquina = productVM.mallorquina + " con tubo"
                }
                
                if productVM.otro != "" {
                    productVM.mallorquina = productVM.otro
                    productVM.otro = ""
                }
                
                if productVM.anotacion != "" {
                    productVM.mallorquina = productVM.mallorquina + " (\(productVM.anotacion))"
                    productVM.anotacion = ""
                }
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}



// Detail Views
struct ProductDetailView: View {
    @ObservedObject var producto: Producto
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                
                HStack {
                    Text("Familia")
                    Spacer()
                    Text(producto.familia ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Nombre")
                    Spacer()
                    Text(producto.nombre ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Material")
                    Spacer()
                    Text(producto.material ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Color")
                    Spacer()
                    Text(producto.color ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Tapajuntas")
                    Spacer()
                    Text(producto.tapajuntas ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Dimensiones")
                    Spacer()
                    Text(producto.dimensiones ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Apertura")
                    Spacer()
                    Text(producto.apertura ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Marco inferior")
                    Spacer()
                    Text(producto.marcoInferior ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Huella")
                    Spacer()
                    Text(producto.huella ?? "...")
                }
                .font(.subheadline)

            }

            Group {
                HStack {
                    Text("Forro exterior")
                    Spacer()
                    Text(producto.forroExterior ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Cristal")
                    Spacer()
                    Text(producto.cristal ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Mallorquina")
                    Spacer()
                    Text(producto.mallorquina ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Cerraduras")
                    Spacer()
                    Text(producto.cerraduras ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Manetas")
                    Spacer()
                    Text(producto.manetas ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Herraje")
                    Spacer()
                    Text(producto.herraje ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Posición")
                    Spacer()
                    Text(producto.posicion ?? "...")
                }
                .font(.subheadline)

                HStack {
                    Text("Instalación")
                    Spacer()
                    Text(producto.instalacion ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Remates albañilería")
                    Spacer()
                    if producto.rematesAlbanileria {
                        Text("Si")
                    } else {
                        Text("No")
                    }
                }
                .font(.subheadline)
                
                HStack {
                    Text("Medidas No Buenas")
                    Spacer()
                    if producto.medidasNoBuenas {
                        Text("Si")
                    } else {
                        Text("No")
                    }
                }
                .font(.subheadline)
                
            }
            Group {
                
                HStack {
                    Text("Hoja principal")
                    Spacer()
                    Text(producto.hojaPrincipal ?? "...")
                }
                .font(.subheadline)
                
            }
        }
    }
}

struct ProductDetailPreviewView: View {

    @ObservedObject var productoVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        Text("ProductDetailPreviewView")
    }
}



// Otros
struct treeView: View {
    var optionSelect: String
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        ScrollView {
            ProductSelectDirectoryListView(optionSelect: optionSelect, producto: producto, productVM: productVM)
            ProductSelectListView(optionSelect: optionSelect, producto: producto, productVM: productVM)
        }
    }
}

struct ProductSelectDirectoryListView: View {
    var optionSelect: String
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    
    @State private var seleccion = ""
    @State private var isShowingNextView = false
    
    var body: some View {
        NavigationLink(destination: treeView(optionSelect: seleccion, producto: producto, productVM: productVM), isActive: $isShowingNextView) { EmptyView() }

        ForEach(productVM.listOf(option: "directorios \(optionSelect)"), id: \.self) { producto in

            Button(
                action: {
                    seleccion = producto
                    isShowingNextView = true
                },
                label: {
                    VStack {
                        Text(productVM.getFormattedName(name: producto))
                            .font(.title)
                    }
                }
            )
        }
    }
}

struct ProductSelectListView: View {
    var optionSelect: String
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30)), count: 2), spacing: 10){
            ForEach(productVM.listOf(option: "archivos \(optionSelect)"), id: \.self) { nombre in
                Button(
                    action: {
                        productVM.nombre = nombre
                        productVM.update(producto: producto)
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
