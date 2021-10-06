//
//  Home.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct homeView: View {
    
    // para añadir proyecto de prueba
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            VStack(spacing: 15){
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                
                NavigationLink(
                    destination: newClientView(),
                    label: {
                        Text("Nuevo")
                            .textStyle(NavigationLinkStyle())
                    }
                )
                
                NavigationLink(
                    destination: projectsView(),
                    label: {
                        Text("Proyectos")
                            .textStyle(NavigationLinkStyle())
                    }
                )
                
                Spacer()
                
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

                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                    
                })

            }
        }
        .navigationTitle("Home")
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
