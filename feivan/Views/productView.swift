//
//  productView.swift
//  feivan
//
//  Created by javigo on 23/9/21.
//

import SwiftUI

struct productView: View {
    var body: some View {
        Text("productView")
    }
}


struct familyView: View {
    
    //var cliente: Cliente
        
    @Environment(\.managedObjectContext) var viewContext
    
    /*
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.timestamp, ascending: false)],
        predicate: NSPredicate(format: "nombre == A"),
        fetchLimit: 1,
        animation: .default
    )
    private var aaa: FetchedResults<Cliente>
     */
    
    @State private var selectedFamilia: String = ""
    let familias = ["Correderas", "Practicables", "Puertas", "Puertas apertura exterior", "Elevadoras", "Mallorquinas", "Barandillas", "Puerta bandera"]
    
    var body: some View {
        let producto = Producto(context: viewContext)
        
        // Form here ? - para unificar la estetica
        VStack(spacing: 25) {
            //Text(cliente.nombre ?? "no encontrado")
            ForEach(familias, id: \.self) { familia in
                VStack {
                    NavigationLink(destination: productView(), label: {
                        Text(familia)
                            .textStyle(NavigationLinkStyle())
                    })
                    .simultaneousGesture(TapGesture().onEnded{
                        producto.id = UUID()
                        producto.timestamp = Date()
                        producto.familia = selectedFamilia
                        do {
                            try viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    })
                }
            }
        }
        .navigationTitle("Familia")
    }
}


struct selectProductView: View {
    let productos = ["Corredera de 2 hojas con fijo inferior",
                     "Corredera de 2 hojas con fijo superior",
                     "Corredera de 2 hojas",
                     "Corredera de 3 hojas",
                     "Corredera de 4 hojas"]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
                ForEach(productos, id: \.self) { producto in
                    NavigationLink(destination: configurationView(), label: {
                        VStack {
                            Image(producto)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                            Text(producto)
                                .font(.subheadline)
                        }
                    })
                    .padding()
                    .accentColor(.black)

                }
            }
            .padding()
        }
        .navigationTitle("Productos")
    }
}
        
struct configurationView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    let producto = ["Material", "Dimensiones", "Color", "Tapajuntas", "Apertura", "Cristal", "Forro exterior", "Instalación", "Mallorquina", "Cierres", "Marco inferior", "Huella", "Marco", "Herraje", "Ubicación", "Remates albañilería", "Añadir foto"]
    
    let materialOpciones = ["PVC", "Aluminio", "Otro"]
    let tapajuntasOpciones = ["30", "40", "60", "80", "100"]
    let mallorquinaOpciones = ["Lama móvil", "Lama fija", "Travesaño horizontal", "Travesaño vertical", "Cruceta", "Persiana planta baja 4 hojas", "Persiana planta baja hoja sobre hoja", "Persiana planta baja apertura libro", "Otro"]
    let cierresOpciones = ["Cremona", "Cerradura", "Cerradura 3 puntos", "Pasadores", "Maneta presión", "Maneta interior/exterior", "Solo maneta interior", "Solo maneta exterior", "Otro"]
    let marcoInferiorOpciones = ["Abierto", "Cerrado", "Solera"]
    let marcoOpciones = ["Abierto", "Cerrado", "Solera"]
    let herrajeOpciones = ["Mismo color", "Bisagras seguridad","Cierre clip + Uñero", "Muelle", "Cerradura electrónica", "Tirador exterior", "Tirador exterior/interior", "Bisagra oculta", "Herraje minimalista"]
    let cristalOpciones = ["Cámara", "4/Cámara/6", "4/Cámara/4+4", "6/?/4+4 silence", "4+4", "5+5", "6+6", "Otro"]
    let instalacionOpciones = ["Huella obra", "Premarco", "Desmontando madera", "Desmontando hierro", "Desmontando aluminio"]
    let forroExteriorOpciones = ["Pletina", "40", "60", "Otro"]
    
    @State private var material = ""
    @State private var dimensiones = ""
    @State private var color = ""
    @State private var tapajuntas = ""
    @State private var apertura = ""
    @State private var cristal = ""
    @State private var forroExterior = ""
    @State private var instalacion = ""
    @State private var mallorquina = ""
    @State private var cierres = ""
    @State private var marcoInferior = ""
    @State private var huella = ""
    @State private var marco = ""
    @State private var herraje = ""
    @State private var posicion = ""
    @State private var ubicacion = ""
    @State private var rematesAlbanileria: Bool = false
    @State private var foto = ""
    
    @State private var ancho = ""
    @State private var alto = ""
    
    @State private var vista = ""
    @State private var abre = ""
    @State private var mano = ""

    @State private var materialOtro = ""
    @State private var mallorquinaOtro = ""
    @State private var cierresOtro = ""
    @State private var forroExteriorOtro = ""
    @State private var cristalOtro = ""

    
    var body: some View {
        VStack {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Image("Corredera de 2 hojas con fijo inferior")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 5)
                    Text("Corredera de 2 hojas con fijo inferior")
                }
                VStack(alignment: .leading) {
                    Group {
                        Text("Material: \(material)")
                        Text("Dimensiones: \(dimensiones)")
                        Text("Color: \(color)")
                        Text("Tapajuntas: \(tapajuntas)")
                        Text("Apertura: \(apertura)")
                        Text("Cristal: \(cristal)")
                        Text("Forro Exterior: \(forroExterior)")
                        Text("Instalación: \(instalacion)")
                        Text("Mallorquina: \(mallorquina)")
                        Text("Cierres: \(cierres)")
                    }
                    Group{
                        Text("Marco Inferior: \(marcoInferior)")
                        Text("Huella: \(huella)")
                        Text("Marco: \(marco)")
                        Text("Herraje: \(herraje)")
                        Text("Posición: \(posicion)")
                        Text("Ubicación: \(ubicacion)")
                        if rematesAlbanileria {
                            Text("Remates Albañilería: Si")
                        } else {
                            Text("Remates Albañilería: No")
                        }
                    }
                    Spacer()
                }
            }
            .padding()
        
            
            Form {
                Group {
                    Section(header: Text("Material")) {
                        Picker("Material", selection: $material) {
                            List(materialOpciones, id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                        if material == "Otro" {
                            TextField("Introduce otra opción", text: $materialOtro)
                        }
                    }
                    
                    Section(header: Text("Dimensiones"), footer: Text("Unidad de medida: cm")) {
                        HStack {
                            TextField("Ancho", text: $ancho)
                            Divider()
                            TextField("Alto", text: $alto)
                        }
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                    }
                    
                    Section(header: Text("Color")) {
                        TextField("Color", text: $color)
                    }
                
                    Section(header: Text("Tapajuntas")) {
                        Picker("Tapajuntas", selection: $tapajuntas) {
                            List(tapajuntasOpciones, id: \.self) { item in Text(item) }
                        }
                    }
                    
                    Section(header: Text("Apertura")) {
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
                    
                    Section(header: Text("Cristal")) {
                        Picker("Cristal", selection: $cristal) {
                            List(cristalOpciones, id: \.self) { item in Text(item) }
                        }
                        if cristal == "Otro" {
                            TextField("Introduce otra opción", text: $cristalOtro)
                        }

                    }
                    
                    Section(header: Text("Forro exterior")) {
                        Picker("Forro exterior", selection: $forroExterior) {
                            List(forroExteriorOpciones, id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                        if forroExterior == "Otro" {
                            TextField("Introduce otra opción", text: $forroExteriorOtro)
                        }
                    }
                    
                    Section(header: Text("Instalación")) {
                        Picker("Instalación", selection: $instalacion) {
                            List(instalacionOpciones, id: \.self) { item in Text(item) }
                        }
                    }
                    
                    Section(header: Text("Mallorquina")) {
                        Picker("Mallorquina", selection: $mallorquina) {
                            List(mallorquinaOpciones, id: \.self) { item in Text(item) }
                        }
                        if mallorquina == "Otro" {
                            TextField("Introduce otra opción", text: $mallorquinaOtro)
                        }
                    }
                   
                    Section(header: Text("Cierres")) {
                        Picker("Cierres", selection: $cierres) {
                            List(cierresOpciones, id: \.self) { item in Text(item) }
                        }
                        if cierres == "Otro" {
                            TextField("Introduce otra opción", text: $cierresOtro)
                        }
                    }
                }
                
                Group {
                    Section(header: Text("Marco Inferior")) {
                        Picker("Marco Inferior", selection: $marcoInferior) {
                            List(marcoInferiorOpciones, id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section(header: Text("Huella"), footer: Text("Unidad de medida: cm")) {
                        TextField("Huella", text: $huella)
                            .keyboardType(.numberPad)
                    }
                    
                    Section(header: Text("Marco")) {
                        Picker("Marco", selection: $marco) {
                            List(marcoOpciones, id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section(header: Text("Herraje")) {
                        Picker("Herraje", selection: $herraje) {
                            List(herrajeOpciones, id: \.self) { item in Text(item) }
                        }
                    }
                    
                    Section(header: Text("Ubicación")) {
                        TextField("Ubicación", text: $ubicacion)
                    }
                    
                    Section(header: Text("Extras")) {
                        Toggle(isOn: $rematesAlbanileria) {
                            Text("Remates Albañilería")
                        }
                    }
                    
                    //Text("Añadir fotos")

                }
            }
        }
        .navigationTitle("Configuración")
        .toolbar {
            NavigationLink(destination: projectView(), label: {
                Text("Siguiente")
            })
        }
    }
}

struct productView_Previews: PreviewProvider {
    static var previews: some View {
        productView()
    }
}
