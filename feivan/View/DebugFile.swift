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
        ScrollView {
            VStack(alignment: .leading) {
                
                Section(header: Text("Ver entidades")) {
                    NavigationLink(destination: ProjectListView(), label: {
                        Text("Proyectos")
                    })
                    
                    NavigationLink(destination: ClientListView(), label: {
                        Text("Clientes")
                    })
                    
                    NavigationLink(destination: ProductListView(), label: {
                        Text("Productos")
                    })
                }
                
                Divider()
                
                Section(header: Text("Añadir proyectos de prueba")) {
                    Button("Añadir 1 proyecto vacio", action: {
                        createTestProjectEmpty()
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Button("1 cliente con 1 proyecto con 1 producto", action: {
                        createTestProject111()
                        presentationMode.wrappedValue.dismiss()
                    })

                    Button("1 cliente con 1 proyecto con 2 productos", action: {
                        createTestProject112()
                        presentationMode.wrappedValue.dismiss()
                    })

                    Button("1 cliente con 2 proyectos con 1 producto", action: {
                        createTestProject121()
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Button("2 clientes con 1 proyecto con 1 producto", action: {
                        createTestProject211()
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
            .padding()
        }
    }
    
    private func createTestProjectEmpty() {
        let cliente = Cliente(context: viewContext)
        let proyecto = Proyecto(context: viewContext)
        let producto = Producto(context: viewContext)

        cliente.proyectos = [proyecto]
        proyecto.productos = [producto]

        PersistenceController.shared.save()
    }
    
    private func createTestProject111() {
        let cliente = createTestClient()
        let proyecto = createTestProject()
        let producto = createTestProduct()

        cliente.proyectos = [proyecto]
        proyecto.productos = [producto]

        PersistenceController.shared.save()
    }

    private func createTestProject112() {
        let cliente = createTestClient()
        let proyecto = createTestProject()
        let producto = createTestProduct()
        let producto2 = createTestProduct2()

        cliente.proyectos = [proyecto]
        proyecto.productos = [producto, producto2]

        PersistenceController.shared.save()
    }

    private func createTestProject121() {
        let cliente = createTestClient()
        let proyecto = createTestProject()
        let proyecto2 = createTestProject2()
        let producto = createTestProduct()
        let producto2 = createTestProduct2()

        cliente.proyectos = [proyecto, proyecto2]
        proyecto.productos = [producto]
        proyecto2.productos = [producto2]

        PersistenceController.shared.save()
    }
    
    private func createTestProject211() {
        let cliente = createTestClient()
        let cliente2 = createTestClient2()
        let proyecto = createTestProject()
        let proyecto2 = createTestProject2()
        let producto = createTestProduct()
        let producto2 = createTestProduct2()

        cliente.proyectos = [proyecto]
        cliente2.proyectos = [proyecto2]

        proyecto.productos = [producto]
        proyecto2.productos = [producto2]

        PersistenceController.shared.save()
    }


    private func createTestClient() -> Cliente {
        let cliente = Cliente(context: viewContext)
        cliente.id_cliente = UUID()
        cliente.nombre = "Javi Roig"
        cliente.telefono = "686164345"
        cliente.email = "javierroiggregorio@gmail.com"
        cliente.referencia = "42"
        cliente.comentario = "El que ha hecho esta aplicación"
        cliente.timestamp = Date()
        return cliente
    }
    
    private func createTestClient2() -> Cliente {
        let cliente = Cliente(context: viewContext)
        cliente.id_cliente = UUID()
        cliente.nombre = "Prats La Fuente"
        cliente.telefono = "608346677"
        cliente.email = "prados@gmail.com"
        cliente.referencia = "13"
        cliente.comentario = "Mi colega"
        cliente.timestamp = Date()
        return cliente
    }

    private func createTestProject() -> Proyecto {
        let proyecto = Proyecto(context: viewContext)
        proyecto.id_proyecto = UUID()
        proyecto.ascensor = false
        proyecto.grua = false
        proyecto.subir_fachada = false
        proyecto.direccion = "Hortensias 8"
        proyecto.timestamp = Date()
        return proyecto
    }
    
    private func createTestProject2() -> Proyecto {
        let proyecto = Proyecto(context: viewContext)
        proyecto.id_proyecto = UUID()
        proyecto.ascensor = true
        proyecto.grua = false
        proyecto.subir_fachada = false
        proyecto.direccion = "Pedro Heredia 22"
        proyecto.timestamp = Date()
        return proyecto
    }

    private func createTestProduct() -> Producto {
        let producto = Producto(context: viewContext)
        producto.id_producto = UUID()
        producto.familia = "1-CORREDERAS"
        producto.nombre = "1-C2"
        producto.material = "PVC"
        producto.remates_albanileria = true
        producto.color = "Blanco"
        producto.dimensiones = "600x300 mm"
        producto.apertura = "DDI"
        producto.marco_inferior = "Abierto"
        producto.huella = "100mm"
        producto.tapajuntas = "60"
        producto.forro_exterior = "40"
        producto.cristal = "Cámara"
        producto.persiana = "Lama fija"
        producto.cerraduras = "Cerradura"
        producto.manetas = "Solo maneta interior"
        producto.herraje = "Mismo color"
        producto.posicion = "Cocina (V1)"
        producto.instalacion = "Huella obra"
        producto.curvas = "Arco"
        producto.timestamp = Date()
        return producto
    }
    
    private func createTestProduct2() -> Producto {
        let producto = Producto(context: viewContext)
        producto.id_producto = UUID()
        producto.familia = "2-PRACTICABLES"
        producto.nombre = "1-1"
        producto.material = "Aluminio"
        producto.remates_albanileria = false
        producto.color = "Negro"
        producto.dimensiones = "1000 x 2000 mm"
        producto.apertura = "DDI"
        producto.marco_inferior = "Abierto"
        producto.huella = "100 mm"
        producto.tapajuntas = "60"
        producto.forro_exterior = "40"
        producto.cristal = "Cámara"
        producto.persiana = "Lama fija"
        producto.cerraduras = "Cerradura"
        producto.manetas = "Solo maneta interior"
        producto.herraje = "Mismo color"
        producto.posicion = "Cocina (V1)"
        producto.instalacion = "Huella obra"
        producto.curvas = "Arco"
        producto.timestamp = Date()
        return producto
    }
}
