//
//  Configuracion.swift
//  feivan
//
//  Created by javigo on 20/9/21.
//

import SwiftUI

struct configurationView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    let producto = ["Material", "Dimensiones", "Color", "Tapajuntas", "Apertura", "Cristal", "Forro exterior", "Instalación", "Mallorquina", "Cierres", "Marco inferior", "Huella", "Marco", "Herraje", "Posición", "Ubicación", "Remates albañilería", "Añadir foto"]
    
    let materiales = ["PVC", "Aluminio"]
    
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
    @State private var rematesAlbanileria = ""
    @State private var foto = ""

    
    var body: some View {
        VStack {
            Text("").navigationTitle("Configuración")
            
            Form {
                Section(header: Text("")) {
                    Picker("Material", selection: $material) {
                        List(materiales, id: \.self) { item in Text(item) }
                    }
                    
                    Group {
                        Text("Dimensiones")
                        
                        Text("Color")
                    
                        Text("Tapajuntas")
                        
                        Text("Apertura")
                        
                        Text("Cristal")
                        
                        Text("Forro exterior")
                        
                        Text("Instalacion")
                        
                        Text("Mallorquina")
                        
                        Text("Cierres")
                        
                        Text("Marco Inferior")
                    }
                    
                    Group {
                        
                        Text("Huella")
                        
                        Text("Marco")
                        
                        Text("Herraje")
                        
                        Text("Posición")
                        
                        Text("Ubicación")
                        
                        Text("Remates Albañilería")
                        
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
