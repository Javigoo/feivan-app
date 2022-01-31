//
//  HerrajeFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductHerrajeView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var tabSelection: Int = 13

    var body: some View {
        NavigationLink(
            destination: ProductConfigurationTabView(tabSelection: tabSelection, productVM: productVM),
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
    
    @State var bisagras_seguridad: Bool = false
    @State var bisagras_ocultas: Bool = false
    @State var cierre_clip_unero: Bool = false
    @State var muelle: Bool = false
    @State var cerradura_electronica: Bool = false
    @State var tirador_exterior: Bool = false
    @State var tirador_exterior_interior: Bool = false
    @State var pasadores_resaltados: Bool = false
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State var selections: [String] = []
    
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Opciones")) {
                    Toggle("Bisagras seguridad", isOn: $bisagras_seguridad)
                    Toggle("Bisagras ocultas", isOn: $bisagras_ocultas)
                    Toggle("Cierre clip + uñero", isOn: $cierre_clip_unero)
                    Toggle("Muelle", isOn: $muelle)
                    Toggle("Cerradura electrónica", isOn: $cerradura_electronica)
                    Toggle("Tirador exterior", isOn: $tirador_exterior)
                    Toggle("Tirador exterior/interior", isOn: $tirador_exterior_interior)
                    Toggle("Pasadores resaltados", isOn: $pasadores_resaltados)
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
                save()
                presentationMode.wrappedValue.dismiss()
            }
        }.onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []

        if bisagras_seguridad {
            resultado.append("Bisagras seguridad")
        }
        if bisagras_ocultas {
            resultado.append("Bisagras ocultas")
        }
        if cierre_clip_unero {
            resultado.append("Cierre clip + uñero")
        }
        if muelle {
            resultado.append("Muelle")
        }
        if cerradura_electronica {
            resultado.append("Cerradura electrónica")
        }
        if tirador_exterior {
            resultado.append("Tirador exterior")
        }
        if tirador_exterior_interior {
            resultado.append("Tirador exterior/interior")
        }
        if pasadores_resaltados {
            resultado.append("Pasadores resaltados")
        }
        
        productVM.herraje = resultado.joined(separator: "\n")
        
        if productVM.otro != "" {
            productVM.herraje = productVM.otro
            productVM.otro = ""
        }
        
        if productVM.anotacion != "" {
            productVM.herraje = productVM.herraje + " (\(productVM.anotacion))"
            productVM.anotacion = ""
        }
        
        productVM.save()
    }
}
