//
//  ComposicionViewModel.swift
//  Feivan
//
//  Created by javigo on 14/3/22.
//

import Foundation

class ComposicionViewModel: ObservableObject {

    private let context = PersistenceController.shared

    @Published var id_composicion: UUID = UUID()
    @Published var timestamp: Date = Date()
    @Published var tipo: String = ""
    
    @Published var productos: NSSet?
    @Published var proyecto: Proyecto?

    @Published var composiciones: [Composicion] = []
        
    init() {
        print("COMPOSICION: Composicion vacia creada")
        getAllComposiciones()

    }
    
    init(composicion: Composicion) {
        setComposicionVM(composicion: composicion)
    }
    
    private func setComposicionVM(composicion: Composicion) {
        id_composicion = composicion.id_composicion ?? id_composicion
        timestamp = composicion.timestamp ?? timestamp
        tipo = composicion.tipo ?? tipo
        productos = composicion.productos
        proyecto = composicion.proyecto
    }
    
    func getProducts() -> [ProductViewModel] {
        var productos_ret: [ProductViewModel] = []
        
        if let productos = productos {
            for producto in productos.allObjects {
                let productVM: ProductViewModel = ProductViewModel(product: producto as! Producto)
                productos_ret.append(productVM)
            }
        }
        
        return productos_ret
    }
    
    func getComposicionesOfProject(projectVM: ProjectViewModel) -> [Composicion] {
        let request = Composicion.fetchRequest()
        let project: Proyecto? = projectVM.getProject()

        var composiciones: [Composicion] = []
        var ret_composiciones: [Composicion] = []
        
        do {
            composiciones = try context.viewContext.fetch(request)
        } catch {
            print("ERROR in ProductViewModel at getComposiciones()\n")
        }
        
        for composicion in composiciones {
            if composicion.proyecto?.id_proyecto == project?.id_proyecto {
                ret_composiciones.append(composicion)
            }
        }
            
        return ret_composiciones
    }
    
    func getAllComposiciones() {
        let request = Composicion.fetchRequest()
        do {
            self.composiciones = try self.context.viewContext.fetch(request).sorted(by: { $0.timestamp ?? Date() > $1.timestamp ?? Date() })
            print("Get all composicones: ", self.composiciones.count)
        } catch {
            print("ERROR in ComposicionesViewModel at getAllComposiciones()\n")
        }
    }

    func addComposicion(projectVM: ProjectViewModel, tipo: String, productosVM: [ProductViewModel]) {
        if !tipo.isEmpty && !productosVM.isEmpty {

            let composicion = Composicion(context: context.viewContext)
            composicion.id_composicion = UUID()
            composicion.timestamp = Date()
            composicion.proyecto = projectVM.getProject()
            composicion.tipo = tipo
            
            var productos: [Producto] = composicion.productos?.allObjects as? [Producto] ?? []
            for producto in productosVM {
                let productEntity: Producto = producto.getProduct()
                productos.append(productEntity)
            }
            composicion.productos = NSSet(array: productos)
            
            context.save()
            getAllComposiciones()
        }
    }

    func delete(at offset: IndexSet, for composiciones: [Composicion]) {
        if let first = composiciones.first, case context.viewContext = first.managedObjectContext {
            offset.map { composiciones[$0] }.forEach(context.viewContext.delete)
        }
        context.save()
        getAllComposiciones()
    }
}
