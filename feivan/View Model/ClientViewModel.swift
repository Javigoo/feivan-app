//
//  ClientViewModel.swift
//  Feivan
//
//  Created by javigo on 20/10/21.
//

import CoreData

class ClientViewModel: ObservableObject {
    private let context = PersistenceController.shared
    
    @Published var nombre: String = ""
    @Published var telefono: String = ""
    @Published var email: String = ""
    @Published var referencia: String = ""
    @Published var comentario: String = ""
    
    @Published var id: NSManagedObjectID = NSManagedObjectID()
    @Published var timestamp: Date = Date()

    @Published var clientes: [Cliente] = []
        
    // Constructores
    
    /** Actualiza la lista con los Clientes (Entidades en Core Data) **/
    init() {
        getAllClients()
    }
    
    /** Copia los datos de la entidad Cliente pasada como parámetro a la clase ClientViewModel y actualiza la lista de clientes **/
    init(client: Cliente) {
        getClient(client: client)
        getAllClients()
    }
    
    // Funciones públicas
    
    /** Crea un Cliente, copia los datos del ClientViewModel al Cliente (añadiendo el timestamp de creación), lo guarda en la DB y actualiza la lista de clientes **/
    func save() {
        let cliente = Cliente(context: context.viewContext)
        
        setClient(client: cliente)
        cliente.timestamp = timestamp
    
        context.save()
        getAllClients()
    }
    
    /** Obtiene el Cliente a partir de la ID del ClientViewModel , copia los datos del ClientViewModel al Cliente, lo guarda en la DB y actualiza la lista de clientes **/
    func update(clientVM: ClientViewModel) {
        guard let client = getClientById(id: clientVM.id) else { return }
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
    
    // Funciones privadas
    
    /** Obtiene todos los Clientes de la DB **/
    private func getAllClients() {
        let request = Cliente.fetchRequest()
        do {
            clientes = try context.viewContext.fetch(request)
            print("Clientes: \(clientes.count)")
        } catch {
            print("ERROR in ClientViewModel at getAllClients()\n")
        }
    }
    
    /** Copia los datos del Cliente al ClientViewModel **/
    private func getClient(client: Cliente) {
        nombre = client.nombre ?? nombre
        telefono = client.telefono ?? telefono
        email = client.email ?? email
        referencia = client.referencia ?? referencia
        comentario = client.comentario ?? comentario
        
        id = client.objectID
        timestamp = client.timestamp ?? timestamp
    }
    
    /** Copia los datos del ClientViewModel al Cliente**/
    private func setClient(client: Cliente) {
        client.nombre = nombre
        client.telefono = telefono
        client.email = email
        client.referencia = referencia
        client.comentario = comentario
    }
    
    /** Devuelve el Cliente que coincide con la id en la DB**/
    private func getClientById(id: NSManagedObjectID) -> Cliente? {
        do {
            return try PersistenceController.shared.container.viewContext.existingObject(with: id) as? Cliente
        } catch {
            return nil
        }
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
