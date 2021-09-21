//
//  Nuevo.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct clientView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var nombreCliente: String = ""
    @State private var direccionCliente: String = ""
    @State private var telefonoCliente: String = ""
    @State private var emailCliente: String = ""
    @State private var referenciaCliente: String = ""
    @State private var comentarioCliente: String = ""
        
    var body: some View {
        let client = Client(context: managedObjectContext)
        
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
            
            
            NavigationLink(destination: familyView()) {
                                    Text("Siguiente")
                                }
            // Guarda la información del cliente al pasar a la siguiente vista
            
            .simultaneousGesture(TapGesture().onEnded{
                                    client.adress = direccionCliente
                                    client.comment = comentarioCliente
                                    client.email = emailCliente
                                    client.name = nombreCliente
                                    client.phone = telefonoCliente
                                    client.reference = referenciaCliente
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
