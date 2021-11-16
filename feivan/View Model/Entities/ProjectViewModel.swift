//
//  ProjectViewModel.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import CoreData

class ProjectViewModel: ObservableObject {
    private let context = PersistenceController.shared

    @Published var id_proyecto: UUID = UUID()
    @Published var direccion: String = ""
    @Published var ascensor: Bool = false
    @Published var grua: Bool = false
    @Published var subir_fachada: Bool = false
    @Published var timestamp: Date = Date()
    
    @Published var cliente: Cliente?
    @Published var productos: NSSet?

    @Published var proyectos: [Proyecto] = []
        
    // Constructores
    
    /** Actualiza la lista con los Proyectos (Entidades en Core Data) **/
    init() {
        print("New ProjectViewModel")
    }
    
    /** Copia los datos de la entidad Proyecto pasada como parámetro a la clase ProjectViewModel y actualiza la lista de proyectos **/
    init(project: Proyecto) {
        setProjectVM(project: project)
    }
    
    // Funciones públicas
    
    // CRUD
    
    // Cambiar producto con ProductViewModel
    func addProduct(product: Producto) {
        if exist() {
            let project = getProject()
            project!.productos = [product]
        }
    }
    
    /** Crea u obtiene el Proyecto a partir de la ID del ProjectViewModel, copia los datos del ProjectViewModel al Proyecto, lo guarda en la DB y actualiza la lista de proyectos **/
    func save() {
        let project: Proyecto
        if exist() {
            project = getProject()!
        } else {
            project = Proyecto(context: context.viewContext)
        }
        setProject(project: project)
        context.save()
        getAllProjects()
    }
    
    /** Elimina al Proyecto de la DB desde una lista de proyectos **/
    func delete(at offset: IndexSet, for proyectos: [Proyecto]) {
        if let first = proyectos.first, case context.viewContext = first.managedObjectContext {
            offset.map { proyectos[$0] }.forEach(context.viewContext.delete)
        }
        
        context.save()
        getAllProjects()
    }
    
    // Otras
    
    func exist() -> Bool {
        if getProject() == nil {
            return false
        }
        return true
    }
    
    func getProject() -> Proyecto? {
        return getProject(id: id_proyecto)
    }
    
    /** Obtiene todos los Proyectos de la DB **/
    func getAllProjects() {
        let request = Proyecto.fetchRequest()
        do {
            proyectos = try context.viewContext.fetch(request)
            print("Proyectos: \(proyectos.count)")

        } catch {
            print("ERROR in ProjectViewModel at getAllProjects()\n")
        }
    }
    
    func textCountProducts() -> String {
        let project = getProject()
        if project == nil {
            return String(0)
        }
        let numProducts = countProducts(project: project!)
        if (numProducts == 1) {
            return String(numProducts) + " producto"
        }
        return String(numProducts) + " productos"
    }
    
    func getProducts() -> [Producto] {
        let project = getProject()
        if project == nil {
            return []
        }
        var productos: [Producto] = []
        for producto in project!.productos! {
            productos.append(producto as! Producto)
        }
        return productos
    }
    
    func getClient() -> Cliente {
        let project = getProject()
        return project!.cliente!
    }
    
    func getClientName() -> String {
        if haveClient() {
            return getClient().nombre ?? ""
        }
        return ""
    }
    
    func haveClient() -> Bool {
        let project = getProject()

        if project != nil {
            do {
                if project!.cliente != nil {
                    let nombre = project!.cliente!.nombre
                    if nombre != nil {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    // Funciones privadas
 
    /** Copia los datos del Proyecto al ProjectViewModel **/
    private func setProjectVM(project: Proyecto) {
        id_proyecto = project.id_proyecto ?? id_proyecto
        direccion = project.direccion ?? direccion
        ascensor = project.ascensor
        grua = project.grua
        subir_fachada = project.subir_fachada
        timestamp = project.timestamp ?? timestamp
        cliente = project.cliente ?? cliente
        productos = project.productos ?? productos
    }
    
    /** Copia los datos del ProjectViewModel al Proyecto **/
    private func setProject(project: Proyecto) {
        project.id_proyecto = id_proyecto
        project.direccion = direccion
        project.ascensor = ascensor
        project.grua = grua
        project.subir_fachada = subir_fachada
        project.timestamp = timestamp
        project.cliente = cliente
        project.productos = productos
    }
    
    /** Devuelve el Proyecto que coincide con la id en la DB**/
    private func getProject(id: UUID) -> Proyecto? {
        let request: NSFetchRequest<Proyecto> = Proyecto.fetchRequest()
        let query = NSPredicate(format: "%K == %@", "id_proyecto", id as CVarArg)
        // todo: limitar a una entidad
        request.predicate = query
        do {
            let foundEntities: [Proyecto] = try context.viewContext.fetch(request)
            return foundEntities.first
        } catch {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }

        return nil
    }
 
    // Auxiliares
    
    private func countProducts(project: Proyecto) -> Int {
        var numProducts = 0
        if project.productos != nil {
            for _ in project.productos! {
                numProducts += 1
            }
        }
        return numProducts
    }
}
