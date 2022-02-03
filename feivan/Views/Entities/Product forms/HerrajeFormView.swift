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
    
    @State var otro: String = ""
    @State var anotacion: String = ""
    
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
                
                Section(header: Text("Anotación")) {
                    TextField("Añade una anotación", text: $anotacion)
                }
                
                Section(header: Text("Otro")) {
                    TextField("Introduce otra opción", text: $otro)
                }
            }
        }
        .navigationTitle(atributo)
        .onAppear {
            if !bisagras_seguridad {
                bisagras_seguridad = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Bisagras seguridad")) ?? false
            }
            if !bisagras_ocultas {
                bisagras_ocultas = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Bisagras ocultas")) ?? false
            }
            if !cierre_clip_unero {
                cierre_clip_unero = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Cierre clip + uñero")) ?? false
            }
            if !muelle {
                muelle = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Muelle")) ?? false
            }
            if !cerradura_electronica {
                cerradura_electronica = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Cerradura electrónica")) ?? false
            }
            if !tirador_exterior {
                tirador_exterior = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Tirador exterior")) ?? false
            }
            if !tirador_exterior_interior {
                tirador_exterior_interior = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Tirador exterior/interior")) ?? false
            }
            if !pasadores_resaltados {
                pasadores_resaltados = Bool(productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Pasadores resaltados")) ?? false
            }
            if anotacion.isEmpty {
                anotacion = productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Anotacion")
            }
            if otro.isEmpty {
                otro = productVM.getAttributeValue(attribute_data: productVM.herraje, select_atributte: "Otro")
            }
        }
        .onDisappear {
            save()
        }
    }
    
    func save() {
        var resultado: [String] = []

        if !otro.isEmpty {
            productVM.herraje = "\""+otro+"\""
        } else {
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
            if !anotacion.isEmpty {
                resultado.append("(\(anotacion))")
            }
            
            productVM.herraje = resultado.joined(separator: "\n")
        }
        productVM.save()
    }
}

