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
    
    let materialOpciones = ["PVC", "Aluminio", "Otro"]
    let tapajuntasOpciones = ["30", "40", "60", "80", "100"]
    let mallorquinaOpciones = ["Lama móvil", "Lama fija", "Travesaño horizontal", "Travesaño vertical", "Cruceta", "Persiana planta baja 4 hojas", "Persiana planta baja hoja sobre hoja", "Persiana planta baja apertura libro"]
    let cierresOpciones = ["Cremona", "Cerradura", "Cerradura 3 puntos", "Pasadores", "Maneta presión", "Maneta interior/exterior", "Solo maneta interior", "Solo maneta exterior"]
    let marcoInferiorOpciones = ["Abierto", "Cerrado", "Solera"]
    let marcoOpciones = ["Abierto", "Cerrado", "Solera"]
    let herrajeOpciones = ["Mismo color", "Bisagras seguridad","Cierre clip + Uñero", "Muelle", "Cerradura electrónica", "Tirador exterior", "Tirador exterior/interior", "Bisagra oculta", "Herraje minimalista"]
    let cristalOpciones = ["Cámara", "4/Cámara/6", "4/Cámara/4+4", "6/?/4+4 silence", "4+4", "5+5", "6+6"]
    let instalacionOpciones = ["Huella obra", "Premarco", "Desmontando madera", "Desmontando hierro", "Desmontando aluminio"]
    let forroExteriorOpciones = ["Pletina", "40", "60"]
    
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

    
    var body: some View {
        VStack {
            /*
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
            */
            
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
                    }
                    
                    Section(header: Text("Forro exterior")) {
                        Picker("Forro exterior", selection: $forroExterior) {
                            List(forroExteriorOpciones, id: \.self) { item in Text(item) }
                        }
                        .pickerStyle(.segmented)
                        
                        TextField("Otro", text: $forroExterior)
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
                    }
                   
                    Section(header: Text("Cierres")) {
                        Picker("Cierres", selection: $cierres) {
                            List(cierresOpciones, id: \.self) { item in Text(item) }
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
