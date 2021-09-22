//
//  Nuevo.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

// todo: Separar controlador (func) de vista (struct: View)

import SwiftUI

struct clientView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var comentarioCliente: String = ""
    @State private var direccionCliente: String = ""
    @State private var emailCliente: String = ""
    @State private var nombreCliente: String = ""
    @State private var referenciaCliente: String = ""
    @State private var telefonoCliente: String = ""

        
    var body: some View {
        let cliente = Cliente(context: managedObjectContext)
        
        VStack {
            Text("").navigationTitle("Cliente")
            
            Form {
                Section(header: Text("Información de contacto")) {
                    TextField("Nombre", text: $nombreCliente)
                    TextField("Teléfono", text: $telefonoCliente)
                    TextField("Email", text: $emailCliente)
                    TextField("Dirección", text: $direccionCliente)
                    TextField("Referencia", text: $referenciaCliente)
                }
                
                Section(header: Text("Comentarios opcionales")) {
                    TextEditor(text: $comentarioCliente)
                }
                
            }
            
            #if false
                Text("Nombre: \(nombreCliente)")
                Text("Teléfono: \(telefonoCliente)")
                Text("Email: \(emailCliente)")
                Text("Dirección: \(direccionCliente)")
                Text("Referencia: \(referenciaCliente)")
                Text("Comentario: \(comentarioCliente)")
                Divider()
            #endif
            
            NavigationLink(destination: familyView()) {
                                    Text("Siguiente")
                                }
            // Guarda la información del cliente al pasar a la siguiente vista
            .simultaneousGesture(TapGesture().onEnded{
                cliente.comentario = comentarioCliente
                cliente.direccion = direccionCliente
                cliente.email = emailCliente
                cliente.nombre = nombreCliente
                cliente.referencia = referenciaCliente
                cliente.telefono = telefonoCliente
                PersistenceController.shared.save()
            })
        }
    }
    
}

struct clientView_Previews: PreviewProvider {
    static var previews: some View {
        clientView()
    }
}
