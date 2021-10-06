//
//  projectsView.swift
//  feivan
//
//  Created by javigo on 6/10/21.
//

import SwiftUI

struct projectsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Cliente.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.timestamp, ascending: false)])
    var clientsFetch: FetchedResults<Cliente>
    
    var body: some View {
        List {
            ForEach(clientsFetch, id: \.self) { cliente in
                NavigationLink(destination: projectDetailView(cliente: cliente), label: {
                    VStack(alignment: .leading) {
                        Text(cliente.nombre ?? "Cliente")
                            .font(.title)
                        Text(cliente.direccion ?? "Dirección")
                            .font(.subheadline)
                        Spacer()
                        Text("Tiene x productos")
                            .font(.body)
                    }
                })
            }
            .onDelete(perform: deleteClient)
        }
        .navigationTitle("Proyectos")
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

struct projectDetailView: View {
    var cliente: Cliente
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Proyecto.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Proyecto.timestamp, ascending: false)])
    var proyectos: FetchedResults<Proyecto>
        
    @FetchRequest(
        entity: Producto.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Producto.timestamp, ascending: false)])
    var productos: FetchedResults<Producto>
    
    var body: some View {
        VStack {
            Text("Proyecto")
                .font(.title)
            List {
                ForEach(proyectos, id: \.self) { proyecto in
                    NavigationLink(destination: Text("pyoyecto destination"), label: {
                        ProjectDetailView(proyecto: proyecto)
                    })
                    Spacer()
                }
                .onDelete(perform: deleteProject)
            }
            Spacer()
            
            Text("Cliente")
                .font(.title)
            NavigationLink(destination: updateClientView(cliente: cliente), label: {
                ClientDetailView(cliente: cliente)
            })
                
            Spacer()
            
            Text("Producto")
                .font(.title)
            List {
                ForEach(productos, id: \.self) { producto in
                    NavigationLink(destination: configurationView(), label: {
                        ProductDetailView(producto: producto)
                    })
                    Spacer()
                }
                .onDelete(perform: deleteProduct)
            }
        }
        .navigationTitle("Proyecto")
        .padding()
    }

    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let clientEntity = productos[index]
            viewContext.delete(clientEntity)
            saveDB()
        }
    }
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let clientEntity = proyectos[index]
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

struct ClientDetailView: View {
    @ObservedObject var cliente: Cliente
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nombre")
                Spacer()
                Text(cliente.nombre ?? "...")
            }
            .font(.subheadline)
            
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
        }
    }
}

struct ProjectDetailView: View {
    var proyecto: Proyecto
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Ascensor")
                Spacer()
                if proyecto.ascensor {
                    Text("Si")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)
            
            HStack {
                Text("Grúa")
                Spacer()
                if proyecto.grua {
                    Text("Si")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)
            
            HStack {
                Text("Subir fachada")
                Spacer()
                if proyecto.grua {
                    Text("Si")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)
            
        }
    }
}

struct ProductDetailView: View {
    var producto: Producto
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                HStack {
                    Text("Producto")
                    Spacer()
                    Text(producto.producto ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Familia")
                    Spacer()
                    Text(producto.familia ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Material")
                    Spacer()
                    Text(producto.material ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Remates albañilería")
                    Spacer()
                    if producto.rematesAlbanileria {
                        Text("Si")
                    } else {
                        Text("No")
                    }
                }
                .font(.subheadline)
                
                HStack {
                    Text("Color")
                    Spacer()
                    Text(producto.color ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Dimensiones")
                    Spacer()
                    Text(producto.dimensiones ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Apertura")
                    Spacer()
                    Text(producto.apertura ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Marco inferior")
                    Spacer()
                    Text(producto.marcoInferior ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Huella")
                    Spacer()
                    Text(producto.huella ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Tapajuntas")
                    Spacer()
                    Text(producto.tapajuntas ?? "...")
                }
                .font(.subheadline)
            }
            
            Group {
                HStack {
                    Text("Forro exterior")
                    Spacer()
                    Text(producto.forroExterior ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Crista")
                    Spacer()
                    Text(producto.cristal ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Mallorquina")
                    Spacer()
                    Text(producto.mallorquina ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Cerraduras")
                    Spacer()
                    Text(producto.cerraduras ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Manetas")
                    Spacer()
                    Text(producto.manetas ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Herraje")
                    Spacer()
                    Text(producto.herraje ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Posición")
                    Spacer()
                    Text(producto.posicion ?? "...")
                }
                .font(.subheadline)
                
                HStack {
                    Text("Instalación")
                    Spacer()
                    Text(producto.instalacion ?? "...")
                }
                .font(.subheadline)
            }
        }
    }
}

struct projectsView_Previews: PreviewProvider {
    static var previews: some View {
        projectsView()
    }
}
