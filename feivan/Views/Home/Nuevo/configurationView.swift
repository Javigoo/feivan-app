//
//  Configuracion.swift
//  feivan
//
//  Created by javigo on 20/9/21.
//

import SwiftUI

struct configurationView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    let producto = ["Material", "Dimensiones", "Color", "Tapajuntas", "Apertura", "Cristal", "Forro exterior", "Instalación", "Mallorquina", "Cierres", "Marco inferior", "Huella", "Marco", "Herraje", "Ubicación", "Remates albañilería", "Añadir foto"]
    
    let materialOpciones = ["PVC", "Aluminio"]
    let tapajuntasOpciones = ["30", "40", "60", "80", "100"]
    let mallorquinaOpciones = ["Lama móvil", "Lama fija", "Travesaño horizontal", "Travesaño vertical", "Cruceta", "Persiana planta baja 4 hojas", "Persiana planta baja hoja sobre hoja", "Persiana planta baja apertura libro"]
    let cierresOpciones = ["Cremona", "Cerradura", "Cerradura 3 puntos", "Pasadores", "Maneta presión", "Maneta interior/exterior", "Solo maneta interior", "Solo maneta exterior"]
    let marcoInferiorOpciones = ["Abierto", "Cerrado", "Solera"]
    let marcoOpciones = ["Abierto", "Cerrado", "Solera"]
    let herrajeOpciones = ["Mismo color", "Bisagras seguridad","Cierre clip + Uñero", "Muelle", "Cerradura electrónica", "Tirador exterior", "Tirador exterior/interior", "Bisagra oculta", "Herraje minimalista"]
    let cristalOpciones = ["Cámara", "4/Cámara/6", "4/Cámara/4+4", "6/?/4+4 silence", "4+4", "5+5", "6+6"]
    let instalacionOpciones = ["Huella obra", "Premarco", "Desmontando madera", "Desmontando hierro", "Desmontando aluminio"]
    
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
    
    var body: some View {
        VStack {
            Text("").navigationTitle("Configuración")
            
            Form {
                Section(header: Text("")) {
    
                    Group {
                        
                        Picker("Material", selection: $material) {
                            List(materialOpciones, id: \.self) { item in Text(item) }
                        }

                        TextField("Dimensiones", text: $dimensiones)
                        
                        TextField("Color", text: $color)
                    
                        Picker("Tapajuntas", selection: $tapajuntas) {
                            List(tapajuntasOpciones, id: \.self) { item in Text(item) }
                        }
                        
                        Text("Apertura")
                        
                        Picker("Cristal", selection: $cristal) {
                            List(cristalOpciones, id: \.self) { item in Text(item) }
                        }
                        
                        Text("Forro exterior")
                        
                        Picker("Instalacion", selection: $instalacion) {
                            List(instalacionOpciones, id: \.self) { item in Text(item) }
                        }
                        
                        Picker("Mallorquina", selection: $mallorquina) {
                            List(mallorquinaOpciones, id: \.self) { item in Text(item) }
                        }
                        
                        Picker("Cierres", selection: $cierres) {
                            List(cierresOpciones, id: \.self) { item in Text(item) }
                        }
                        
                    }
                    
                    Group {
                        Picker("Marco Inferior", selection: $marcoInferior) {
                            List(marcoInferiorOpciones, id: \.self) { item in Text(item) }
                        }
                        
                        TextField("Huella", text: $huella)
                        
                        Picker("Marco", selection: $marco) {
                            List(marcoOpciones, id: \.self) { item in Text(item) }
                        }
                        
                        Picker("Herraje", selection: $herraje) {
                            List(herrajeOpciones, id: \.self) { item in Text(item) }
                        }
                        
                        TextField("Ubicación", text: $ubicacion)
                        
                        Toggle(isOn: $rematesAlbanileria) {
                            Text("Remates Albañilería")
                        }
                        
                        Text("Foto")
                    }
                }
            }
            
            NavigationLink(destination: summaryView(), label: {
                Text("Siguiente")
            })
        }
    }
}

struct configurationView_Previews: PreviewProvider {
    static var previews: some View {
        configurationView()
    }
}
