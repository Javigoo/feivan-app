//
//  ClientViewModel.swift
//  Feivan
//
//  Created by javigo on 20/10/21.
//

import CoreData

class ClientViewModel: ObservableObject {

    @Published var nombre = ""
    @Published var telefono = ""
    @Published var email = ""
    @Published var referencia = ""
    @Published var comentario = ""
    
    @Published var timestamp = Date()
    @Published var clientes: [Cliente] = []
    private let context = PersistenceController.shared
        
    init() {
        getAllClients()
    }
    
    func getAllClients() {
        let request = Cliente.fetchRequest()
        do {
            clientes = try context.viewContext.fetch(request)
            print("Clientes: \(clientes.count)")
        } catch {
            print("ERROR in ClientViewModel at getAllClients()\n")
        }
    }
    
    func getClient(cliente: Cliente) {
        nombre = cliente.nombre ?? nombre
        telefono = cliente.telefono ?? telefono
        email = cliente.email ?? email
        referencia = cliente.referencia ?? referencia
        comentario = cliente.comentario ?? comentario
    }
    
    func setClient(cliente: Cliente) {
        cliente.nombre = nombre
        cliente.telefono = telefono
        cliente.email = email
        cliente.referencia = referencia
        cliente.comentario = comentario
    }
    
    func save() {
        let cliente = Cliente(context: context.viewContext)
        
        setClient(cliente: cliente)
        cliente.timestamp = timestamp
    
        context.save()
        getAllClients()
    }
    
    func update(cliente: Cliente) {
        setClient(cliente: cliente)
        
        context.save()
        getAllClients()
    }
    
    func delete(at offset: IndexSet, for clients: [Cliente]) {
        if let first = clients.first, case PersistenceController.shared.viewContext = first.managedObjectContext {
            offset.map { clients[$0] }.forEach(PersistenceController.shared.viewContext.delete)
        }
        
        context.save()
        getAllClients()
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
