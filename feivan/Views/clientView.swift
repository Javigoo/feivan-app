//
//  Nuevo.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

// todo: Separar controlador (func) de vista (struct: View)

import SwiftUI

struct clientView: View {
    var body: some View {
        TabView {
            addNewClientView()
                .tabItem {
                    Label("Nuevo Cliente", systemImage: "person.badge.plus")
                }

            clientSummaryView()
                .tabItem {
                    Label("Clientes", systemImage: "person.3")
                }
        }
        .toolbar {
            ToolbarItemGroup {
                NavigationLink(destination: familyView(idCliente: UUID())) {
                    Text("Siguiente")
                }
            }
        }
        .navigationTitle("Cliente")

    }
}

struct addNewClientView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var idCliente: UUID = UUID()
    @State private var timestampCliente: Date = Date()
    @State private var nombreCliente: String = "Javier Roig"
    @State private var telefonoCliente: String = "685164345"
    @State private var emailCliente: String = "javierroiggregorio@gmail.com"
    @State private var direccionCliente: String = "Carrer de les Hortènsies, 8"
    @State private var referenciaCliente: String = "1234"
    @State private var comentarioCliente: String = ""
        
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Información de contacto")) {
                    TextField("Nombre", text: $nombreCliente)
                    TextField("Teléfono", text: $telefonoCliente)
                        .keyboardType(.phonePad)
                    TextField("Email", text: $emailCliente)
                        .keyboardType(.emailAddress)
                    TextField("Dirección", text: $direccionCliente)
                    TextField("Referencia", text: $referenciaCliente)
                }
                
                Section(header: Text("Comentarios opcionales")) {
                    TextEditor(text: $comentarioCliente)
                }
                
                
                Button("Guardar cliente", action: {
                    let cliente = Cliente(context: viewContext)
                    cliente.id = idCliente
                    cliente.timestamp = timestampCliente
                    cliente.nombre = nombreCliente
                    cliente.telefono = telefonoCliente
                    cliente.email = emailCliente
                    cliente.direccion = direccionCliente
                    cliente.referencia = referenciaCliente
                    cliente.comentario = comentarioCliente
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                })
                
            }
        }
        .navigationTitle("Cliente")
        .toolbar {
            ToolbarItemGroup {
                
                NavigationLink(destination: familyView(idCliente: idCliente), label: {
                    Text("Siguiente")
                })
                /*
                .simultaneousGesture(TapGesture().onEnded{
                    let cliente = Cliente(context: viewContext)
                    cliente.id = idCliente
                    cliente.timestamp = timestampCliente
                    cliente.nombre = nombreCliente
                    cliente.telefono = telefonoCliente
                    cliente.email = emailCliente
                    cliente.direccion = direccionCliente
                    cliente.referencia = referenciaCliente
                    cliente.comentario = comentarioCliente
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                })
                */
            }
        }
    }
}

struct clientSummaryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.timestamp, ascending: false)],
        animation: .default)
    private var clientes: FetchedResults<Cliente>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {

                ForEach(clientes, id: \.self) { cliente in
                    
                    HStack {
                        Text(cliente.nombre ?? "Cliente")
                            .font(.title)
                        Spacer()
                        Button("Eliminar",
                            action: {
                                viewContext.delete(cliente)
                                do {
                                    try viewContext.save()
                                } catch {
                                    // Replace this implementation with code to handle the error appropriately.
                                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                    let nsError = error as NSError
                                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                }
                            }
                        )
                    }
                    
                    HStack {
                        Text("Teléfono")
                        Spacer()
                        Text(cliente.telefono ?? "...")
                    }
                    .font(.subheadline)
                    
                    HStack {
                        Text("Email")
                        Spacer()
                        Text(cliente.email ?? "...")
                    }
                    .font(.subheadline)
                    
                    HStack {
                        Text("Dirección")
                        Spacer()
                        Text(cliente.direccion ?? "...")
                    }
                    .font(.subheadline)
                    
                    HStack {
                        Text("Referencia")
                        Spacer()
                        Text(cliente.referencia ?? "...")
                    }
                    .font(.subheadline)
                    
                    HStack {
                        Text("Comentario")
                        Spacer()
                        Text(cliente.comentario ?? "...")
                    }
                    .font(.subheadline)
                    
                    Text(cliente.id?.uuidString ?? "...")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(cliente.timestamp!, formatter: itemFormatter)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .center)
                
                    Spacer()
                }
            }
            .padding()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct clientView_Previews: PreviewProvider {
    static var previews: some View {
        clientView()
    }
}
