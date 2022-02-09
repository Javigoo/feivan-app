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
    @Published var piso_puerta: String = ""
    @Published var ascensor: Bool = false
    @Published var grua: Bool = false
    @Published var subir_fachada: Bool = false
    @Published var remates_albanileria: Bool = false
    @Published var medidas_no_buenas: Bool = false
    @Published var timestamp: Date = Date()
    
    @Published var cliente: Cliente?
    @Published var productos: NSSet?

    @Published var proyectos: [Proyecto] = []
        
    // Constructores
    
    /** Actualiza la lista con los Proyectos (Entidades en Core Data) **/
    init() {
    }
    
    /** Copia los datos de la entidad Proyecto pasada como parámetro a la clase ProjectViewModel y actualiza la lista de proyectos **/
    init(project: Proyecto) {
        setProjectVM(project: project)
    }
    
    // Funciones públicas
    
    // CRUD
    func addProduct(productVM: ProductViewModel) {
        print("PROYECTO: Producto añadido")
        let product = productVM.getProduct()
        if productos == nil {
            productos = [product!]
        } else {
            let products = productos?.addingObjects(from: [product!])   // No añade los productos
            productos = products as NSSet?
        }
    }
    
    func addClient(clientVM: ClientViewModel) {
        print("PROYECTO: Cliente añadido")
        let client = clientVM.getClient()
        cliente = client
    }
    
    /** Crea u obtiene el Proyecto a partir de la ID del ProjectViewModel, copia los datos del ProjectViewModel al Proyecto, lo guarda en la DB y actualiza la lista de proyectos **/
    func save() {
        let project: Proyecto
        if exist() {
            print("PROYECTO: Proyecto guardado")
            project = getProject()!
        } else {
            project = Proyecto(context: context.viewContext)
            print("PROYECTO: Nuevo proyecto guardado -", id_proyecto)
            print(context)
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
        // Sort arrey from NSSet elements
        return productos.sorted(by: { $0.timestamp! > $1.timestamp! })
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
        piso_puerta = project.piso_puerta ?? piso_puerta
        ascensor = project.ascensor
        grua = project.grua
        subir_fachada = project.subir_fachada
        remates_albanileria = project.remates_albanileria
        medidas_no_buenas = project.medidas_no_buenas
        timestamp = project.timestamp ?? timestamp
        cliente = project.cliente ?? cliente
        productos = project.productos ?? productos
    }
    
    /** Copia los datos del ProjectViewModel al Proyecto **/
    private func setProject(project: Proyecto) {
        project.id_proyecto = id_proyecto
        project.direccion = direccion
        project.piso_puerta = piso_puerta
        project.ascensor = ascensor
        project.grua = grua
        project.subir_fachada = subir_fachada
        project.remates_albanileria = remates_albanileria
        project.medidas_no_buenas = medidas_no_buenas
        project.timestamp = timestamp
        project.cliente = cliente
        project.productos = productos//context.viewContext.object(with: project.objectID)
        
    }
    
    /** Devuelve el Proyecto que coincide con la id en la DB**/
    private func getProject(id: UUID) -> Proyecto? {
        let request: NSFetchRequest<Proyecto> = Proyecto.fetchRequest()
        let query = NSPredicate(format: "%K == %@", "id_proyecto", id as CVarArg)
        let sort = [NSSortDescriptor(key: "timestamp", ascending: true)]

        request.predicate = query
        request.sortDescriptors = sort

        do {
            let foundEntities: [Proyecto] = try context.viewContext.fetch(request)
            return foundEntities.first  // todo: limitar a una entidad
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
