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
        
    
    // TODO: Move to ComposicionVM
    
    func isEmpty() -> Bool {
        if !direccion.isEmpty { return false }
        if !piso_puerta.isEmpty { return false }
        if ascensor { return false }
        if grua { return false }
        if subir_fachada { return false }
        if remates_albanileria { return false }
        if medidas_no_buenas { return false }

        if let cliente = cliente {
            if !cliente.nombre!.isEmpty { return false }
            if !cliente.telefono!.isEmpty { return false }
            if !cliente.email!.isEmpty { return false }
            if !cliente.tipo!.isEmpty { return false }
            if !cliente.referencia!.isEmpty { return false }
            if !cliente.comentario!.isEmpty { return false }  
        }
        
        if let productos = productos {
            if productos.count > 0 { return false }
        }
        
        return true
    }
    // Constructores
    
    /** Actualiza la lista con los Proyectos (Entidades en Core Data) **/
    init() {
        print("PROYECTO: Proyecto vacio creado")
    }
    
    /** Copia los datos de la entidad Proyecto pasada como parámetro a la clase ProjectViewModel y actualiza la lista de proyectos **/
    init(project: Proyecto) {
        print("PROYECTO: Proyecto inicializado creado")
        setProjectVM(project: project)
    }
    
    // Funciones públicas
    
    // CRUD
    func addProduct(productVM: ProductViewModel) {
        print("PROYECTO: Producto añadido")
        let product = productVM.getProduct()
        if productos == nil {
            productos = [product]
        } else {
            let products = productos?.addingObjects(from: [product])   // No añade los productos
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
        DispatchQueue.main.async {
            let project: Proyecto
            if self.exist() {
                print("PROYECTO: Proyecto guardado")
                project = self.getProject()!
            } else {
                project = Proyecto(context: self.context.viewContext)
                print("PROYECTO: Nuevo proyecto guardado")
            }
            self.setProject(project: project)
            self.context.save()
            self.getAllProjects()
        }
    }
    
    /** Elimina al Proyecto de la DB desde una lista de proyectos **/
    func delete(at offset: IndexSet, for proyectos: [Proyecto]) {
        print("PROYECTO: Producto eliminado")
        if let first = proyectos.first, case context.viewContext = first.managedObjectContext {
            offset.map { proyectos[$0] }.forEach(context.viewContext.delete)
        }
        
        context.save()
        getAllProjects()
    }
    
    // Otras
    
    func exist() -> Bool {
        print("PROYECTO - exist()")
        if getProject() == nil {
            return false
        }
        return true
    }
    
    func getProject() -> Proyecto? {
        print("PROYECTO - getProject()")
        return getProject(id: id_proyecto)
    }
    
    /** Obtiene todos los Proyectos de la DB **/
    func getAllProjects() {
//        DispatchQueue.global(qos: .background).async {
//            print("PROYECTO - getAllProjects()")
//            let request = Proyecto.fetchRequest()
//            do {
//                self.proyectos = try self.context.viewContext.fetch(request).sorted(by: { $0.timestamp ?? Date() > $1.timestamp ?? Date() })
//            } catch {
//                print("ERROR in ProjectViewModel at getAllProjects()\n")
//            }
//        }
        
        DispatchQueue.main.async {
            print("PROYECTO - getAllProjects()")
            let request = Proyecto.fetchRequest()
            do {
                self.proyectos = try self.context.viewContext.fetch(request).sorted(by: { $0.timestamp ?? Date() > $1.timestamp ?? Date() })
            } catch {
                print("ERROR in ProjectViewModel at getAllProjects()\n")
            }
        }
    }
    
    func getProjectsVM() -> [ProjectViewModel] {
        var projectsVM: [ProjectViewModel] = []
        for project in proyectos {
            let projectVM: ProjectViewModel = ProjectViewModel(project: project)
            if !projectVM.isEmpty() {
                projectsVM.append(projectVM)
            } else {
                //eliminar proyecto si está vacio
                context.viewContext.delete(project)
                context.save()
            }
            
        }
        return projectsVM
    }
    
    func textCountProducts() -> String {
        print("PROYECTO - textCountProducts()")
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
        print("PROYECTO - getProducts()")
        var productos: [Producto] = []

        if let project = getProject() {
            for producto in project.productos! {
                productos.append(producto as! Producto)
            }
        }
        // Sort arrey from NSSet elements
        return productos.sorted(by: { $0.timestamp ?? Date() > $1.timestamp ?? Date() })
    }
    
    func getProductsVM() -> [ProductViewModel] {
        var productsVM: [ProductViewModel] = []
        for product in getProducts() {
            let productVM: ProductViewModel = ProductViewModel(product: product)
            productsVM.append(productVM)
        }
        return productsVM
    }
    
    func getClient() -> Cliente {
        print("PROYECTO - getClient()")
        let project = getProject()
        return project!.cliente!
    }
    
    func getClientName() -> String {
        print("PROYECTO - getClientName()")
        if haveClient() {
            return getClient().nombre ?? ""
        }
        return ""
    }
    
    func haveClient() -> Bool {
        print("PROYECTO - haveClient()")

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
        print("PROYECTO - setProjectVM()")
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
        print("PROYECTO - setProject()")

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
        project.productos = productos
    }
    

    
    /** Devuelve el Proyecto que coincide con la id en la DB**/
    private func getProject(id: UUID) -> Proyecto? {
        print("PROYECTO - getProject(id)")

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
        print("PROYECTO - countProducts()")

        var numProducts = 0
        if project.productos != nil {
            for _ in project.productos! {
                numProducts += 1
            }
        }
        return numProducts
    }
    
    
}


extension ProjectViewModel: Identifiable, Hashable {
    var identifier: String {
        return id_proyecto.uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    public static func == (lhs: ProjectViewModel, rhs: ProjectViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
