//
//  ProjectViewModel.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import CoreData

class ProjectViewModel: ObservableObject {
    @Published var direccion = ""
    @Published var ascensor = false
    @Published var grua = false
    @Published var subirFachada = false
    @Published var timestamp = Date()
    @Published var proyectos: [Proyecto] = []
    
    private let context = PersistenceController.shared
    
    init() {
        getAllProjects()
    }
    
    func getAllProjects() {
        let context = PersistenceController.shared.viewContext
        let request = Proyecto.fetchRequest()
        do {
            proyectos = try context.fetch(request)
            print("Proyectos: \(proyectos.count)")

        } catch {
            print("ERROR in ProjectViewModel at getAllProjects()\n")
        }
    }
 
    func getProject(proyecto: Proyecto) {
        direccion = proyecto.direccion ?? direccion
        ascensor = proyecto.ascensor
        grua = proyecto.grua
        subirFachada = proyecto.subirFachada
    }
    
    func setProject(proyecto: Proyecto) {
        proyecto.direccion = direccion
        proyecto.ascensor = ascensor
        proyecto.grua = grua
        proyecto.subirFachada = subirFachada
    }
    
    func save() {
        let proyecto = Proyecto(context: PersistenceController.shared.viewContext)
        
        setProject(proyecto: proyecto)
        proyecto.timestamp = timestamp
    
        context.save()
        getAllProjects()
    }
    
    func update(proyecto: Proyecto) {
        setProject(proyecto: proyecto)
        
        context.save()
        getAllProjects()
    }
    
    func delete(at offset: IndexSet, for proyectos: [Proyecto]) {
        if let first = proyectos.first, case PersistenceController.shared.viewContext = first.managedObjectContext {
            offset.map { proyectos[$0] }.forEach(PersistenceController.shared.viewContext.delete)
        }
        
        context.save()
        getAllProjects()
    }
    
    func getProducts(proyecto: Proyecto) -> [Producto] {
        var productos: [Producto] = []
        if proyecto.productos != nil {
            for producto in proyecto.productos! {
                productos.append(producto as! Producto)
            }
        }
        return productos
    }
    
    func textCountProducts(project: Proyecto) -> String {
        let numProducts = countProducts(project: project)
        if (numProducts == 1) {
            return String(numProducts) + " producto"
        }
        return String(numProducts) + " productos"
    }
 
    private func countProducts(project: Proyecto) -> Int {
        var numProducts = 0
        if project.productos != nil {
            for _ in project.productos! {
                numProducts += 1
            }
        }
        return numProducts
    }
    
    func addClient(clientVM: ClientViewModel) {
        //
    }
}
