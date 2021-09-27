//
//  summaryView.swift
//  feivan
//
//  Created by javigo on 23/9/21.
//

import SwiftUI

let atributosCliente = ["Nombre", "Teléfono", "Email", "Dirección", "Referencia", "Comentario"]
let atributosProyecto = ["Ascensor", "Grúa", "Subir fachada"]
let atributosProducto = ["Producto", "Familia", "Posición", "Material", "Dimensiones", "Color", "Tapajuntas", "Apertura", "Cristal", "Forro exterior", "Instalación", "Mallorquina", "Cierres", "Marco inferior", "Huella", "Marco", "Herraje", "Ubicación", "Remates albañilería", "Fotos"]

struct summaryView: View {
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("").navigationTitle("Resumen")
            
            Text("Cliente")
                .font(.title)
            ForEach(atributosCliente, id: \.self) { atributo in
                HStack {
                    Text(atributo)
                    Spacer()
                    Text("...")
                }
                .font(.subheadline)
            }
            
            Spacer()

            Text("Proyecto")
                .font(.title)
            ForEach(atributosProyecto, id: \.self) { atributo in
                HStack {
                    Text(atributo)
                    Spacer()
                    Text("...")
                }
                .font(.subheadline)
            }
            
            Spacer()
            
            Text("Producto")
                .font(.title)
            ForEach(atributosProducto, id: \.self) { atributo in
                HStack {
                    Text(atributo)
                    Spacer()
                    Text("...")
                }
                .font(.subheadline)
            }
            
        }
        .padding()
    }
}

struct summaryView_Previews: PreviewProvider {
    static var previews: some View {
        summaryView()
    }
}
