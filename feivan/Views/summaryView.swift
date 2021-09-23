//
//  summaryView.swift
//  feivan
//
//  Created by javigo on 23/9/21.
//

import SwiftUI

struct summaryView: View {
    
    var body: some View {
        Text("").navigationTitle("Resumen")
        
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                
                VStack(alignment: .leading) {
                    Section(header: Text("Cliente").bold()) {
                        Text("Nombre: ")
                        Text("Teléfono: ")
                        Text("Email: ")
                        Text("Dirección: ")
                        Text("Referencia: ")
                        Text("Comentario: ")
                    }
                }
                
                VStack(alignment: .leading) {
                    Section(header: Text("Proyecto").bold()) {
                        Text("Ascensor: ")
                        Text("Grua: ")
                        Text("Subir fachada: ")
                    }
                }
                
                VStack(alignment: .leading) {
                    Section(header: Text("Producto").bold()) {
                        Group {
                            Text("Dimensiones: ")
                            Text("Color: ")
                            Text("Tapajuntas: ")
                            Text("Apertura: ")
                            Text("Cristal: ")
                            Text("Forro exterior: ")
                            Text("Instalacion: ")
                            Text("Mallorquina: ")
                            Text("Cierres: ")
                            Text("Marco Inferior: ")
                        }
                        Group {
                            Text("Huella: ")
                            Text("Marco: ")
                            Text("Herraje: ")
                            Text("Posición: ")
                            Text("Ubicación: ")
                            Text("Remates Albañilería: ")
                            Text("Foto: ")
                        }
                    }
                }
            }
        }
    }
}

struct summaryView_Previews: PreviewProvider {
    static var previews: some View {
        summaryView()
    }
}
