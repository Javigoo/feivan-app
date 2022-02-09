//
//  ClientViewModel.swift
//  Feivan
//
//  Created by javigo on 20/10/21.
//

import CoreData

class ClientViewModel: ObservableObject {
    private let context = PersistenceController.shared
    
    @Published var id_cliente: UUID = UUID()
    @Published var nombre: String = ""
    @Published var telefono: String = ""
    @Published var email: String = ""
    @Published var leroy_merlin: Bool = false
    @Published var referencia: String = ""
    @Published var comentario: String = ""
    @Published var timestamp: Date = Date()

    @Published var proyectos: NSSet?
    
    @Published var clientes: [Cliente] = []
        
    // Constructores
    
    /** Actualiza la lista con los Clientes (Entidades en Core Data) **/
    init() {
    }
    
        
    /** Copia los datos de la entidad Cliente pasada como parámetro a la clase ClientViewModel y actualiza la lista de clientes **/
    init(client: Cliente) {
        setClientVM(client: client)
    }
    
    // Funciones públicas
    
    // CRUD
    
    /** Crea u obtiene el Cliente a partir de la ID del ClientViewModel, copia los datos del ClientViewModel al Cliente, lo guarda en la DB y actualiza la lista de clientes **/
    func save() {
        let client: Cliente
        if exist() {
            print("CLIENTE: Cliente guardado")
            client = getClient()!
        } else {
            print("CLIENTE: Nuevo cliente guardado")
            print(context)
            client = Cliente(context: context.viewContext)
        }
        setClient(client: client)
        context.save()
        getAllClients()
    }
    
    /** Elimina al Cliente de la DB desde una lista de clientes **/
    func delete(at offset: IndexSet, for clients: [Cliente]) {
        if let first = clients.first, case context.viewContext = first.managedObjectContext {
            offset.map { clients[$0] }.forEach(context.viewContext.delete)
        }
        
        context.save()
        getAllClients()
    }
    
    // Otras
    func exist() -> Bool {
        if getClient() == nil {
            return false
        }
        return true
    }
    
    func getClient() -> Cliente? {
        return getClient(id: id_cliente)
    }
    
    
    func addProject(projectVM: ProjectViewModel) {
        let project = projectVM.getProject()
        proyectos = [project!] // append, no remplazar
    }
    
    /** Obtiene todos los Clientes de la DB **/
    func getAllClients() {
        let request = Cliente.fetchRequest()
        do {
            clientes = try context.viewContext.fetch(request)
        } catch {
            print("ERROR in ClientViewModel at getAllClients()\n")
        }
    }
    
    // Funciones privadas
    
    /** Copia los datos del Cliente al ClientViewModel **/
    private func setClientVM(client: Cliente) {
        id_cliente = client.id_cliente ?? id_cliente
        nombre = client.nombre ?? nombre
        telefono = client.telefono ?? telefono
        email = client.email ?? email
        referencia = client.referencia ?? referencia
        leroy_merlin = client.leroy_merlin
        comentario = client.comentario ?? comentario
        timestamp = client.timestamp ?? timestamp
        proyectos = client.proyectos ?? proyectos
    }
    
    /** Copia los datos del ClientViewModel al Cliente **/
    private func setClient(client: Cliente) {
        client.id_cliente = id_cliente
        client.nombre = nombre
        client.telefono = telefono
        client.email = email
        client.referencia = referencia
        client.leroy_merlin = leroy_merlin
        client.comentario = comentario
        client.timestamp = timestamp
        client.proyectos = proyectos
    }
    
    /** Devuelve el Cliente que coincide con la id en la DB **/
    private func getClient(id: UUID) -> Cliente? {
        let request: NSFetchRequest<Cliente> = Cliente.fetchRequest()
        let query = NSPredicate(format: "%K == %@", "id_cliente", id as CVarArg)
        // todo: limitar a una entidad
        request.predicate = query
        do {
            let foundEntities: [Cliente] = try context.viewContext.fetch(request)
            return foundEntities.first
        } catch {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }

        return nil
    }

    // Getters
    
    private func getNombre() -> String {
        return nombre
    }
    
    private func getTelefono() -> String {
        return telefono
    }
    
    private func getEmail() -> String {
        return email
    }
    
    private func getComentario() -> String {
        return comentario
    }
}
