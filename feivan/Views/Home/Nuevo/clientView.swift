//
//  Nuevo.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct clientView: View {
    @State public var nombreCliente: String = ""
    @State private var direccionCliente: String = ""
    @State private var telefonoCliente: String = ""
    @State private var emailCliente: String = ""
    @State private var referenciaCliente: String = ""
    @State private var comentarioCliente: String = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
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
                
                Button(action: {
                    let client = Client(context: managedObjectContext)
                    client.name = nombreCliente
                    
                    PersistenceController.shared.save()
                }, label: {
                    Text("Add client")
                })
                
            }
            
            NavigationLink(destination: familyView(), label: {
                Text("Siguiente")
            })
                                  
        }
    }
}

struct clientView_Previews: PreviewProvider {
    static var previews: some View {
        clientView()
    }
}
