//
//  DebugFile.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI
import CoreData

struct DebugView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var isShowingBackView = false

    var body: some View {
        VStack(spacing: 30) {
            
            NavigationLink(destination: ClientListView(), label: {
                Text("Ver Clientes")
            })
            
            NavigationLink(destination: ProductNewView(), label: {
                Text("Ver Productos")
            })
            
            Divider()
            
            Button("Añadir 1 proyecto vacio", action: {
                createTestProjectEmpty()
                presentationMode.wrappedValue.dismiss()
            })
            
            Divider()
            
            Button("Añadir 1 proyecto con 1 producto", action: {
                createTestProject11()
                presentationMode.wrappedValue.dismiss()
            })

            Button("Añadir 1 proyecto con 2 productos", action: {
                createTestProject12()
                presentationMode.wrappedValue.dismiss()
            })

            Button("Añadir 2 proyectos con 1 producto", action: {
                createTestProject21()
                presentationMode.wrappedValue.dismiss()
            })
        }
        .padding()
    }
    
    private func createTestProjectEmpty() {
        let cliente = Cliente(context: viewContext)
        let proyecto = Proyecto(context: viewContext)
        let producto = Producto(context: viewContext)

        cliente.proyectos = [proyecto]
        proyecto.productos = [producto]

        PersistenceController.shared.save()
    }
    
    private func createTestProject11() {
        let cliente = createTestClient()
        let proyecto = createTestProject()
        let producto = createTestProduct()

        cliente.proyectos = [proyecto]
        proyecto.productos = [producto]

        PersistenceController.shared.save()
    }

    private func createTestProject12() {
        let cliente = createTestClient()
        let proyecto = createTestProject()
        let producto = createTestProduct()
        let producto2 = createTestProduct()

        cliente.proyectos = [proyecto]
        proyecto.productos = [producto, producto2]

        PersistenceController.shared.save()
    }

    private func createTestProject21() {
        let cliente = createTestClient()
        let proyecto = createTestProject()
        let proyecto2 = createTestProject()
        let producto = createTestProduct()
        let producto2 = createTestProduct()

        cliente.proyectos = [proyecto, proyecto2]
        proyecto.productos = [producto]
        proyecto2.productos = [producto2]

        PersistenceController.shared.save()
    }


    private func createTestClient() -> Cliente {
        let cliente = Cliente(context: viewContext)
        cliente.timestamp = Date()
        cliente.nombre = "Javi Roig"
        cliente.telefono = "686164345"
        cliente.email = "javierroiggregorio@gmail.com"
        cliente.referencia = "42"
        cliente.comentario = "El que ha hecho esta aplicación"
        return cliente
    }

    private func createTestProject() -> Proyecto {
        let proyecto = Proyecto(context: viewContext)
        proyecto.timestamp = Date()
        proyecto.ascensor = false
        proyecto.grua = false
        proyecto.subirFachada = false
        proyecto.direccion = "Pedro Heredia 22"
        return proyecto
    }

    private func createTestProduct() -> Producto {
        let producto = Producto(context: viewContext)
        producto.timestamp = Date()
        producto.familia = "Correderas"
        producto.nombre = "1-C2"
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
        producto.hojaPrincipal = "Izquierda"
        producto.curvas = "Arco"
        return producto
    }
}
