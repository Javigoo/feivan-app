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

    @StateObject var producto: Producto = Producto(context: PersistenceController.shared.viewContext)
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        VStack {
            ProductFormView(producto: producto, productVM: productVM)
        }.toolbar {
            Button("Guardar") {
                productVM.save()
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
            Button("Guardar") {
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductFormView: View {
    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
      
    //@State private var anadirMas = false

    var body: some View {
        //NavigationLink(destination: ProductUpdateView(producto: productoAnadirMas, productVM: productVM), isActive: $anadirMas) { EmptyView() }

        ProductDetailPreviewView(producto: producto, productVM: productVM)
        
        Form {
            Group {
                if productVM.getFormattedName(name: productVM.familia) == "Curvas" {
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
                }
                
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
                    destination: ProductCompactoFormView(producto: producto, productVM: productVM),
                    label: {
                        HStack {
                            Text("Compacto")
                            Spacer()
                            Text(productVM.compacto)
                        }
                    }
                )
                
                if productVM.getFormattedName(name: productVM.familia) != "Fijos" &&
                    productVM.getFormattedName(name: productVM.familia) != "Correderas" {
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
                }
                
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
                
                if productVM.getFormattedName(name: productVM.familia) != "Persiana" {
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
                }
            }
            
            Group {
                if productVM.getFormattedName(name: productVM.familia) != "Persiana" {
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
                
                if productVM.getFormattedName(name: productVM.familia) == "Persiana" {
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
                }
                
                Section(header: Text("Extras")) {
                    Toggle(isOn: $productVM.rematesAlbanileria) {
                        Text("Remates Albañilería")
                    }
                    Toggle(isOn: $productVM.medidasNoBuenas) {
                        Text("Medidas no buenas")
                    }
                    Stepper("Copias:  \(productVM.copias)", value: $productVM.copias, in: 1...99)
                }
            }
            
            Group {
                HStack {
                    NavigationLink(
                        destination: ProductCreateView(productVM: productVM),
                        label: {
                            Text("Añadir más")
                        }
                    )
                    Button(
                        action: {
                            print("Añadiendo más")
                            // Crear un nuevo producto añadiendole los atributos que no deben cambiar
                            // Pasarselo a la siguiente vista
                            

                        },
                        label: {
                            Text("Añadir más")
                        }
                    )
                    Spacer()
                    Button(
                        action: {
                            print("Añadiendo otro")
                            // NavLink to ProductCreateView
                        },
                        label: {
                            Text("Añadir otro")
                        }
                    )
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
            
            ForEach(productVM.optionsFor(attribute: "directorios Estructuras ordenadas"), id: \.self) { familia in
                Button(
                    action: {
                        productVM.familia = familia
                        productVM.update(producto: producto)
                        isShowingNextView = true
                        //presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text(productVM.getFormattedName(name: familia))
                            .textStyle(NavigationLinkStyle())
                    }
                )
            }
        }
        .navigationTitle(Text("Familias"))
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
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
                    }
                    .pickerStyle(.segmented)
                }
                
                if productVM.material == "Aluminio" {
                    if productVM.getFormattedName(name: productVM.familia) == "Correderas" {
                        Section(header: Text("Aluminio")) {
                            Picker("Aluminio", selection: $productVM.especifico) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Correderas"), id: \.self) { item in Text(item) }
                            }
                        }
                    }
                    if productVM.getFormattedName(name: productVM.familia) == "Practicables" {
                        Section(header: Text("Aluminio")) {
                            Picker("Aluminio", selection: $productVM.especifico) {
                                List(productVM.optionsFor(attribute: "Material Aluminio Ventanas"), id: \.self) { item in Text(item) }
                            }
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
            Button("Guardar") {
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
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
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
                            List(productVM.optionsFor(attribute: "Anonizados"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if productVM.color == "Madera" {
                    Section(header: Text("Madera")) {
                        Picker(atributo, selection: $color) {
                            List(productVM.optionsFor(attribute: "Madera"), id: \.self) { item in Text(item) }
                        }
                    }
                }
                if productVM.color == "Más utilizados" {
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
            Button("Guardar") {
                
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
                    if productVM.getFormattedName(name: productVM.familia) == "Practicables" ||
                        productVM.getFormattedName(name: productVM.familia) == "Puertas" {
                        Toggle("Oscilobatiente", isOn: $oscilobatiente)
                    }
                    Toggle("Piven", isOn: $piven)
                }
                
                if productVM.getFormattedName(name: productVM.familia) != "Correderas" &&
                    productVM.getFormattedName(name: productVM.familia) != "Fijos" {
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
                
                if productVM.getFormattedName(name: productVM.familia) == "Correderas" {
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
                
                productVM.update(producto: producto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductCompactoFormView: View {
    
    var atributo = "Compacto"
    @ObservedObject var producto: Producto
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
                    if productVM.getFormattedName(name: productVM.familia) == "Mini" {
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
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
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
            Button("Guardar") {
                
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
            Button("Guardar") {
                
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
            Button("Guardar") {
                
                
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
                        List(productVM.optionsFor(attribute: atributo), id: \.self) { item in Text(item) }
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
            Button("Guardar") {
                
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
    var productVM = ProductViewModel()
    @ObservedObject var producto: Producto
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                if producto.copias == 1 {
                    Text(productVM.getSingularFamilia(name: producto.familia ?? ""))
                        .font(.title)
                        .lineLimit(1)
                } else {
                    Text(String(producto.copias)+" "+productVM.getFormattedName(name: producto.familia ?? ""))
                        .font(.title)
                        .lineLimit(1)
                }
                Text(producto.material ?? "")
                    .font(.subheadline)
                Text(producto.color ?? "")
                    .font(.subheadline)
                Text(productVM.getFormattedDimension(dimension: producto.dimensiones ?? ""))
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
        }
    }
}

struct ProductDetailPreviewView: View {

    @ObservedObject var producto: Producto
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
                
            NavigationLink(
                destination: ProductFamiliaFormView(producto: producto, productVM: productVM),
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
                destination: ProductNombreFormView(producto: producto, productVM: productVM),
                label: {
                    if productVM.nombre == "" {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    } else {
                        Image(productVM.nombre)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                }
            )
        }
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
        }.navigationTitle(Text(productVM.getFormattedName(name: optionSelect)))
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

        ForEach(productVM.optionsFor(attribute: "directorios \(optionSelect)"), id: \.self) { nombre in

            Button(
                action: {
                    seleccion = nombre
                    isShowingNextView = true
                },
                label: {
                    VStack {
                        Text(productVM.getFormattedName(name: nombre))
                            .textStyle(NavigationLinkStyle())
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
            ForEach(productVM.optionsFor(attribute: "archivos \(optionSelect)"), id: \.self) { nombre in
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

struct ProductListView: View {
    
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        List {
            ForEach(productVM.productos){ producto in
                NavigationLink(destination: ProductUpdateView(producto: producto, productVM: productVM), label: {
                    ProductDetailView(producto: producto)
                })
            }
            .onDelete(perform: deleteProduct)
        }
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: productVM.productos)
        }
    }
}
