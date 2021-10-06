//
//  Nuevo.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

// todo: Separar controlador (func) de vista (struct: View)

import SwiftUI

struct newClientView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var nombreCliente: String = ""
    @State private var telefonoCliente: String = ""
    @State private var emailCliente: String = ""
    @State private var direccionCliente: String = ""
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
                }
                
                Section(header: Text("Comentarios opcionales")) {
                    TextEditor(text: $comentarioCliente)
                }
                
                Button("Guardar cliente", action: {
                    let cliente = Cliente(context: viewContext)
                    cliente.id = UUID()
                    cliente.timestamp = Date()
                    cliente.nombre = nombreCliente
                    cliente.telefono = telefonoCliente
                    cliente.email = emailCliente
                    cliente.direccion = direccionCliente
                    cliente.comentario = comentarioCliente
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                })
                
            }
        }
        .navigationTitle("Cliente")
        .toolbar {
            ToolbarItemGroup {
                NavigationLink(destination: familyView(), label: {
                    Text("Siguiente")
                })
            }
        }
    }
}

struct clientsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Cliente.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.timestamp, ascending: false)])
    var clientsFetch: FetchedResults<Cliente>
    
    var body: some View {
        List {
            ForEach(clientsFetch, id: \.self) { cliente in
                NavigationLink(destination: updateClientView(cliente: cliente), label: {
                    VStack(alignment: .leading) {
                        Text(cliente.nombre ?? "Cliente")
                            .font(.title)
                        
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
                    }
                })
            }
            .onDelete(perform: deleteClient)
        }
        .navigationTitle("Clientes")
        .toolbar {
            ToolbarItemGroup {
                NavigationLink(destination: addClientView()) {
                    Label("Nuevo Cliente", systemImage: "person.badge.plus")
                }
            }
        }
    }
    
    private func deleteClient(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let clientEntity = clientsFetch[index]
            viewContext.delete(clientEntity)
            
            saveDB()
        }
    }
    
    private func saveDB() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("(clientView) Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

struct updateClientView: View {
    
    @ObservedObject var cliente: Cliente
    
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Información de contacto")) {
                    TextField("Nombre", text: $cliente.nombre ?? "")
                    TextField("Teléfono", text: $cliente.telefono ?? "")
                        .keyboardType(.phonePad)
                    TextField("Email", text: $cliente.email ?? "")
                        .keyboardType(.emailAddress)
                    TextField("Dirección", text: $cliente.direccion ?? "")
                }
                
                Section(header: Text("Comentarios opcionales")) {
                    TextEditor(text: $cliente.comentario ?? "")
                }
                
                
                Button("Guardar cliente", action: {updateClient()})
                
            }
        }
        .navigationTitle("Cliente")
    }
    
    private func updateClient() {
        saveDB()
    }
        
    private func saveDB() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("(clientView) Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}


struct addClientView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var nombreCliente: String = "Javier Roig"
    @State private var telefonoCliente: String = "685164345"
    @State private var emailCliente: String = "javierroiggregorio@gmail.com"
    @State private var direccionCliente: String = "Carrer de les Hortènsies, 8"
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
                }
                
                Section(header: Text("Comentarios opcionales")) {
                    TextEditor(text: $comentarioCliente)
                }
                
                
                Button("Guardar cliente", action: {
                    let cliente = Cliente(context: viewContext)
                    cliente.id = UUID()
                    cliente.timestamp = Date()
                    cliente.nombre = nombreCliente
                    cliente.telefono = telefonoCliente
                    cliente.email = emailCliente
                    cliente.direccion = direccionCliente
                    cliente.comentario = comentarioCliente
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                })
                
            }
        }
        .navigationTitle("Cliente")
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// Shoutout Jonathan: https://stackoverflow.com/questions/57021722/swiftui-optional-textfield
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

struct clientView_Previews: PreviewProvider {
    static var previews: some View {
        newClientView()
    }
}

/*
 .toolbar {
     ToolbarItemGroup {
         
         NavigationLink(destination: familyView(), label: {
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
 */
 
/*
 struct clientView: View {
     var body: some View {
         TabView {
             addClientView()
                 .tabItem {
                     Label("Nuevo Cliente", systemImage: "person.badge.plus")
                 }

             clientsView()
                 .tabItem {
                     Label("Clientes", systemImage: "person.3")
                 }
         }
         .toolbar {
             ToolbarItemGroup {
                 NavigationLink(destination: familyView()) {
                     Text("Siguiente")
                 }
             }
         }
         .navigationTitle("Cliente")

     }
 }
 
*/
