//
//  projectsView.swift
//  feivan
//
//  Created by javigo on 6/10/21.
//

import SwiftUI

struct clientsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Cliente.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.timestamp, ascending: false)])
    var clientsFetch: FetchedResults<Cliente>
    
    var body: some View {
        List {
            
            // para añadir proyecto de prueba
            Button("Añadir proyecto de prueba", action: {
                let cliente = Cliente(context: viewContext)
                let proyecto = Proyecto(context: viewContext)
                let producto = Producto(context: viewContext)

                cliente.id = UUID()
                cliente.timestamp = Date()
                cliente.nombre = "Javier Roig Gregorio"
                cliente.telefono = "608342503"
                cliente.email = "javierroiggregorio@gmail.com"
                cliente.direccion = "Carrer de les Hortènsies, 8"
                cliente.comentario = "El que ha hecho esta app"
                
                cliente.proyectos = [proyecto]

                proyecto.id = UUID()
                proyecto.timestamp = Date()
                proyecto.ascensor = true
                proyecto.grua = false
                proyecto.subirFachada = false
                
                proyecto.cliente = cliente
                proyecto.productos = [producto]
                
                producto.id = UUID()
                producto.timestamp = Date()
                producto.familia = "Correderas"
                producto.producto = "Corredera de 2 hojas"
                producto.material = "PVC"
                producto.rematesAlbanileria = true
                producto.color = "Blanco"
                producto.dimensiones = "600mm x 300mm"
                producto.apertura = "DDI"
                producto.marcoInferior = "Abierto"
                producto.huella = "100mm"
                producto.tapajuntas = "60"
                producto.forroExterior = "40"
                producto.cristal = "Cámara"
                producto.mallorquina = "Lama fija"
                producto.cerraduras = "Cerradura"
                producto.manetas = "Solo maneta interior"
                producto.herraje = "Mismo color"
                producto.posicion = "Cocina (V1)"
                producto.instalacion = "Huella obra"
                
                producto.proyecto = proyecto

                saveDB()
                
            })
            
            ForEach(clientsFetch, id: \.self) { cliente in
                NavigationLink(destination: projectsView(cliente: cliente), label: {
                    VStack(alignment: .leading) {
                        Text(cliente.nombre ?? "Cliente")
                            .font(.title)
                        Text(cliente.direccion ?? "Dirección")
                            .font(.subheadline)
                        Spacer()
                        Text("X proyectos")
                            .font(.body)
                    }
                })
            }
            .onDelete(perform: deleteClient)
        }
        .navigationTitle("Clientes")
    }
    
    private func deleteClient(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else { return }
            let clientEntity = clientsFetch[index]
            // eliminar productos de cada proyecto
            // eliminar proyectos del cliente
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

struct projectsView: View {
    var cliente: Cliente
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Proyecto.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Proyecto.timestamp, ascending: false)])
    var proyectos: FetchedResults<Proyecto>
    
    var body: some View {
        VStack {
            Text("Cliente")
                .font(.title)
            NavigationLink(destination: updateClientView(cliente: cliente), label: {
                ClientDetailView(cliente: cliente)
            })
                
            Spacer()
            
            Text("Proyectos")
                .font(.title)
            List {
                ForEach(proyectos, id: \.self) { proyecto in
                    NavigationLink(destination: productsView(proyecto: proyecto), label: {
                        ProjectDetailView(proyecto: proyecto)
                    })
                }
                .onDelete(perform: deleteProject)
            }
        }
        .navigationTitle("Proyectos")
        .padding()
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

struct productsView: View {
    var proyecto: Proyecto
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Producto.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Producto.timestamp, ascending: false)])
    var productos: FetchedResults<Producto>
    
    var body: some View {
        VStack {
            Text("Proyecto")
                .font(.title)
            NavigationLink(destination: projectView(), label: {
                ProjectDetailView(proyecto: proyecto)
            })
                
            Spacer()
            
            Text("Productos")
                .font(.title)
            List {
                ForEach(productos, id: \.self) { producto in
                    NavigationLink(destination: Text("DetailView producto"), label: {
                        ProductDetailView(producto: producto)
                    })
                }
                .onDelete(perform: deleteProduct)
            }
        }
        .navigationTitle("Proyectos")
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

struct clientsView_Previews: PreviewProvider {
    static var previews: some View {
        clientsView()
    }
}
